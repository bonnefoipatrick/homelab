# Bridge isolé du lab : aucune interface physique, réseau interne uniquement
resource "proxmox_virtual_environment_network_linux_bridge" "lab" {
  node_name = var.pve_node
  name      = "vmbr1"
  address   = ["10.10.10.1/24"]
  comment   = "Homelab - reseau interne isole"
  autostart = true
}
