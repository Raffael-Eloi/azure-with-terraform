terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.76.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
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
    key                  = "linuxvm-prod"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_secrets = true
    }
  }
}
