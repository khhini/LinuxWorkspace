resource "google_compute_global_address" "global_external_ip" {
  count = var.type == "global" ? 1 : 0

  name = "${var.name}-ip"  
  address_type = "EXTERNAL"
}

resource "google_compute_address" "regional_external_ip" {
  count = var.type == "regional" ? 1 : 0

  name = "${var.name}-ip"
  address_type = "EXTERNAL"
  region = var.region
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

resource "google_compute_health_check" "health_checks" {
  for_each = { for k, v in var.backends : k => v if v.service_type != "CLOUD_RUN"}

  name = "${each.value.name}-hc"

  http_health_check {
    port_specification = "USE_SERVING_PORT"
    request_path = "/"
  }
}

# resource "google_compute_region_health_check" "regional_health_check" {
#   for_each = { for k, v in var.backends : k => v if v.service_type != "CLOUD_RUN"}

#   name = "${each.value.name}-hc"

#   http_health_check {
#     port_specification = "USE_SERVING_PORT"
#     request_path = "/"
#   }
# }


# resource "google_compute_backend_service" "global_backend_services" {
#   for_each = var.backends
#   name = "${each.value.name}-be"

#   backend {
#     group = google_compute_region_network_endpoint_group.cloud_run_neg[each.key].id
#   }

#   load_balancing_scheme = "EXTERNAL_MANAGED"
#   health_checks = each.value.service_type != "CLOUD_RUN" ? [google_compute_health_check.health_checks[each.key].self_link] : null

#   log_config {
#     enable = true
#   }
# }

resource "google_compute_region_backend_service" "regional_backend_service" {
  for_each = var.backends

  region = var.region
  name = "${each.value.name}-be"

  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_neg[each.key].id
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }

  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks = each.value.service_type != "CLOUD_RUN" ? [google_compute_health_check.health_checks[each.key].self_link] : null

  log_config {
    enable = true
  }
}

# resource "google_compute_url_map" "url_map" {
#   name            = "${var.name}-lb"
#   default_service = google_compute_backend_service.backend_services[keys(var.backends)[0]].self_link

#   host_rule {
#     hosts        = ["*"]
#     path_matcher = "allpaths"
#   }

#   path_matcher {
#     name            = "allpaths"
#     default_service = google_compute_backend_service.backend_services[keys(var.backends)[0]].self_link
#   }
# }
resource "google_compute_region_url_map" "url_map" {
  region = var.region
  name            = "${var.name}-lb"
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

# resource "google_compute_target_http_proxy" "http_proxy" {
#   name = "${var.name}-lb-http-proxy"
#   url_map = google_compute_url_map.url_map.id 
# }

# resource "google_compute_target_https_proxy" "https_proxy" {
#   name = "${var.name}-lb-https-proxy"
#   url_map = google_compute_url_map.url_map.id
#   ssl_certificates = ["letsencrypt-khhini-dev"]
# }

resource "google_compute_region_target_https_proxy" "https_proxy" {
  region = var.region
  name = "${var.name}-lb-https-proxy"
  url_map = google_compute_region_url_map.url_map.id
  ssl_certificates = ["letsencrypt-khhini-cert"]
}

# resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
#   name = "${var.name}-http-forwarding-rule"
#   target = google_compute_target_https_proxy.https_proxy.id
#   port_range = 443
#   ip_address = google_compute_global_address.global_external_ip[0].id
#   ip_protocol = "TCP"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
# }
resource "google_compute_forwarding_rule" "regional_forwarding_rule" {
  name = "${var.name}-http-forwarding-rule"
  region = var.region
  target = google_compute_region_target_https_proxy.https_proxy.id
  port_range = 443
  ip_address = google_compute_address.regional_external_ip[0].id
  ip_protocol = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

# resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
#   name = "${var.name}-http-forwarding-rule"
#   target = google_compute_target_http_proxy.http_proxy.id
#   port_range = 80
#   ip_address = google_compute_global_address.global_external_ip[0].id
#   ip_protocol = "TCP"
#   load_balancing_scheme = "EXTERNAL_MANAGED"
# }
