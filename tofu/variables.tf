variable "pve_endpoint" {
  description = "URL de l'API Proxmox, ex. https://192.168.1.10:8006/"
  type        = string
}

variable "pve_api_token" {
  description = "Token API Proxmox (secret dans l'env TF_VAR_pve_api_token)"
  type        = string
  sensitive   = true
}

variable "pve_node" {
  description = "Nom du noeud Proxmox"
  type        = string
  default     = "pve"
}

variable "storage" {
  description = "Stockage Proxmox pour les disques VM"
  type        = string
  default     = "local-lvm"
}

variable "talos_version" {
  description = "Version Talos Linux, ex. v1.10.5"
  type        = string
  default     = "v1.10.5"
}

variable "admin_ssh_keys" {
  description = "Clés SSH publiques autorisées sur la VM admin"
  type        = list(string)
}

variable "lab_network" {
  description = "CIDR du réseau lab isolé"
  type        = string
  default     = "10.10.10.0/24"
}

variable "lan_bridge" {
  description = "Bridge existant vers le LAN principal"
  type        = string
  default     = "vmbr0"
}
