
module "pm_lxc_deb" {
  source = "./modules/pm-instance"
  ipmgmt = "172.0.0.10"
  ipvlan = "172.0.8.10"
  vlan = var.vlan.infra
  core = 2
  memory = "2048"
  swap = "2048"
  size = "8G"
  hostname = "lp100dns001"
  os = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  pm_api_token_secret = var.pm_api_token_secret
  pm_api_url = var.pm_api_url
  pm_host = var.pm_host
}