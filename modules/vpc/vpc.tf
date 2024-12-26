
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 10.0"
  project_id   = var.project
  network_name = var.env

  subnets = [
    {
      subnet_name   = "${var.env}-subnet-01"
      subnet_ip     = "10.${var.env == "dev" ? 10 : 20}.10.0/24"
      subnet_region         = var.subnet_region
    },
    {
      subnet_name           = "${var.env}-subnet-02"
      subnet_ip             = "10.${var.env == "dev" ? 10 : 20}.20.0/24"
      subnet_region         = var.subnet_region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name           = "${var.env}-subnet-03"
      subnet_ip             = "10.${var.env == "dev" ? 10 : 20}.30.0/24"
      subnet_region         = var.subnet_region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]


  secondary_ranges = {
    "${var.env}-subnet-01" = [
      {
        range_name    = "gke-istio-cluster-svc-ip-range"
        ip_cidr_range = var.subnet_01_secondary_range_02
      },
      {
        range_name    = "gke-istio-cluster-pod-ip-range"
        ip_cidr_range = var.subnet_01_secondary_range_01
      },

    ]

    "${var.env}-subnet-02" = [
      {
        range_name    = "${var.env}-subnet-02-secondary-02"
        ip_cidr_range = var.secondary_range_02
      },
  ]

    "${var.env}-subnet-03" = [
      {
        range_name    = "${var.env}-subnet-03-secondary-03"
        ip_cidr_range = var.secondary_range_03
      },
    ]

  }
  # routes = [
  #   {
  #     name                   = "egress-internet"
  #     description            = "route through IGW to access internet"
  #     destination_range      = "0.0.0.0/0"
  #     tags                   = "egress-inet"
  #     next_hop_internet      = "true"
  #   },
  #   {
  #     name                   = "app-proxy"
  #     description            = "route through proxy to reach app"
  #     destination_range      = "10.50.10.0/24"
  #     tags                   = "app-proxy"
  #     next_hop_instance      = "app-proxy-instance"
  #     next_hop_instance_zone = "${var.subnet_region}-a"
  #   },
  # ]
}