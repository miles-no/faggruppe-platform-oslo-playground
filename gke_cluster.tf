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

resource "null_resource" "update_kubectl" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
kubectl config set-cluster ${google_container_cluster.autopilot_cluster.name} --server=https://${self.triggers.cluster_endpoint} --certificate-authority=${self.triggers.cluster_ca_certificate} --embed-certs=true
kubectl config set-credentials ${google_container_cluster.autopilot_cluster.name}-user --client-key=${self.triggers.client_key} --client-certificate=${self.triggers.client_certificate}
kubectl config set-context ${google_container_cluster.autopilot_cluster.name} --cluster=${google_container_cluster.autopilot_cluster.name} --user=${google_container_cluster.autopilot_cluster.name}-user
kubectl config use-context ${google_container_cluster.autopilot_cluster.name}
EOT

    environment = {
      cluster_endpoint       = google_container_cluster.autopilot_cluster.endpoint
      cluster_ca_certificate = base64decode(google_container_cluster.autopilot_cluster.master_auth[0].cluster_ca_certificate)
      client_key             = base64decode(google_container_cluster.autopilot_cluster.master_auth[0].client_key)
      client_certificate     = base64decode(google_container_cluster.autopilot_cluster.master_auth[0].client_certificate)
    }
  }
}
