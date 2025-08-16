terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file("/home/aiops4352/terraform-key.json")
  project     = "citric-sprite-469211-u4"   # <-- replace with your project ID
  region      = "us-central1"
}

# ✅ Create GCS Bucket
resource "google_storage_bucket" "my_bucket" {
  name          = "terraform-demo-bucket-4352"   # must be globally unique
  location      = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}

