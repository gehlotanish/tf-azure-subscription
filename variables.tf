variable "subscription_name" {
  type        = string
  description = "The name of the Azure subscription to be created."
}

variable "management_group_name" {
  type        = string
  default     = ""
  description = "The name of the Azure management group to assign."
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

# Variable: Custom Roles to Create & Assign
variable "custom_roles" {
  description = "List of custom roles to create and auto-assign."
  type = list(object({
    name          = string
    description   = string
    actions       = list(string)
    not_actions   = list(string)
    principal_ids = list(string)
  }))
  default = []
}

# Variable: Enable Built-in Role Assignments
variable "enable_builtin_roles" {
  description = "Whether to assign built-in roles."
  type        = bool
  default     = false
}

# Variable: Built-in Role Assignments
variable "builtin_role_assignments" {
  description = "List of built-in role assignments to apply if enabled."
  type = list(object({
    principal_id         = string
    role_definition_name = string
  }))
  default = []
}
