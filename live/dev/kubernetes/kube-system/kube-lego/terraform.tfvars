# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
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

release_spec = {
  enabled = true

  tiller_namespace = "kube-system"
  namespace        = "kube-system"
  release_name     = "kube-lego"

  chart_repo    = "stable"
  chart_name    = "kube-lego"
  chart_version = "0.4.0"
}
