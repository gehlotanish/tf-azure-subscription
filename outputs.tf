output "subscription_id" {
  description = "The ID of the created Azure subscription."
  value       = azurerm_subscription.main.id
}

output "subscription_name" {
  description = "The name of the created Azure subscription."
  value       = azurerm_subscription.main.subscription_name
}

output "custom_role_name" {
  description = "Name of the custom role, if one was created. Null if not created."
  value       = var.create_custom_role ? azurerm_role_definition.custom[0].name : null
}

output "role_assignments" {
  description = "Map of role assignments created for the subscription."
  value       = azurerm_role_assignment.main
}

