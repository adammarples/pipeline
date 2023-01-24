resource "google_bigquery_table" "raw_events" {
  dataset_id = google_bigquery_dataset.raw_dataset.dataset_id
  table_id   = "raw_events"

  external_data_configuration {
    autodetect    = false
    compression   = "NONE"
    source_format = "CSV"

    source_uris = [
      "gs://${google_storage_bucket.raw_bucket.name}/events_*.csv",
    ]
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "event_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "event_date",
    "type": "DATETIME",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "event_type",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "campaign_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "url",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "device_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  }
]
EOF

}
