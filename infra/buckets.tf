resource "google_storage_bucket" "raw_bucket" {
  name          = "${var.gcp_project}-raw"
  location      = "EU"
  force_destroy = true
}