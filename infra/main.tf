resource "google_service_account" "airflow" {
  account_id = "airflow"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "raw"
  friendly_name               = "raw"
  description                 = "This is a test description"
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
