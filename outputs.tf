output "subscription_id" {
  description = "The ID of the created Azure subscription."
  value       = azurerm_subscription.main.id
}

output "subscription_name" {
  description = "The name of the created Azure subscription."
  value       = azurerm_subscription.main.subscription_name
}

output "custom_role_names" {
  description = "Names of custom roles created."
  value       = [for r in azurerm_role_definition.custom : r.name]
}

output "builtin_role_assignments" {
  description = "List of built-in role assignments created (if any)."
  value       = azurerm_role_assignment.builtin
}
