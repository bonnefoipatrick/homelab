variable "environment" {
  type = string
  description = "Le nom de l'environnement"
  default = "prod"
}

variable "pm_api_url" {
  type = string
  description = "URL de l'URL de ProxMox"
  default = "https://192.168.88.238:8006/api2/json"
}

variable "pm_api_token_id" {
  type = string
  default = "terraform@pam!token_id"
  description = "Id du token de ProxMox pour l'utilisateur Terraform"
}

variable "pm_api_token_secret" {
  type      = string
  sensitive = true
  description = "Secret du token de ProxMox pour l'utilisateur Terraform"
  default = "5d67de61-ce4d-40d1-acba-c560d3c3d2a3"
}

variable "pm_host" {
  type = string
  default = "pve"
}

variable "os_lxc" {
  type = string
  description = "OS du container LXC"
  default = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
}


variable "vlan" {
  type      = map(string)
  default = {
    "mgmt" = 99
    "infra" = 100
    "front" = 500
    "back" = 600
  }
}