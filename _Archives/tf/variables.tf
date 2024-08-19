variable "pm_api_url" {
  type = string
}
variable "pm_api_token_id" {
  type = string
  default = "terraform@pam!token_id"
}
variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}
variable "pm_host" {
  type = string
}

variable "do_token" {}

variable "domain_name" {}

variable "router_host" {
  type = string
  description = "Host router"
  default = "http://192.168.88.1"
}

variable "router_user" {
  type = string
  description = "Utilisateur router"
  default = "admin"
}

variable "router_pswd" {
  type = string
  description = "Mot de passe router"
  default = "&p1VE28$"
}