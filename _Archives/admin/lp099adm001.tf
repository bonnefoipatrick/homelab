provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "https://proxmox.org/api2/json"
  pm_password = "supersecret"
  pm_user = "terraform-prov@pve"
  pm_otp = ""
}

resource "proxmox_lxc" "lxc-test" {
  features {
    nesting = true
  }
  hostname = "terraform-new-container"
  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    ip6 = "dhcp"
  }
  ostemplate = "shared:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password = "rootroot"
  pool = "terraform"
  target_node = "node-01"
  unprivileged = true
}