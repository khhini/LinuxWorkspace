resource "google_secret_manager_secret" "secret" {
  for_each = var.secrets
  secret_id = "${each.value.name}"

  replication {
    user_managed {
      replicas {
        location = var.location
      }
    }
  }
}

resource "google_secret_manager_secret_version" "version" {
  for_each = { for k, v in var.secrets : k => v if v.secret_data != null && v.secret_data != "" }
  secret =  google_secret_manager_secret.secret[each.key].id

  secret_data = each.value.secret_data
}

resource "google_secret_manager_secret_iam_binding" "secret_accessor" {
  for_each = var.secrets

  secret_id = google_secret_manager_secret.secret[each.key].id
  role = "roles/secretmanager.secretAccessor"
  members = var.secret_accessors
}
