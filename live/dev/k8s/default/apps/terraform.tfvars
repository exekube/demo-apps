# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//apps"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../_helm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

domain_names = {
  forms-app = "dev.react-app.c6ns.pw"
  rails-app = "dev.rails-app.c6ns.pw"
}
