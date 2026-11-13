# Image nocloud Talos importée sur l'hôte PVE
# NB : le type de ressource est "download_file" ; un qcow2 est déclaré en content_type "iso"
resource "proxmox_virtual_environment_download_file" "talos_image" {
  node_name    = var.pve_node
  content_type = "iso"
  datastore_id = "local"
  url          = "https://github.com/siderolabs/talos/releases/download/${var.talos_version}/nocloud-amd64.qcow2"
  overwrite    = false
}

# VM template Talos, construite à partir de l'image importée
resource "proxmox_virtual_environment_vm" "talos_template" {
  node_name = var.pve_node
  name      = "talos-template"
  tags      = ["homelab", "talos", "template"]
  template  = true

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    file_id      = proxmox_virtual_environment_download_file.talos_image.id
    ssd          = true
    discard      = true
  }

  network_device {
    bridge = "vmbr1"
  }

  started = false
}

locals {
  talos_nodes = {
    "talos-cp1" = { ip = "172.16.32.11/24", type = "controlplane", cores = 2, mem = 2816, disk = 20 }
    "talos-w1"  = { ip = "172.16.32.12/24", type = "worker",       cores = 2, mem = 3072, disk = 40 }
    "talos-w2"  = { ip = "172.16.32.13/24", type = "worker",       cores = 2, mem = 3072, disk = 40 }
  }
}

resource "proxmox_virtual_environment_vm" "talos" {
  for_each = local.talos_nodes

  node_name = var.pve_node
  name      = each.key
  tags      = ["homelab", "talos", each.value.type]

  clone {
    vm_id        = proxmox_virtual_environment_vm.talos_template.vm_id
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
