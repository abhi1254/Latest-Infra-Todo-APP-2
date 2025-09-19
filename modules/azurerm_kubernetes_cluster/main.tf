resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = var.default_node_pool_name
    node_count          = var.default_node_pool_count
    vm_size             = var.default_node_pool_vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    max_pods            = var.max_pods
    os_disk_size_gb     = var.os_disk_size_gb
    type                = var.node_pool_type
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  role_based_access_control_enabled = var.rbac_enabled

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.aad_rbac_enabled ? [1] : []
    content {
      managed                = true
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_node_pools" {
  for_each = var.additional_node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  vnet_subnet_id        = var.vnet_subnet_id
  max_pods              = lookup(each.value, "max_pods", null)
  os_disk_size_gb       = lookup(each.value, "os_disk_size_gb", 30)
  os_type               = lookup(each.value, "os_type", "Linux")
  mode                  = lookup(each.value, "mode", "User")

  tags = var.tags
}