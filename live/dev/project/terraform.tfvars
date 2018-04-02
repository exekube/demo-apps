# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gcp-project"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

dns_zones = {
  "c6ns-pw" = "c6ns.pw."
}

dns_records = {
  "c6ns-pw" = "*.c6ns.pw."
}
