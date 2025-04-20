resource "azurerm_subscription" "main" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.main.id

  tags = var.tags
}

resource "azurerm_role_definition" "custom" {
  count       = var.create_custom_role ? 1 : 0
  name        = var.custom_role_name
  scope       = azurerm_subscription.main.id
  description = var.custom_role_description

  permissions {
    actions     = var.custom_role_actions
    not_actions = var.custom_role_not_actions
  }

  assignable_scopes = [
    azurerm_subscription.main.id
  ]
}

resource "azurerm_role_assignment" "main" {
  for_each = {
    for idx, role in var.role_assignments :
    "${idx}-${role.principal_id}" => role
  }

  scope = azurerm_subscription.main.id

  role_definition_name = (
    try(each.value.use_custom_role, false) && var.create_custom_role
    ? azurerm_role_definition.custom[0].name
    : each.value.role_definition_name
  )

  principal_id = each.value.principal_id

}


