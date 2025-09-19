output "identity_id" {
  description = "ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.id
}

output "identity_name" {
  description = "Name of the managed identity"
  value       = azurerm_user_assigned_identity.identity.name
}

output "identity_principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "identity_client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.client_id
}
