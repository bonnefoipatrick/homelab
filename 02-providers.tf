terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_debug = true
  pm_log_enable = true
  pm_log_file = "log-proxmox-tf.log"
  pm_tls_insecure = true

}