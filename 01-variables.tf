
variable "pm_host" {
  type = string
}

variable "ipmgmt" {
  type = string
  description = "IP dans le VLAN Management"
}

variable "ipvlan" {
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
