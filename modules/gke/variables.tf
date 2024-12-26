variable "project" {
  default = ""
}

variable "gke_svc_account" {
  default = ""
}

variable "region" {
  default = "asia-south1"
}

variable "nodepool_name" {
  default = ""
}

variable "machine_type" {
  default = ""
}

variable "name" {
  type = string
  default = "donotcreatewiththisname"
}

variable "network" {
  default = ""
}
variable "subnetwork" {
  default = ""
}
variable "ip_range_pods" {
  default = ""
}
variable "ip_range_services" {
  default = ""
}

variable "horizontal_pod_autoscaling" {
  type = bool
}
variable "min_node_count" {}

variable "max_node_count" {}

variable "spot" {
  type = bool
}