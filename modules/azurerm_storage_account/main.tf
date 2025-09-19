resource "azurerm_storage_account" "audit_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  min_tls_version          = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  tags = var.tags
}
