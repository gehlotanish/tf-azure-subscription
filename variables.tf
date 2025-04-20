variable "subscription_name" {
  type        = string
  description = "The name of the Azure subscription to be created."
}

variable "billing_account_name" {
  type        = string
  description = "Azure Billing Account Name."
}

variable "enrollment_account_name" {
  type        = string
  description = "Azure Enrollment Account Name."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the subscription."
}

variable "role_assignments" {
  type = list(object({
    principal_id         = string
    role_definition_name = string
    use_custom_role      = optional(bool, false)
  }))
  default     = []
  description = "List of role assignments. Set use_custom_role = true to assign the custom role."
}

# Custom Role Toggle
variable "create_custom_role" {
  type        = bool
  default     = false
  description = "Whether to create a custom role definition"
}

variable "custom_role_name" {
  type        = string
  default     = "my-custom-role"
  description = "Name for the custom role (used only if create_custom_role is true)"
}

variable "custom_role_description" {
  type        = string
  default     = "This is a custom role created via Terraform"
  description = "Description of the custom role"
}

variable "custom_role_actions" {
  type        = list(string)
  default     = ["*"]
  description = "Allowed actions in the custom role"
}

variable "custom_role_not_actions" {
  type        = list(string)
  default     = []
  description = "Denied actions in the custom role"
}

