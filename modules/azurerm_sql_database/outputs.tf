output "database_id" {
  description = "ID of the SQL database"
  value       = azurerm_mssql_database.sql_db.id
}

output "database_name" {
  description = "Name of the SQL database"
  value       = azurerm_mssql_database.sql_db.name
}

output "database_server_id" {
  description = "ID of the SQL server"
  value       = azurerm_mssql_database.sql_db.server_id
}
