resource "proxmox_vm_qemu" "dns" {
  count             = 1
  name              = "lp032dns001"
  target_node       = "${var.pm_node}"

  clone             = "ci9000deb001"
  full_clone        = true

  os_type           = "cloud-init"
  cores             = 2
  sockets           = "2"
  cpu               = "host"
  memory            = 2048
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          size            = "20G"
          storage         = "local-lvm"
          iothread        = true
        }
      }
    }
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
    tag		    = 8
  }

  network {
    model	    = "virtio"
    bridge	    = "vmbr0"
    tag		    = 32
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0	    = "ip=172.0.8.253/24,gw=172.0.8.1"
  ipconfig1         = "ip=172.0.32.253/24,gw=172.0.32.1"
  sshkeys = file("${var.ssh_key_file}")

  ciuser            = "uadm001"
  cipassword        = "&p1VE28$"

  # Déclaration du script de démarrage, en utilisant user it-anthony + clé SSH privée
  provisioner "file" {
    source      = "~/Documents/Terraform/startup.sh"
    destination = "/tmp/startup.sh"
    connection {
      type     = "ssh"
      user     = "uadm001"
      private_key     = "${file("~/.ssh/key-tools")}"
      host     = "${self.ssh_host}"
    }
  }
  # Exécution du script de démarrage
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/startup.sh",
      "/tmp/startup.sh",
    ]
    connection {
      type     = "ssh"
      user     = "uadm001"
      private_key     = "${file("~/.ssh/key-tools")}"
      host     = "${self.ssh_host}"
    }
  }
}

