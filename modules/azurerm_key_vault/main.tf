resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = var.key_permissions
    secret_permissions = var.secret_permissions
    storage_permissions = var.storage_permissions
  }

  network_acls {
    default_action = var.network_acls_default_action
    bypass         = var.network_acls_bypass
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  tags = var.tags
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id
}
