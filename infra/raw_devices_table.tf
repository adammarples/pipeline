resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.raw_dataset.dataset_id
  table_id   = "devices"

  external_data_configuration {
    autodetect    = false
    compression   = "NONE"
    source_format = "CSV"

    source_uris = [
      "gs://${google_storage_bucket.raw_bucket.name}/devices.csv",
    ]
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "device_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "device_type",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "device_model",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  }
]
EOF

}
