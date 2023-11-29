provider "google" {
  credentials = file("/home/vagrant/gke_tf/gke.json")
  project     = "playground-s-11-cc431801"
  region      = "us-central1"
}

resource "google_container_cluster" "my_cluster" {
  name     = "test-cluster"
  location = "us-central1-a"
  initial_node_count = 2
  master_version = "1.26.1"
  node_version = "1.26.1"
  
  node_config {
    machine_type = "e2-medium"  # Specify the "e2-instance" machine type
    disk_size_gb = 10
  }

#  master_auth {
#    username = ""
#    password = ""
#  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}