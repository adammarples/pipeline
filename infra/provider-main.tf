terraform {
  required_version = "= 1.3.7"
}

provider "google" {
  project     = var.gcp_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region
}