# main.tf
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.61.1"
    }
  }
}

# main.tf
provider "proxmox" {
  alias    = "euclid"
  endpoint = var.euclid.endpoint
  insecure = var.euclid.insecure

  api_token = var.euclid_auth.api_token
  ssh {
    agent    = true
    username = var.euclid_auth.username
  }

  tmp_dir = "/var/tmp"
}
