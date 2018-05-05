terraform {
  backend "gcs" {}
}

variable "secrets_dir" {}
variable "domain_name" {}

module "guestbook" {
  source           = "/exekube-modules/helm-release"
  tiller_namespace = "kube-system"
  client_auth      = "${var.secrets_dir}/kube-system/helm-tls"

  release_name      = "guestbook"
  release_namespace = "default"
  domain_name       = "${var.domain_name}"

  chart_name = "guestbook/"
}
