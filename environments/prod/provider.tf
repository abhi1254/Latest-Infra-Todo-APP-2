terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  
  # backend "azurerm" {
  #   resource_group_name  = "backendrg"
  #   storage_account_name = "backendstorge"
  #   container_name       = "tfstate"
  #   key                  = "prod.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "38411600-15ea-4ef6-ba0b-f7b76456b2f3"
}
