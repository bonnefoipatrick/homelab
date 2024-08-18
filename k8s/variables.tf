# variables.tf
variable "euclid" {
  description = "Euclid Proxmox server configuration"
  type        = object({
    node_name = string
    endpoint  = string
    insecure  = bool
  })
}
# variables.tf
variable "euclid_auth" {
  description = "Euclid Proxmox server auth"
  type        = object({
    username  = string
    api_token = string
  })
  sensitive = true
}
