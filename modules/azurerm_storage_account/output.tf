output "audit_storage_endpoint" {
  value = azurerm_storage_account.audit_storage.primary_blob_endpoint
}

output "audit_storage_key" {
  value     = azurerm_storage_account.audit_storage.primary_access_key
  sensitive = true
}
