data "azuread_client_config" "current" {}

resource "azuread_group" "remote_access_users" {
  display_name     = "${var.application_name}-${var.environment_name}-remote-access-users"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

# resource "azuread_group_member" "remote_access_users_membership" {
#   count = length(var.remote_access_users)

#   group_object_id  = azuread_group.remote_access_users.object_id
#   member_object_id = data.azuread_user.remove_access_users[count.index].object_id
# }

# data "azuread_user" "remove_access_users" {
#   count = length(var.remote_access_users)

#   user_principal_name = var.remote_access_users[count.index]
# }

// Using foreach
// It's a better approach because the resource is not tied to the index anymore, but the email itself

locals {
  remove_access_users_map = { for index, element in var.remote_access_users : element => index }
}
resource "azuread_group_member" "remote_access_users_membership" {
  for_each = local.remove_access_users_map

  group_object_id  = azuread_group.remote_access_users.object_id
  member_object_id = data.azuread_user.remove_access_users[each.key].object_id
}

data "azuread_user" "remove_access_users" {
  for_each = local.remove_access_users_map

  user_principal_name = each.key
}
