
resource "proxmox_lxc" "vault" {

  target_node = var.pm_host
  hostname = "lp100inf002"
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