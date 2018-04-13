# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//bookinfo"
  }

  dependencies {
    paths = [
      "../../kube-system/istio",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

