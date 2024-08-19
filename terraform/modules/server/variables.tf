

variable "pm_api_url" {
  type = string
  default = "https://192.168.88.238:8006/api2/json"
}

variable "pm_api_token_id" {
  type = string
  default = "terraform@pam!token_id"
}

variable "pm_api_token_secret" {
  type      = string
  sensitive = true
  default = "5d67de61-ce4d-40d1-acba-c560d3c3d2a3"
}

variable "pm_host" {
  type = string
  default = "pve"
}

variable "ip_mgmt" {
  type = string
  description = "IP dans le VLAN Management"
}

variable "ip_vlan" {
  type = string
  description = "IP dans le VLAN Cible"
}

variable "vlan" {
  type = string
  description = "VLAN Cible"
}

variable "core" {
  type = number
  description = "Nombre de core"
}

variable "memory" {
  type = number
  description = "Taille mémoire de la VM"
}

variable "swap" {
  type = number
  description = "Taille du swap de la VM"
}

variable "size" {
  type = string
  description = "Taille du disque"
}

variable "hostname" {
  type = string
  description = "Nom de l'hôte"
}

variable "os" {
  type = string
  description = "OS de l'hôte"
}
