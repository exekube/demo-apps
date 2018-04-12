/*
# Cleanup: terragrunt destroy -target=google_compute_global_address.global_static_ip
resource "google_compute_global_address" "global_static_ip" {
  name = "global-static-ip"
}

resource "google_dns_record_set" "gce_ingress_dns" {
  depends_on = ["google_dns_managed_zone.dns_zones"]

  # count      = 0
  type = "A"
  ttl  = 3600

  managed_zone = "c6ns-pw"
  name         = "*.c6ns.pw."
  rrdatas      = ["${google_compute_global_address.global_static_ip.address}"]
}

output "global_static_ip_address" {
  value = "${google_compute_global_address.global_static_ip.address}"
}
*/

