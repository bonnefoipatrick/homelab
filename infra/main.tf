terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.88.238:8006/api2/json"
  pm_api_token_id = "terraform@pam!token_id"
  pm_api_token_secret = "5d67de61-ce4d-40d1-acba-c560d3c3d2a3"
}

resource "proxmox_lxc" "lxc-test" {
  target_node = "proxmox"
  hostname = "lxc-test"
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
  }

  rootfs {
    size    = "8G"
    storage = "local-lvm"
  }
}