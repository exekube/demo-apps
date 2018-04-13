# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//cert-manager"
  }

  dependencies {
    paths = [
      "../istio",
      "../cluster-admin",
      "../_helm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

