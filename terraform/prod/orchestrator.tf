resource "google_service_account" "orchestrator" {
  account_id   = "orchestrator"
  display_name = "Orchestrator"
}

resource "google_project_iam_member" "orchestrator_role_binding" {
  project = var.gcp_project
  role    = "roles/bigquery.admin"
  member  = google_service_account.orchestrator.member
}

