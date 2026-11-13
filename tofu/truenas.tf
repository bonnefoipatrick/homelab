resource "proxmox_virtual_environment_download_file" "truenas_iso" {
  node_name    = var.pve_node
  content_type = "iso"
  datastore_id = "local"
  url          = "https://download.sys.truenas.net/TrueNAS-SCALE-ElectricEel/24.10.2/TrueNAS-SCALE-24.10.2.iso"
  overwrite    = false
}

resource "proxmox_virtual_environment_vm" "truenas" {
  node_name = var.pve_node
  name      = "truenas"
  tags      = ["homelab", "nas"]

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 3072
  }

  # Disque système
  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = 16
    ssd          = true
  }
  # Disque de données en passthrough (adapter le device selon ton matériel)
  hostpci {
    device = "hostpci0"
    id     = "0000:00:1f.2" # ex. contrôleur/disque de données ; vérifier via: pvesh get /nodes/{node}/hardware/pci
    pcie   = false
  }

  cdrom {
    datastore_id = "local"
    file_id      = proxmox_virtual_environment_download_file.truenas_iso.id
  }

  network_device {
    bridge   = "vmbr1"
    firewall = true
  }

  # BIOS UEFI requis par TrueNAS SCALE
  bios = "ovmf"
  efi_disk {
    datastore_id = var.storage
    size         = 512
  }

  firewall_enabled = true
  started          = true
  on_boot          = true

  operating_system {
    type = "l26"
  }
}
