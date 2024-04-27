
// gke_cluster.tf
resource "google_container_cluster" "basic_cluster" {
  name     = "basic-cluster"
  location = "europe-north1"

  initial_node_count = 3

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
  }
}
