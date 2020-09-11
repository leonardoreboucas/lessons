# Create a VM instance
provider "google" {
  credentials = file("../credentials.json")
  project     = "aulas-288410"
  region      = "us-central1"
}


resource "google_compute_instance" "give-a-name-to-you-instance" {
  name         = "give-a-name-to-you-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}