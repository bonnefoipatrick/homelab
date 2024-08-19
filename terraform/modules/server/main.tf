resource "proxmox_lxc" "lxc_instance" {
  target_node = var.pm_host
}