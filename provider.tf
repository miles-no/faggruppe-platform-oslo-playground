// provider.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }

  }

  required_version = ">= 0.12"
}

provider "google" {
  credentials = file("credentials.json")
  project     = "asgeir"
  region      = "europe-north1"
}
