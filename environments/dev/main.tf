locals {
  env = "dev"
}

provider "google" {
  project = var.project
}

module "vpc" {
  source  = "../../modules/vpc"
  project = var.project
  env     = local.env
  subnet_01_secondary_range_01 = var.subnet_01_secondary_range_01
  subnet_01_secondary_range_02 = var.subnet_01_secondary_range_02
  secondary_range_02 = var.secondary_range_02
  secondary_range_03 = var.secondary_range_03
}

module "gke" {
  source  = "../../modules/gke"
  project = var.project
  name = var.gke_cluster_name
  nodepool_name = var.nodepool_name
  network = module.vpc.network
  subnetwork = module.vpc.subnets[0]
  ip_range_pods              = var.pod_ip_range
  ip_range_services          = var.svc_ip_range
  horizontal_pod_autoscaling = true
  machine_type = var.node_machine_type
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
  spot = var.is_spot_instance

}


resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = var.project
  service                    = each.value
  disable_on_destroy         = true
  disable_dependent_services = true
}