# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
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

# Module configuration

release_spec = {
  enabled          = true
  release_name     = "forms-app"
  tiller_namespace = "default"
  namespace        = "default"

  chart_repo = "exekube"
  chart_name = "nginx-react"

  domain_name = "dev.react-app.c6ns.pw"
}
