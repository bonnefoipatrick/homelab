terraform {
  required_version = ">= 1.7.4"

  required_providers {
    proxmox = {
        source = "telmate/proxmox"
        version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_api_token_id = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret

  pm_tls_insecure = true

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }

}
