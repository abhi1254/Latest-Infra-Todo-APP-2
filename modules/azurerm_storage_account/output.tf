output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.audit_storage.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.audit_storage.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.audit_storage.primary_blob_endpoint
}

output "primary_access_key" {
  description = "Primary access key of the storage account"
  value       = azurerm_storage_account.audit_storage.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key of the storage account"
  value       = azurerm_storage_account.audit_storage.secondary_access_key
  sensitive   = true
}

# Legacy outputs for backward compatibility
output "audit_storage_endpoint" {
  description = "Legacy: Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.audit_storage.primary_blob_endpoint
}

output "audit_storage_key" {
  description = "Legacy: Primary access key of the storage account"
  value       = azurerm_storage_account.audit_storage.primary_access_key
  sensitive   = true
}
