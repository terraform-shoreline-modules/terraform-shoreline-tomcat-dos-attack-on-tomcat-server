terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "dos_attack_on_tomcat_server" {
  source    = "./modules/dos_attack_on_tomcat_server"

  providers = {
    shoreline = shoreline
  }
}