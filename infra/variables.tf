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
variable "vlan" {
  type      = map(string)
  default = {
    "mgmt" = 99
    "infra" = 100
    "front" = 500
    "back" = 600
  }
}