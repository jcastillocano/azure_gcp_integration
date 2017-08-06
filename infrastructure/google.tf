# Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.google_project}"
  region      = "${var.google_region}"
}

resource "google_compute_instance" "adminserver" {
  name         = "adminserver"
  machine_type = "f1-micro"
  zone         = "${var.google_region}"

  disk {
    image = "debian-cloud/debian-8"
  }

  network_interface {
    network       = "default"
    access_config = {}
  }
}

resource "google_sql_database_instance" "master" {
  name   = "master-instance"
  region = "europe-west1"

  settings {
    tier = "D0"
  }
}

resource "google_sql_database" "primary" {
  name     = "primary"
  instance = "${google_sql_database_instance.master.name}"
}

resource "google_sql_database" "secondary" {
  name     = "secondary"
  instance = "${google_sql_database_instance.master.name}"
}

resource "google_sql_user" "admin" {
  name     = "admin"
  instance = "${google_sql_database_instance.master.name}"
  host     = "${google_compute_instance.adminserver.network_interface.0.address}"
  password = "${var.google_sql_password}"
}

output "google_adminserver_ip" {
  value = "${google_compute_instance.adminserver.network_interface.0.access_config.0.assigned_nat_ip}"
}
