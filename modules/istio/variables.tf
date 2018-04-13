variable "secrets_dir" {
  description = "Environment-specific directory where secrets are stored"
}

variable "load_balancer_ip" {
  description = "Regional static IP address to use for Istio ingress"
  default     = ""
}
