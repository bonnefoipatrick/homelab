resource "proxmox_virtual_environment_download_file" "debian12_image" {
  node_name    = var.pve_node
  content_type = "iso"
  datastore_id = "local"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2"
  overwrite    = false
}

# VM template Debian 12, construite à partir de l'image importée
resource "proxmox_virtual_environment_vm" "debian12_template" {
  node_name = var.pve_node
  name      = "debian12-template"
  tags      = ["homelab", "template"]
  template  = true

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    file_id      = proxmox_virtual_environment_download_file.debian12_image.id
    ssd          = true
    discard      = true
  }

  network_device {
    bridge = "vmbr1"
  }

  started = false
}

resource "proxmox_virtual_environment_file" "admin_ci_snippet" {
  content_type = "snippets"
  datastore_id = "local"
  source_raw {
    file_name = "admin-user.yml"
    data      = <<-EOF
      #cloud-config
      users:
        - name: admin
          groups: sudo
          shell: /bin/bash
          sudo: ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            ${join("
            ", formatlist("%s", var.admin_ssh_keys))}
      packages:
        - qemu-guest-agent
        - python3
    EOF
  }
}

resource "proxmox_virtual_environment_vm" "admin" {
  node_name = var.pve_node
  name      = "admin"
  tags      = ["homelab", "admin"]

  clone {
    vm_id        = proxmox_virtual_environment_vm.debian12_template.vm_id
    full         = true
    datastore_id = var.storage
  }

  cpu {
    cores = 1
    type  = "host"
  }

  memory {
    dedicated = 1536
  }

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = 20
    ssd          = true
    discard      = true
  }

  # Interface 1 : LAN (seule VM exposée, SSH protégé par le firewall PVE)
  network_device {
    bridge   = var.lan_bridge
    firewall = true
  }
  # Interface 2 : lab
  network_device {
    bridge   = "vmbr1"
    firewall = false
  }

  initialization {
    datastore_id      = "local"
    user_data_file_id = proxmox_virtual_environment_file.admin_ci_snippet.id
    ip_config {
      ipv4 {
        dhcp = true
      }
    }
    ip_config {
      ipv4 {
        address = "172.16.32.5/24"
        gateway = "172.16.32.1"
      }
    }
  }

  firewall_enabled = true
  started          = true
  on_boot          = true

  operating_system {
    type = "l26"
  }
}

# Firewall PVE : SSH uniquement depuis le LAN vers admin
resource "proxmox_virtual_environment_firewall_rules" "admin_in" {
  vm_id = proxmox_virtual_environment_vm.admin.vm_id

  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "SSH depuis le LAN"
    proto   = "tcp"
    dport   = "22"
    iface   = "net0"
  }
  rule {
    type    = "in"
    action  = "ACCEPT"
    comment = "ICMP"
    proto   = "icmp"
  }
}
