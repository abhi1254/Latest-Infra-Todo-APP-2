variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region where the AKS cluster will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = null
}

variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
}

variable "default_node_pool_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "vnet_subnet_id" {
  description = "ID of the subnet for the AKS cluster"
  type        = string
}

variable "enable_auto_scaling" {
  description = "Enable auto scaling for the default node pool"
  type        = bool
  default     = false
}

variable "min_count" {
  description = "Minimum number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "max_pods" {
  description = "Maximum number of pods per node"
  type        = number
  default     = 30
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 30
}

variable "node_pool_type" {
  description = "Type of the node pool"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "network_plugin" {
  description = "Network plugin for the AKS cluster"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy for the AKS cluster"
  type        = string
  default     = "azure"
}

variable "service_cidr" {
  description = "CIDR for Kubernetes services"
  type        = string
  default     = "10.1.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for the DNS service"
  type        = string
  default     = "10.1.0.10"
}

variable "docker_bridge_cidr" {
  description = "CIDR for the Docker bridge"
  type        = string
  default     = "172.17.0.1/16"
}

variable "rbac_enabled" {
  description = "Enable RBAC for the AKS cluster"
  type        = bool
  default     = true
}

variable "aad_rbac_enabled" {
  description = "Enable Azure AD RBAC for the AKS cluster"
  type        = bool
  default     = false
}

variable "admin_group_object_ids" {
  description = "Object IDs of admin groups for AAD RBAC"
  type        = list(string)
  default     = []
}

variable "additional_node_pools" {
  description = "Map of additional node pools to create"
  type = map(object({
    vm_size             = string
    node_count          = number
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number)
    max_count           = optional(number)
    max_pods            = optional(number)
    os_disk_size_gb     = optional(number, 30)
    os_type             = optional(string, "Linux")
    mode                = optional(string, "User")
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the AKS cluster"
  type        = map(string)
  default     = {}
}
