resource "azapi_resource" "rg" {
  type     = "Microsoft.Resources/resourceGroups@2021-04-01"
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location

  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
}

data "azapi_client_config" "current" {}

resource "azapi_resource" "vm_pip" {
  type      = "Microsoft.Network/publicIPAddresses@2024-05-01"
  name      = "pip-${var.application_name}-${var.environment_name}"
  location  = azapi_resource.rg.location
  parent_id = azapi_resource.rg.id

  body = {
    properties = {
      publicIPAllocationMethod = " Static"
      publicIPAddressVersion   = "IPv4"
    }
    sku = {
      name = "Standard"
    }
  }
}

data "azapi_resource" "network_rg" {
  name      = "rg-network-prod"
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  type      = "Microsoft.Resources/resourceGroups@2021-04-01"
}

data "azapi_resource" "vnet" {
  name      = "vnet-network-prod"
  parent_id = data.azapi_resource.network_rg.id
  type      = "Microsoft.Resources/virtualNetworks@2025-07-01"
}

data "azapi_resource" "subnet_bravo" {
  name      = "snet-bravo"
  parent_id = data.azapi_resource.vnet.id
  type      = "Microsoft.Network/virtualNetworks/subnets@2025-07-01"

  response_export_values = ["name"]
}

resource "azapi_resource" "vm1_nic" {
  name      = "nic-${var.application_name}-${var.environment_name}"
  parent_id = data.azapi_resource.vnet.id
  location  = azapi_resource.rg.location
  type      = "Microsoft.Network/networkInterfaces@2024-05-01"

  body = {
    properties = {
      ipConfigurations = [
        {
          name = "public"
          properties = {
            privateIPAllocationMethod = "Dynamic"
            publicIPAddress = {
              id = azapi_resource.vm_pip.id
            }
            subnet = {
              id = data.azapi_resource.subnet_bravo.id
            }
          }
        }
      ]
    }
  }
}
