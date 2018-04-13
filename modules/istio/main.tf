terraform {
  backend "gcs" {}
}

# ------------------------------------------------------------------------------
# PROVIDER CONFIG
# ------------------------------------------------------------------------------

locals {
  tiller_namespace = "kube-system"
  helm_tls_dir     = "${var.secrets_dir}/${local.tiller_namespace}/_helm"
}

provider "helm" {
  namespace  = "${local.tiller_namespace}"
  enable_tls = true
  insecure   = false
  debug      = true

  ca_certificate     = "${file("${local.helm_tls_dir}/ca.cert.pem")}"
  client_certificate = "${file("${local.helm_tls_dir}/helm.cert.pem")}"
  client_key         = "${file("${local.helm_tls_dir}/helm.key.pem")}"
}

# ------------------------------------------------------------------------------
# rails-app Helm release
# ------------------------------------------------------------------------------

resource "helm_release" "istio" {
  repository = "exekube"
  chart      = "istio"
  version    = "0.5.0"

  name      = "istio"
  namespace = "istio-system"

  values = [
    "${data.template_file.istio-values.rendered}",
  ]

  force_update     = false
  devel            = false
  disable_webhooks = false
  timeout          = 700
  reuse            = true
  recreate_pods    = false
}

# Parsed (interpolated) YAML values file
data "template_file" "istio-values" {
  template = "${file("${format("%s/%s", path.module, "values/istio.yaml")}")}"

  vars {
    load_balancer_ip = "${var.load_balancer_ip}"
  }
}

resource "null_resource" "istio-tls" {
  depends_on = ["helm_release.istio"]

  provisioner "local-exec" {
    command = "kubectl apply -f ${var.secrets_dir}/kube-system/istio-tls.yaml"
  }
}

# ------------------------------------------------------------------------------
# rails-app Helm release
# ------------------------------------------------------------------------------

resource "helm_release" "cert-manager" {
  repository = "stable"
  chart      = "cert-manager"
  version    = "0.2.8"

  name      = "cert-manager"
  namespace = "kube-system"

  values = [
    "${data.template_file.cert-manager-values.rendered}",
  ]

  force_update     = false
  devel            = false
  disable_webhooks = false
  timeout          = 500
  reuse            = true
  recreate_pods    = false
}

# Parsed (interpolated) YAML values file
data "template_file" "cert-manager-values" {
  template = "${file("${format("%s/%s", path.module, "values/cert-manager.yaml")}")}"
}
