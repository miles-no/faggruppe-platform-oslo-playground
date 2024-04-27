// gke_cluster.tf
resource "google_container_cluster" "autopilot_cluster" {
  name     = "autopilot-cluster"
  location = "europe-north1"

  enable_autopilot = true
}

output "cluster_endpoint" {
  value = google_container_cluster.autopilot_cluster.endpoint
  description = "The endpoint for the Kubernetes API server."
}

output "cluster_ca_certificate" {
  value = base64decode(google_container_cluster.autopilot_cluster.master_auth[0].cluster_ca_certificate)
  description = "The public certificate that is the root of trust for the cluster."
}
