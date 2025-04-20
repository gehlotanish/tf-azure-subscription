# template-terraform
Template repository for all terraform module repositories

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.25.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.25.0 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_name"></a> [billing\_account\_name](#input\_billing\_account\_name) | Azure Billing Account Name. | `string` | n/a | yes |
| <a name="input_builtin_role_assignments"></a> [builtin\_role\_assignments](#input\_builtin\_role\_assignments) | List of built-in role assignments to apply if enabled. | <pre>list(object({<br>    principal_id         = string<br>    role_definition_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_custom_roles"></a> [custom\_roles](#input\_custom\_roles) | List of custom roles to create and auto-assign. | <pre>list(object({<br>    name          = string<br>    description   = string<br>    actions       = list(string)<br>    not_actions   = list(string)<br>    principal_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_enable_builtin_roles"></a> [enable\_builtin\_roles](#input\_enable\_builtin\_roles) | Whether to assign built-in roles. | `bool` | `false` | no |
| <a name="input_enrollment_account_name"></a> [enrollment\_account\_name](#input\_enrollment\_account\_name) | Azure Enrollment Account Name. | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | The name of the Azure subscription to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the subscription. | `map(string)` | `{}` | no |  
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_builtin_role_assignments"></a> [builtin\_role\_assignments](#output\_builtin\_role\_assignments) | List of built-in role assignments created (if any). |
| <a name="output_custom_role_names"></a> [custom\_role\_names](#output\_custom\_role\_names) | Names of custom roles created. |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | The ID of the created Azure subscription. |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | The name of the created Azure subscription. |
<!-- END_TF_DOCS -->

## Usage

```tf
# Subscription Information
subscription_name       = "My Custom EA Subscription"
billing_account_name    = "1234567890"
enrollment_account_name = "0123456"

tags = {
  Environment = "production"
  Project     = "TerraformSubscriptionProvisioning"
}

custom_roles = [
  {
    name        = "CustomReader"
    description = "Read access to all resource groups"
    actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
    not_actions = []
    principal_ids = [
      "00000000-0000-0000-0000-000000000100",
      "00000000-0000-0000-0000-000000000101"
    ]
  },
  {
    name        = "CustomMonitor"
    description = "Monitoring permissions"
    actions     = [
      "Microsoft.Insights/metrics/read",
      "Microsoft.Insights/logs/read"
    ]
    not_actions = []
    principal_ids = [
      "00000000-0000-0000-0000-000000000102"
    ]
  }
]

# === Enable built-in role assignments ===
enable_builtin_roles = true
builtin_role_assignments = [
  {
    principal_id         = "00000000-0000-0000-0000-000000000002"
    role_definition_name = "Reader"
  },
  {
    principal_id         = "00000000-0000-0000-0000-000000000003"
    role_definition_name = "Owner"
  }
]

```

### No roles only subscription

```tf
# Subscription Information
subscription_name       = "My Custom EA Subscription"
billing_account_name    = "1234567890"
enrollment_account_name = "0123456"

tags = {
  Environment = "production"
  Project     = "TerraformSubscriptionProvisioning"
}

# No custom roles to create (empty list)
custom_roles = []

# No built-in role assignments (empty list)
builtin_role_assignments = []

# No roles to assign, hence no need to set enable_builtin_roles
enable_builtin_roles = false

```
