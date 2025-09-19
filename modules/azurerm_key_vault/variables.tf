variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID of the user/service principal"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Key Vault"
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain deleted items"
  type        = number
  default     = 7
}

variable "key_permissions" {
  description = "Key permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Create", "Delete", "Update", "Import", "Backup", "Restore", "Recover"]
}

variable "secret_permissions" {
  description = "Secret permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
}

variable "storage_permissions" {
  description = "Storage permissions for the access policy"
  type        = list(string)
  default     = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
}

variable "network_acls_default_action" {
  description = "Default action for network ACLs"
  type        = string
  default     = "Allow"
}

variable "network_acls_bypass" {
  description = "Bypass setting for network ACLs"
  type        = string
  default     = "AzureServices"
}

variable "virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs"
  type        = list(string)
  default     = []
}

variable "secrets" {
  description = "Map of secrets to store in Key Vault"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the Key Vault"
  type        = map(string)
  default     = {}
}
