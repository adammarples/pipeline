resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.raw_dataset.dataset_id
  table_id   = "events"

  external_data_configuration {
    autodetect    = false
    compression   = "NONE"
    source_format = "CSV"

    source_uris = [
      "gs://${google_storage_bucket.raw_bucket.name}/events_*.csv",
    ]
  }

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "event_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "event_date",
    "type": "DATE",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "event_type",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "campaign_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "url",
    "type": "STRING",
    "mode": "NULLABLE",
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
