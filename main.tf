terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "google" {
  project     = var.GOOGLE_PROJECT
  region      = var.GOOGLE_REGION
  zone        = var.GOOGLE_ZONE
  credentials = var.GOOGLE_APPLICATION_CREDENTIALS
}
data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  name     = var.GOOGLE_CLUSTER
  location = var.GOOGLE_REGION
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

module "deployment" {
  source           = "./deployment"
  ETS_NAMESPACE    = var.ETS_NAMESPACE
}

module "service" {
  source        = "./service"
  ETS_NAMESPACE = var.ETS_NAMESPACE
}

