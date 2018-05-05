# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/project/modules//gke-network"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

create_static_ip_address = false

dns_zones = {}

# dns_zones = {
#   apps-exekube-us = "apps.exekube.us."
# }

dns_records = {}

# dns_records = {
#   apps-exekube-us = "*.apps.exekube.us."
# }

