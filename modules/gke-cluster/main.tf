terraform {
  backend "gcs" {}
}

variable "project_id" {}
variable "serviceaccount_key" {}

module "gke_cluster" {
  source             = "/exekube-modules/gke-cluster"
  initial_node_count = 3
  project_id         = "${var.project_id}"
  serviceaccount_key = "${var.serviceaccount_key}"
}
