resource "google_bigquery_table" "raw_campaigns" {
  dataset_id = google_bigquery_dataset.raw_dataset.dataset_id
  table_id   = "campaigns"

  external_data_configuration {
    autodetect    = false
    compression   = "NONE"
    source_format = "CSV"

    source_uris = [
      "gs://${google_storage_bucket.raw_bucket.name}/campaigns_*.csv",
    ]
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "campaign_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "campaign_name",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "campaign_start_date",
    "type": "DATE",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "campaign_end_date",
    "type": "DATE",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "campaign_duration",
    "type": "INTEGER",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "campaign_budget",
    "type": "NUMERIC",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "campaign_target_state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  }
]
EOF

}
