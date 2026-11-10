terraform {
  required_version = ">= 1.7.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

provider "proxmox" {
  endpoint     = var.pve_endpoint
  api_token    = var.pve_api_token # format "user@pam!tokenid=secret"
  insecure     = true

  tmp_dir = "/var/tmp"
}
