resource "google_service_account" "orchestrator" {
  account_id   = "orchestrator"
  display_name = "Orchestrator"
}

resource "google_project_iam_member" "orchestrator_binding" {
  project = var.gcp_project
  role    = google_project_iam_custom_role.orchestrator_role.id
  member  = google_service_account.orchestrator.member
}

resource "google_project_iam_custom_role" "orchestrator_role" {
  role_id     = "orchestrator"
  title       = "Orchestrator Role"
  description = "To be used by airflow/dbt to manage the database"
  permissions = [
    "bigquery.jobs.create",
    "bigquery.datasets.create",
  ]
}
