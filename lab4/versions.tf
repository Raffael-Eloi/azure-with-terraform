terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.76.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.3"
    }
  }
  # Storing terraform tfstates
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "stnvayaa14ja"
    container_name       = "tfstate"
    key                  = "devops-prod"
  }
}

provider "azurerm" {
  features {}
}
