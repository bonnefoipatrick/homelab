/*

terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}
*/

terraform {
  required_providers {
    ros = {
      source = "github.com/vaerh/routeros"
    }
  }
}

provider "ros" {
  hosturl  = var.router_host
  username = var.router_user
  password = var.router_pswd
}

terraform {
  required_providers {
    macaddress = {
      source = "ivoronin/macaddress"
      version = "0.3.0"
    }
  }
}