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
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
