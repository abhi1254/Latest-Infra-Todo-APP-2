terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backendrg"
    storage_account_name = "backendstorge"
    container_name       = "backendcontainer"
    key                  = "prod.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "38411600-15ea-4ef6-ba0b-f7b76456b2f3"
}
