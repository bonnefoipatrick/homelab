
resource "proxmox_lxc" "home_assistant" {
  target_node = var.pm_host
  cores               = 2
  hostname            = "lp600dom001"
  unprivileged        = true
  memory              = 2048
  ostemplate          = var.os_lxc
  swap                = 2048
  password            = "&p1VE28$"
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
    tag = var.vlan.back
  }
  rootfs {
    size    = "16G"
    storage = "local-lvm"
  }
}
