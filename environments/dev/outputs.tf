output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.resource_group_id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.key_vault.key_vault_uri
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_endpoint" {
  description = "Primary endpoint of the storage account"
  value       = module.storage_account.primary_blob_endpoint
}

output "sql_server_name" {
  description = "Name of the SQL server"
  value       = module.sql_server.server_name
}

output "sql_server_fqdn" {
  description = "FQDN of the SQL server"
  value       = module.sql_server.server_fqdn
}

output "sql_database_name" {
  description = "Name of the SQL database"
  value       = module.sql_database.database_name
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks_cluster.cluster_name
}

output "aks_cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks_cluster.cluster_fqdn
}

output "aks_cluster_private_fqdn" {
  description = "Private FQDN of the AKS cluster"
  value       = module.aks_cluster.cluster_private_fqdn
}

# Public IP output removed - using existing public IPs

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.virtual_network.vnet_name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.virtual_network.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = module.virtual_network.subnet_ids
}
