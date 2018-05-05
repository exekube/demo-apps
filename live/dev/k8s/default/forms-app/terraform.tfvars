# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//forms-app"
  }

  dependencies {
    paths = [
      "../../kube-system/cert-manager",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

domain_name = "dev.forms-app.apps.exekube.us"
