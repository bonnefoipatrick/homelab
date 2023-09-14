
resource "pm_lxc_deb" "instance" {

  target_node = var.pm_host
  hostname = var.hostname
  unprivileged = true
  cores = var.core
  memory = var.memory
  swap = var.swap
  ostemplate = var.os
  password = "password"
  start = true

  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "static"
    tag = var.vlan.mgmt
  }

  network {
    name = "eth1"
    bridge = "vmbr0"
    ip = "dhcp"
    tag = var.vlan.infra
  }

  rootfs {
    size    = var.size
    storage = "local-lvm"
  }

  container_id = id
}

resource "proxmox_lxc" "lxc" {
  target_node = ""

  network {
    name = ""
  }
}