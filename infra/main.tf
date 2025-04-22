provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "static_site" {
  name          = var.bucket_name
  location      = var.region
  website {
    main_page_suffix = "index.html"
  }
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}
