
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

variable "dns_instance" {
  type = string
  description = "DNS de l'instance"
}

variable "ip_instance" {
  type = string
  description = "Adresse IP de l'instance"
}