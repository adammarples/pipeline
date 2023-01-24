resource "google_storage_bucket" "raw_bucket" {
  name          = "${var.gcp_project}-raw"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket" "tf_state" {
  name          = "${var.gcp_project}-tf-state"
  location      = "EU"
  force_destroy = false
}
