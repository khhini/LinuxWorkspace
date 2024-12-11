output "ilb_network_id" {
  value = google_compute_network.ilb_network.id
}

output "ilb_subnetwork_id" {
  value = google_compute_subnetwork.ilb_subnet.id
  
}

output "ilb_ip" {
  value = google_compute_forwarding_rule.google_compute_forwarding_rule.ip_address
}
