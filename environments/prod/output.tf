data "azurerm_key_vault" "kv" {
  name                = "deploymentkeyvault998"
  resource_group_name = "prod-rg"
}

data "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "dbusername"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "dbpasswordnew"
  key_vault_id = data.azurerm_key_vault.kv.id
}
