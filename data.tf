data "azurerm_billing_enrollment_account_scope" "main" {
  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.enrollment_account_name
}

data "azurerm_management_group" "main" {
  count = var.management_group_name != null && var.management_group_name != "" ? 1 : 0
  name  = var.management_group_name
}
