terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.88.238:8006/api2/json"
}

resource "proxmox_lxc" "lxc-test" {
  hostname = "lxc-test-host"
  cores = 2
  memory = "2048"
  swap = "2048"
  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
  }

  ostemplate = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password = "&p1VE28$"

  pool = "terraform"

  target_node = "proxmox"
  unprivileged = true
  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }
}