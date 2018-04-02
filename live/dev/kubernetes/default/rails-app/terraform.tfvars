# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../../kube-system/ingress-controller",
      "../../kube-system/kube-lego",
      "../_helm",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

release_spec = {
  enabled          = false
  release_name     = "rails-app"
  namespace        = "default"
  tiller_namespace = "default"

  chart_repo = "exekube"
  chart_name = "rails-app"

  domain_name = "dev.rails-app.c6ns.pw"
}
