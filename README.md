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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.26.0 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_name"></a> [billing\_account\_name](#input\_billing\_account\_name) | Azure Billing Account Name. | `string` | n/a | yes |
| <a name="input_create_custom_role"></a> [create\_custom\_role](#input\_create\_custom\_role) | Whether to create a custom role definition | `bool` | `false` | no |
| <a name="input_custom_role_actions"></a> [custom\_role\_actions](#input\_custom\_role\_actions) | Allowed actions in the custom role | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_custom_role_description"></a> [custom\_role\_description](#input\_custom\_role\_description) | Description of the custom role | `string` | `"This is a custom role created via Terraform"` | no |
| <a name="input_custom_role_name"></a> [custom\_role\_name](#input\_custom\_role\_name) | Name for the custom role (used only if create\_custom\_role is true) | `string` | `"my-custom-role"` | no |
| <a name="input_custom_role_not_actions"></a> [custom\_role\_not\_actions](#input\_custom\_role\_not\_actions) | Denied actions in the custom role | `list(string)` | `[]` | no |
| <a name="input_enrollment_account_name"></a> [enrollment\_account\_name](#input\_enrollment\_account\_name) | Azure Enrollment Account Name. | `string` | n/a | yes |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | List of role assignments. Set use\_custom\_role = true to assign the custom role. | <pre>list(object({<br>    principal_id         = string<br>    role_definition_name = string<br>    use_custom_role      = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | The name of the Azure subscription to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the subscription. | `map(string)` | `{}` | no |  
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_role_name"></a> [custom\_role\_name](#output\_custom\_role\_name) | Name of the custom role, if one was created. Null if not created. |
| <a name="output_role_assignments"></a> [role\_assignments](#output\_role\_assignments) | Map of role assignments created for the subscription. |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | The ID of the created Azure subscription. |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | The name of the created Azure subscription. |
<!-- END_TF_DOCS -->

## Usage

```tf
subscription_name       = "My Custom EA Subscription"
billing_account_name    = "1234567890"
enrollment_account_name = "0123456"

tags = {
  Environment = "production"
  Project     = "TerraformSubscriptionProvisioning"
}

create_custom_role        = true
custom_role_name          = "CustomReader"
custom_role_description   = "This is a custom role allowing read access to all resource groups"
custom_role_actions       = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
custom_role_not_actions   = []

role_assignments = [
  {
    principal_id         = "00000000-0000-0000-0000-000000000001"
    role_definition_name = "ignored"         # will be overridden
    use_custom_role      = true
  },
  {
    principal_id         = "00000000-0000-0000-0000-000000000002"
    role_definition_name = "Reader"          # built-in role
    use_custom_role      = false
  },
  {
    principal_id         = "00000000-0000-0000-0000-000000000003"
    role_definition_name = "Owner"           # another built-in role
    # use_custom_role not specified = false (default)
  }
]


```
