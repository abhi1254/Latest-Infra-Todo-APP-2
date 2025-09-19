# Todo App Infrastructure

This repository contains the Terraform infrastructure code for the Todo App microservices architecture deployed on Azure.

## Architecture Overview

The infrastructure is designed using a modular approach and supports both Development (DEV) and Production (PROD) environments with the following components:

### Core Resources
- **Resource Groups**: Isolated resource containers for each environment
- **Virtual Networks**: Secure networking with subnets for different services
- **Azure Key Vault**: Secure storage for secrets and certificates
- **Storage Accounts**: Blob storage for application data and SQL audit logs
- **SQL Server & Database**: Managed database service for application data
- **Azure Kubernetes Service (AKS)**: Container orchestration platform
- **Public IPs**: External access points for services
- **Managed Identities**: Secure authentication for Azure services

## Directory Structure

```
Infra-Todo-App/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
├── modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_key_vault/
│   ├── azurerm_storage_account/
│   ├── azurerm_sql_server/
│   ├── azurerm_sql_database/
│   ├── azurerm_kubernetes_cluster/
│   ├── azurerm_public_ip/
│   └── azurerm_managed_identity/
└── README.md
```

## Modules

### Resource Group Module (`azurerm_resource_group`)
Creates and manages Azure Resource Groups with proper tagging.

### Virtual Network Module (`azurerm_virtual_network`)
Creates virtual networks with configurable subnets and network security groups.

### Key Vault Module (`azurerm_key_vault`)
Manages Azure Key Vault with configurable access policies and network restrictions.

### Storage Account Module (`azurerm_storage_account`)
Creates storage accounts with configurable replication and security settings.

### SQL Server Module (`azurerm_sql_server`)
Deploys Azure SQL Server with auditing enabled and network security.

### SQL Database Module (`azurerm_sql_database`)
Creates SQL databases with configurable sizing and backup policies.

### Kubernetes Cluster Module (`azurerm_kubernetes_cluster`)
Deploys AKS clusters with configurable node pools and networking.

### Public IP Module (`azurerm_public_ip`)
Creates static public IP addresses for external access.

### Managed Identity Module (`azurerm_managed_identity`)
Creates managed identities for secure service-to-service authentication.

## Environment Differences

### Development Environment
- **Resource Group**: `todo-dev-rg`
- **Key Vault**: Standard SKU with soft delete retention of 7 days
- **Storage**: LRS replication
- **SQL Database**: 2GB max size
- **AKS**: 1-3 nodes, Standard_D2s_v3 VMs
- **Networking**: Open access policies

### Production Environment
- **Resource Group**: `todo-prod-rg`
- **Key Vault**: Premium SKU with purge protection enabled
- **Storage**: GRS replication for high availability
- **SQL Database**: 10GB max size
- **AKS**: 2-10 nodes, Standard_D4s_v3 VMs with multiple node pools
- **Networking**: Restricted access with network ACLs

## Prerequisites

1. **Azure CLI** installed and configured
2. **Terraform** >= 1.0 installed
3. **Azure subscription** with appropriate permissions
4. **Service Principal** or user account with Contributor role

## Getting Started

### 1. Authentication
```bash
# Login to Azure
az login

# Set subscription
az account set --subscription "your-subscription-id"
```

### 2. Initialize Terraform
```bash
# Navigate to environment directory
cd environments/dev  # or environments/prod

# Initialize Terraform
terraform init
```

### 3. Plan Deployment
```bash
# Review the planned changes
terraform plan
```

### 4. Deploy Infrastructure
```bash
# Apply the configuration
terraform apply
```

### 5. Access Resources
```bash
# Get AKS credentials
az aks get-credentials --resource-group todo-dev-rg --name todo-dev-aks

# List resources
az resource list --resource-group todo-dev-rg --output table
```

## Configuration

### Environment Variables
Each environment has its own `terraform.tfvars` file with environment-specific configurations.

### Customization
Modify the `main.tf` files in each environment directory to customize:
- Resource naming conventions
- VM sizes and node counts
- Network configurations
- Security policies

## Security Considerations

1. **Key Vault**: Stores all sensitive data with proper access controls
2. **Network Security**: Subnets with NSG rules and service endpoints
3. **RBAC**: Role-based access control enabled on AKS
4. **Encryption**: All data encrypted at rest and in transit
5. **Auditing**: SQL Server auditing enabled to storage account

## Monitoring and Logging

- **SQL Auditing**: All database activities logged to storage account
- **Key Vault Logging**: Access and operations logged
- **AKS Monitoring**: Container insights and metrics available
- **Storage Logging**: Access patterns and operations tracked

## Cost Optimization

- **Development**: Smaller VM sizes and single region deployment
- **Production**: Auto-scaling enabled with appropriate limits
- **Storage**: Different replication strategies based on environment needs
- **Tagging**: Comprehensive tagging for cost allocation

## Troubleshooting

### Common Issues

1. **Naming Conflicts**: Azure resource names must be globally unique
2. **Permissions**: Ensure sufficient RBAC permissions
3. **Quotas**: Check Azure subscription quotas for resource limits
4. **Networking**: Verify subnet configurations and NSG rules

### Useful Commands

```bash
# Check resource group
az group show --name todo-dev-rg

# List all resources
az resource list --resource-group todo-dev-rg

# Check AKS cluster status
az aks show --resource-group todo-dev-rg --name todo-dev-aks

# View Key Vault
az keyvault show --name todo-dev-kv --resource-group todo-dev-rg
```

## Contributing

1. Follow Terraform best practices
2. Update documentation for any changes
3. Test in development environment first
4. Use meaningful commit messages
5. Review all changes before applying to production

## Support

For issues and questions:
- Check Azure documentation
- Review Terraform Azure provider documentation
- Contact the DevOps team