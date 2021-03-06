# Install a Simple CRUD app
provider "google" {
  credentials = file("../credentials.json")
  project     = "reboucas-lessons"
  region      = "us-central1"
}

resource "random_string" "random" {
  length = 4
  special = false
  upper = false
}

resource "google_compute_instance" "give-a-name-to-your-instance" {
  name         = "give-a-name-to-your-instance-${random_string.random.result}"
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

  metadata_startup_script = "curl https://raw.githubusercontent.com/leonardoreboucas/lessons/master/cloud/orchestrators/terraform/lesson5/initial_script.sh | sh 2>> /var/log/start-script.log"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}