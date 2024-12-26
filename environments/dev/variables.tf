variable "project" {}
variable "activate_apis" {
  description = "Service APIs to enable."
  type        = list(string)
  default     = []
}

variable "subnet_01_secondary_range_01" {
  default = ""
}
variable "subnet_01_secondary_range_02" {
  default = ""
}
variable "secondary_range_02" {
  default = ""
}
variable "secondary_range_03" {
  default = ""
}

variable "gke_svc_account" {
  default = ""
}
variable "region" {
  default = "asia-south1"
}

//GKE Cluster config

variable "gke_cluster_name" {
  default = "test"
}

variable "nodepool_name" {
  default = "bookinfo-pool"
}

variable "node_machine_type" {
  default = "e2-medium"
}

variable "node_image_type" {}

variable "is_spot_instance" {
  type = bool
}
variable "min_node_count" {
  default = 1
  type    = number
}


variable "max_node_count" {
  default = 1
  type    = number
}

variable "disk_size_gb" {
  default = "10"
  type    = number
}

variable "svc_ip_range" {
  default = ""
}
variable "pod_ip_range" {
  default = ""
}

variable "enable_horizontal_pod_autoscaling" {
  type = bool
}