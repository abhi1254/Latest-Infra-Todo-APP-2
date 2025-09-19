output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID of the Key Vault"
  value       = azurerm_key_vault.kv.tenant_id
}

output "key_vault_secrets" {
  description = "Map of secrets stored in Key Vault"
  value       = { for k, v in azurerm_key_vault_secret.secrets : k => v.value }
  sensitive   = true
}
