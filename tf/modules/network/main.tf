resource "get_ip_vlan" "ip_in_vlan" {


}

resource "routeros_dhcp_server_lease" "set_dhcp_lease" {
  address     = ""
  mac_address = ""
}

resource "routeros_ip_dns_record" "set_dns_for_instance" {
  name    = var.dns_instance
  address = var.ip_instance
  type    = "A"
}

resource "routeros_dhcp_server_lease" "dhcp_server_leaser" {
  address     = ""
  mac_address = ""
  dynamic = false
}

resource "macaddress" "example_address" {
}

// Terraform Mikrotik Provider - https://github.com/ddelnano/terraform-provider-mikrotik
resource "mikrotik_dhcp_lease" "example_lease" {
  address    = "10.0.0.10"
  macaddress = upper(macaddress.example_address.address)
  comment    = "Example DHCP Lease"
}