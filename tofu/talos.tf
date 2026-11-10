# Image nocloud Talos importée sur l'hôte PVE
resource "proxmox_virtual_environment_download" "talos" {
  node_name    = var.pve_node
  content_type = "iso"
  url          = "https://github.com/siderolabs/talos/releases/download/${var.talos_version}/nocloud-amd64.qcow2"
  overwrite    = false
  datastore_id = "local"
}

locals {
  talos_nodes = {
    "talos-cp1" = { ip = "10.10.10.11/24", type = "controlplane", cores = 2, mem = 2816, disk = 20 }
    "talos-w1"  = { ip = "10.10.10.12/24", type = "worker",       cores = 2, mem = 3072, disk = 40 }
    "talos-w2"  = { ip = "10.10.10.13/24", type = "worker",       cores = 2, mem = 3072, disk = 40 }
  }
}

resource "proxmox_virtual_environment_vm" "talos" {
  for_each = local.talos_nodes

  node_name = var.pve_node
  name      = each.key
  tags      = ["homelab", "talos", each.value.type]

  clone {
    vm_id        = proxmox_virtual_environment_download.talos.vm_id
    full         = true
    datastore_id = var.storage
  }

  cpu {
    cores = each.value.cores
    type  = "host"
  }

  memory {
    dedicated = each.value.mem
  }

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = each.value.disk
    ssd          = true
    discard      = true
  }

  network_device {
    bridge   = "vmbr1"
    firewall = true
  }

  firewall_enabled = false # pas d'interface LAN, le noeud vit uniquement dans le lab

  started = true
  on_boot = true

  agent {
    enabled = false
  }

  operating_system {
    type = "l26"
  }

  depends_on = [proxmox_virtual_environment_network_linux_bridge.lab]
}
