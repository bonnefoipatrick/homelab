terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
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

resource "proxmox_lxc" "dns" {

  target_node = var.pm_host
  hostname = "lp100dns001"
  unprivileged = true
  cores = 2
  memory = "2048"
  swap = "2048"
  ostemplate = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password = "password"
  start = true

  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    tag = var.vlan.mgmt
  }

  network {
    name = "eth1"
    bridge = "vmbr0"
    ip = "dhcp"
    tag = var.vlan.infra
  }

  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }
}