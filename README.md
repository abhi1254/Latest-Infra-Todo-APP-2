# Latest-Infra-Todo-APP-2

A comprehensive Terraform infrastructure setup for a Todo application with Azure Kubernetes Service (AKS), Azure Key Vault, and SQL Server, featuring automated CI/CD pipelines with security checks and manual approval workflows.

## 🏗️ Architecture

This project provides infrastructure for a Todo application with the following components:

- **Azure Kubernetes Service (AKS)** - Container orchestration
- **Azure Key Vault** - Secrets management
- **Azure SQL Server & Database** - Data persistence
- **Azure Virtual Network** - Network isolation
- **Azure Storage Account** - Backup and logging
- **Azure Managed Identity** - Secure authentication

## 📁 Project Structure

```
├── environments/
│   ├── dev/           # Development environment
│   └── prod/          # Production environment
├── modules/           # Reusable Terraform modules
│   ├── azurerm_kubernetes_cluster/
│   └── azurerm_key_vault/
├── .github/
│   └── workflows/     # GitHub Actions workflows
└── scripts/           # Deployment scripts
```

## 🚀 Quick Start

### Prerequisites

- Azure CLI installed and configured
- Terraform >= 1.6.0
- Git
- GitHub account with repository access

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/abhi1254/Latest-Infra-Todo-APP-2.git
   cd Latest-Infra-Todo-APP-2
   ```

2. **Run the setup script:**
   
   **For Windows (PowerShell):**
   ```powershell
   .\scripts\setup-github.ps1
   ```
   
   **For Linux/Mac:**
   ```bash
   chmod +x scripts/setup-github.sh
   ./scripts/setup-github.sh
   ```

3. **Configure GitHub Secrets:**
   - `AZURE_CREDENTIALS`: Azure service principal credentials
   - `APPROVERS`: Comma-separated list of GitHub usernames for manual approval

## 🔄 CI/CD Workflow

### Feature Branch Workflow
- **Trigger**: Push to feature branches or PR to main
- **Actions**: 
  - Terraform format check
  - Terraform validation
  - TFSec security scanning
  - PR comments with results

### Development Environment
- **Trigger**: Push to main branch
- **Actions**:
  - Terraform plan for dev environment
  - Artifact upload for plan review

### Production Environment
- **Trigger**: Manual workflow dispatch
- **Actions**:
  - Manual approval required
  - Terraform plan/apply/destroy options
  - Secure deployment with approval gates

## 🛡️ Security Features

- **TFSec Integration**: Automated security scanning
- **Manual Approval**: Required for production deployments
- **RBAC**: Role-based access control for AKS
- **Network Isolation**: VNet with subnets and security rules
- **Secrets Management**: Azure Key Vault integration
- **Encryption**: TLS 1.2 minimum, encrypted storage

## 📋 Environments

### Development Environment
- **Location**: West US 2
- **Node Count**: 1-3 nodes (auto-scaling)
- **VM Size**: Standard_D2s_v3
- **Database**: 2GB max size
- **Key Vault**: Standard SKU

### Production Environment
- **Location**: East US
- **Node Count**: 2-10 nodes (auto-scaling)
- **VM Size**: Standard_D4s_v3
- **Database**: 10GB max size
- **Key Vault**: Premium SKU with purge protection

## 🔧 Manual Deployment

### Development
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Production
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## 📊 Monitoring and Logging

- **Azure Monitor**: Integrated monitoring
- **Log Analytics**: Centralized logging
- **Security Center**: Security recommendations
- **TFSec Reports**: Security scan results in GitHub

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Run security checks locally
4. Create a Pull Request
5. Wait for automated checks
6. Get approval and merge

## 📝 GitHub Actions Workflows

### Security Checks (`terraform-security-checks.yml`)
- Runs on PR to main
- Terraform format, init, validate
- TFSec security scanning
- SARIF upload to GitHub Security tab

### Feature Branch (`feature-branch.yml`)
- Runs on feature branch pushes
- Comprehensive validation
- Security scanning
- PR comments with results

### Dev Plan (`dev-plan.yml`)
- Runs on main branch push
- Terraform plan for dev
- Artifact upload

### Prod Apply (`prod-apply.yml`)
- Manual workflow dispatch
- Manual approval required
- Plan/Apply/Destroy options

## 🔐 Security Considerations

- All secrets stored in Azure Key Vault
- Network access restricted to VNet subnets
- RBAC enabled for all resources
- Regular security scanning with TFSec
- Manual approval for production changes

## 📞 Support

For issues and questions:
- Create an issue in the GitHub repository
- Check the GitHub Actions logs for deployment issues
- Review TFSec reports for security findings

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.