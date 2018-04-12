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

# ↓ Module configuration (empty means all default)

chart_repo = {
  name = "exekube"
  url  = "https://exekube.github.io/charts"
}

release_spec = {
  enabled       = true
  namespace     = "kube-system"
  release_name  = "cluster-admin"
  chart_repo    = "exekube"
  chart_name    = "cluster-admin"
  chart_version = "0.2.0"
}
