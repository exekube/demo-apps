terraform {
  backend "gcs" {}
}

# ------------------------------------------------------------------------------
# PROVIDER CONFIG
# ------------------------------------------------------------------------------

locals {
  helm_tls_dir = "${var.secrets_dir}/default/_helm"
}

provider "helm" {
  namespace  = "default"
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

resource "helm_release" "rails-app" {
  repository = "exekube"
  chart      = "rails-app"
  version    = "1.0.0"

  name      = "rails-app"
  namespace = "default"

  values = [
    "${data.template_file.rails-app-values.rendered}",
  ]

  force_update     = false
  devel            = false
  disable_webhooks = false
  timeout          = 500
  reuse            = true
  recreate_pods    = false
}

# Parsed (interpolated) YAML values file
data "template_file" "rails-app-values" {
  template = "${file("${format("%s/%s", path.module, "values/rails-app.yaml")}")}"

  vars {
    domain_name = "${var.domain_names["rails-app"]}"
  }
}

# ------------------------------------------------------------------------------
# forms-app Helm release
# ------------------------------------------------------------------------------

resource "helm_release" "forms-app" {
  repository = "exekube"
  chart      = "nginx-react"
  version    = "0.1.0"

  name      = "forms-app"
  namespace = "default"

  values = [
    "${data.template_file.forms-app-values.rendered}",
  ]

  force_update     = false
  devel            = false
  disable_webhooks = false
  timeout          = 500
  reuse            = true
  recreate_pods    = false
}

# Parsed (interpolated) YAML values file
data "template_file" "forms-app-values" {
  template = "${file("${format("%s/%s", path.module, "values/forms-app.yaml")}")}"

  vars {
    domain_name = "${var.domain_names["forms-app"]}"
  }
}
