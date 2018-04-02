# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gke-cluster"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

