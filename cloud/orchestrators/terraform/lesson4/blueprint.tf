# Make Apache acessible via external IP and firewall rules
provider "google" {
  credentials = file("../credentials.json")
  project     = "aulas-288410"
  region      = "us-central1"
}

resource "google_compute_instance" "give-a-name-to-you-instance" {
  name         = "give-a-name-to-you-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["http-server", "https-server"]

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
     access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y apache2"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}