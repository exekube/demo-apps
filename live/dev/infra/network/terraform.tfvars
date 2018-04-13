# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gke-network"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

# create_static_ip_address = true

dns_zones = {
  "c6ns-pw" = "c6ns.pw."
}

dns_records = {
  "c6ns-pw" = "*.c6ns.pw."
}
