output "server_id" {
  description = "ID of the SQL server"
  value = azurerm_mssql_server.sql_server.id
}

output "server_name" {
  description = "Name of the SQL server"
  value = azurerm_mssql_server.sql_server.name
}

output "server_fqdn" {
  description = "FQDN of the SQL server"
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_admin_username" {
  description = "SQL admin username"
  value = var.admin_username
}

output "sql_admin_password" {
  description = "SQL admin password"
  value     = var.admin_password
  sensitive = true
}
