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

# 🔎 Get the latest Ubuntu 22.04 LTS image
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# ✅ VM instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 10
    }
  }

  network_interface {
    network = "default"   # use default network
    access_config {}      # allocate external IP
  }

  metadata = {
    ssh-keys = "aiops4352:${file("~/.ssh/id_rsa.pub")}"  # use your SSH pub key
  }
}

