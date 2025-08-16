
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  credentials = file("/home/aiops4352/terraform-key.json")
  project     = "citric-sprite-469211-u4"   # replace with your project ID
  region      = "us-central1"
}

# Create a custom VPC network
resource "google_compute_network" "aiops_vpc" {
  name                    = "aiops-vpc"
  auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "aiops_subnet" {
  name          = "aiops-subnet"
  region        = "us-central1"
  network       = google_compute_network.aiops_vpc.id
  ip_cidr_range = "10.0.0.0/24"
}

# Firewall rule
resource "google_compute_firewall" "aiops_firewall" {
  name    = "aiops-allow-ssh-http"
  network = google_compute_network.aiops_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

