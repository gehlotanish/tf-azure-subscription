resource "azurerm_subscription" "main" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.main.id
  tags              = var.tags
}

resource "azurerm_role_definition" "custom" {
  for_each = {
    for role in var.custom_roles : role.name => role
  }
  name        = each.value.name
  description = each.value.description
  scope       = azurerm_subscription.main.id
  permissions {
    actions     = each.value.actions
    not_actions = each.value.not_actions
  }
  assignable_scopes = [azurerm_subscription.main.id]
}

resource "azurerm_role_assignment" "custom" {
  for_each = {
    for role in var.custom_roles : role.name => role
  }

  scope                = azurerm_subscription.main.id
  role_definition_name = each.value.name
  principal_id         = flatten([for id in each.value.principal_ids : id])
}

resource "azurerm_role_assignment" "builtin" {
  for_each = var.enable_builtin_roles ? {
    for idx, assignment in var.builtin_role_assignments :
    "${assignment.principal_id}-${assignment.role_definition_name}" => assignment
  } : {}

  scope                = azurerm_subscription.main.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}