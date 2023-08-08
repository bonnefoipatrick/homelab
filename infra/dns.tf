terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=2.9.14"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "https://192.168.88.238:8006/api2/json"
  pm_user = "terraform@pam"
  pm_password = "&p1VE28$"
  pm_debug = true
}

resource "proxmox_lxc" "lxc-test" {
  hostname = "lxc-test-host"
  cores = 1
  memory = "1024"
  swap = "2048"
  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
  }
  ostemplate = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password = "&p1VE28$"
  pool = "terraform"
  rootfs = "local-lvm2:8"
  storage = "local-lvm2"
  target_node = "proxmox"
  unprivileged = true
}