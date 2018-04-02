# Cleanup: terragrunt destroy -target=google_compute_global_address.global_static_ip
resource "google_compute_global_address" "global_static_ip" {
  name = "global-static-ip"
}

output "global_static_ip_address" {
  value = "${google_compute_global_address.global_static_ip.address}"
}
