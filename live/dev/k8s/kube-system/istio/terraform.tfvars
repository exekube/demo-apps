# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//istio"
  }

  dependencies {
    paths = [
      "../cluster-admin",
      "../_helm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

load_balancer_ip = "35.187.107.8"
