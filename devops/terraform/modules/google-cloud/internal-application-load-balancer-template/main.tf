resource "google_compute_network" "ilb_network" {
  name = "l7-ilb-network"
}

resource "google_compute_subnetwork" "ilb_subnet" {
  name = "l7-ilb-subnet"
  network = google_compute_network.ilb_network.id
  region = var.region
  ip_cidr_range = "172.16.10.0/24"
}

resource "google_compute_subnetwork" "proxy_subnet" {
  name = "l7-ilb-proxy-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region = var.region
  purpose = "REGIONAL_MANAGED_PROXY"
  role = "ACTIVE"
  network = google_compute_network.ilb_network.id
}

resource "google_compute_region_network_endpoint_group" "cloud_run_neg" {
  for_each = { for k, v in var.backends : k => v if v.service_type == "CLOUD_RUN"}

  name = "${each.value.name}-neg"
  network_endpoint_type = "SERVERLESS"
  
  cloud_run {
    service = each.value.service_name
  }
  
  region = each.value.region
}

resource "google_compute_region_backend_service" "regional_backend_service" {
  for_each = var.backends

  region = var.region
  name = "${each.value.name}-be"

  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_neg[each.key].id
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }

  load_balancing_scheme = "INTERNAL_MANAGED"

  log_config {
    enable = true
  }
}

resource "google_compute_region_url_map" "default" {
  name = "l7-ilb-regional-url-map"
 
  region = var.region
  default_service = google_compute_region_backend_service.regional_backend_service[keys(var.backends)[0]].self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_region_backend_service.regional_backend_service[keys(var.backends)[0]].self_link
  }
}

resource "google_compute_region_target_http_proxy" "default" {
  name = "l7-ilb-target-http-proxy"
  region = var.region
  url_map = google_compute_region_url_map.default.id 
  
}

resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name = "l7-ilb-forwarding-rule"
  region = var.region
  depends_on = [ google_compute_subnetwork.proxy_subnet ]

  ip_protocol = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range = "80"

  target = google_compute_region_target_http_proxy.default.id
  network = google_compute_network.ilb_network.id
  subnetwork = google_compute_subnetwork.ilb_subnet.id
  network_tier = "PREMIUM"

}
