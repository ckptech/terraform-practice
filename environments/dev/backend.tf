terraform {
  backend "gcs" {
    bucket = "ckp-istio-tf-tfstate"
    prefix = "env/dev"
  }
}