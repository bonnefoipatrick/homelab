output "container_id" {
  value = pm_lxc_deb.instance.container_id
  description = "Id du container"
}


ouput "ip_mgmt_affected" {
  value = pm_lxc_deb.instance
  description = "IP Management"
}

ouput "ip_vlan_affected" {
  value = pm_lxc_deb.instance.for_each
  description = "IP in VLAN"
}