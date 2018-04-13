variable "domain_names" {
  type        = "map"
  description = "Domain names for the apps"
}

variable "secrets_dir" {
  description = "Environment-specific directory where secrets are stored"
}
