locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "dev"
  }
}

module "storage" {
  source      = "../../modules/azurerm_storage_account"
  storage_account_name = "prodauditstg"
  rg_name     = "prod-rg"
  location    = "East US"
  sql_server_name = "prod-sql"
  tags        = local.common_tags
  
}

module "msql_server" {
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "prod-sql"
  rg_name         = "prod-rg"
  location        = "East US"
  admin_username  = data.azurerm_key_vault_secret.sql_admin_username.value
  admin_password  = data.azurerm_key_vault_secret.sql_admin_password.value

  tags            = local.common_tags

  audit_storage_endpoint = module.storage.audit_storage_endpoint
  audit_storage_key      = module.storage.audit_storage_key
}

module "sql_db" {
  depends_on  = [module.msql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.msql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}



module "pip" {
  source   = "../../modules/azurerm_public_ip"
  pip_name = "pip-dev-todoapp"
  rg_name  = "prod-rg"
  location = "East US"
  sku      = "Standard"
  tags     = local.common_tags
}
