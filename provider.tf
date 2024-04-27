// provider.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }

    onepassword = {
      source = "1Password/onepassword"
      version = "~> 1.0"
    }
  }

  required_version = ">= 0.12"
}

provider "onepassword" {
  # Configuration parameters such as subdomain, email, and secret key might go here.
  # Often environment variables are used for these to keep them out of code.
}

data "onepassword_item" "gcp_credentials" {
  vault = "zpz2s4pe2j4a6s7ly3ndcmbonq"
  title = "GCP Credentials"
}

provider "google" {
  credentials = jsondecode(base64decode(data.onepassword_item.gcp_credentials.documents[0].content))
  project     = "asgeir"
  region      = "europe-north1"
}
