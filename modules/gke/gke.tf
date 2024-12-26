data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}



module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "35.0.0"
  project_id                 = var.project
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false
  name = var.name
  region = var.region
  zones                      = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  network = var.network
  subnetwork = var.subnetwork
  ip_range_pods = var.ip_range_pods
  ip_range_services = var.ip_range_services


  node_pools = [
    {
      name                        = var.nodepool_name
      machine_type                = var.machine_type
      enable_gcfs                 = false
      enable_gvnic                = false
      logging_variant             = "DEFAULT"
      auto_repair                 = true
      auto_upgrade                = true
      service_account             = var.gke_svc_account
      preemptible                 = false
      initial_node_count          = 1
      spot = var.spot
      # max_node_count = var.max_node_count
      # min_node_count = var.min_node_count
    },
  ]


  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }


  node_pools_labels = {
    all = {}


    default-node-pool = {
      default-node-pool = false
    }
  }


  node_pools_metadata = {
    all = {}


    default-node-pool = {
      node-pool-metadata-custom-value = "def-node-pool"
    }
  }


  node_pools_taints = {
    all = []


    default-node-pool = [
      {
        key    = "def-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }
}
