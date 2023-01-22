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

resource "google_bigquery_dataset" "staging_dataset" {
  dataset_id                  = "staging"
  friendly_name               = "staging"
  description                 = "Staging dataset for raw data"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.orchestrator.email
  }

}

moved {
  from = google_bigquery_dataset.dataset
  to = google_bigquery_dataset.staging_dataset
}

resource "google_bigquery_dataset" "vault_dataset" {
  dataset_id                  = "vault"
  friendly_name               = "vault"
  description                 = "Curated dataset for vault data"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.orchestrator.email
  }

}

resource "google_storage_bucket" "raw_bucket" {
  name          = "${var.gcp_project}-raw"
  location      = "EU"
  force_destroy = true
}