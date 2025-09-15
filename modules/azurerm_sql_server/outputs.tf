output "server_id" {
  value = azurerm_mssql_server.sql_server.id
}

output "sql_admin_username" {
  value = var.admin_username
}

output "sql_admin_password" {
  value     = var.admin_password
  sensitive = true
}
