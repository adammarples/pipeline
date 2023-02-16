resource "google_bigquery_table" "raw_patients" {
  dataset_id = google_bigquery_dataset.raw_dataset.dataset_id
  table_id   = "raw_patients"

  external_data_configuration {
    autodetect    = false
    compression   = "NONE"
    source_format = "CSV"

    source_uris = [
      "gs://${google_storage_bucket.raw_bucket.name}/patients_*.csv",
    ]
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "name",
    "type": "DATETIME",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "address_line_1",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "address_line_2",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "city",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": ""
  },{
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  },{
    "name": "zip",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": ""
  }
]
EOF

}
