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
# Cert Manager Helm Release
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

resource "null_resource" "cluster-issuer" {
  depends_on = ["helm_release.cert-manager"]

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/certmanager/issuer-le-stg.yaml"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete -f ${path.module}/certmanager/issuer-le-stg.yaml"
  }
}

resource "null_resource" "test-cert" {
  depends_on = ["null_resource.cluster-issuer"]

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/certmanager/cert-bookinfo-stg.yaml"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete -f ${path.module}/certmanager/cert-bookinfo-stg.yaml"
  }
}
