resource "google_service_account" "airflow" {
  account_id   = "airflow"
  display_name = "Airflow"
}

resource "google_bigquery_dataset" "dataset" {
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
    user_by_email = google_service_account.airflow.email
  }

}
