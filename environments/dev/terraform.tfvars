project = "ckp-istio-tf"
activate_apis = ["compute.googleapis.com",
  "iam.googleapis.com",
  "serviceusage.googleapis.com",
  "cloudbilling.googleapis.com",
  "iamcredentials.googleapis.com",
  "container.googleapis.com"
]

subnet_01_secondary_range_01="192.168.32.0/24"
subnet_01_secondary_range_02= "192.168.64.0/24"
secondary_range_02= "192.168.128.0/24"
secondary_range_03= "192.168.192.0/24"

gke_svc_account = "project-service-account@ckp-istio-tf.iam.gserviceaccount.com"
## GKE configuration
gke_cluster_name                  = "gke-istio-cluster"
nodepool_name                     = "bookinfo-nodepool"
min_node_count                    = 1
max_node_count                    = 3
is_spot_instance                  = true
svc_ip_range                      = "gke-istio-cluster-svc-ip-range"
pod_ip_range                      = "gke-istio-cluster-pod-ip-range"
node_machine_type                 = "e2-medium"
disk_size_gb                      = 100
node_image_type                   = "COS_CONTAINERD"
enable_horizontal_pod_autoscaling = true