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
