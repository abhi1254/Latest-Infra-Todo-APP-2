# Setup GitHub Repository Script (PowerShell)
# This script helps set up the GitHub repository with proper branching and workflows

Write-Host "Setting up GitHub repository for Latest-Infra-Todo-APP-2" -ForegroundColor Green

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
}

# Add remote origin
Write-Host "Adding remote origin..." -ForegroundColor Yellow
try {
    git remote add origin https://github.com/abhi1254/Latest-Infra-Todo-APP-2.git
} catch {
    Write-Host "Remote already exists" -ForegroundColor Yellow
}

# Create feature branch
Write-Host "Creating feature branch..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$featureBranch = "feature/terraform-infrastructure-$timestamp"
git checkout -b $featureBranch

# Add all files
Write-Host "Adding files to git..." -ForegroundColor Yellow
git add .

# Commit changes
Write-Host "Committing changes..." -ForegroundColor Yellow
git commit -m "feat: Add Terraform infrastructure with GitHub Actions workflows

- Add dev and prod environments
- Add AKS, Key Vault, SQL Server modules
- Add GitHub Actions for security checks
- Add feature branch workflow
- Add dev plan workflow
- Add prod apply workflow with manual approval
- Add PR template and dependabot configuration"

# Push to feature branch
Write-Host "Pushing to feature branch..." -ForegroundColor Yellow
git push -u origin $featureBranch

Write-Host "Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to https://github.com/abhi1254/Latest-Infra-Todo-APP-2" -ForegroundColor White
Write-Host "2. Create a Pull Request from $featureBranch to main" -ForegroundColor White
Write-Host "3. The security checks will run automatically" -ForegroundColor White
Write-Host "4. After approval and merge, dev environment will run plan" -ForegroundColor White
Write-Host "5. Use manual workflow dispatch for prod apply" -ForegroundColor White
Write-Host ""
Write-Host "Required GitHub Secrets:" -ForegroundColor Cyan
Write-Host "- AZURE_CREDENTIALS: Azure service principal credentials" -ForegroundColor White
Write-Host "- APPROVERS: Comma-separated list of GitHub usernames for manual approval" -ForegroundColor White
Write-Host ""
Write-Host "Workflow Summary:" -ForegroundColor Cyan
Write-Host "- Feature branches: Security checks on PR" -ForegroundColor White
Write-Host "- Main branch: Dev plan on push" -ForegroundColor White
Write-Host "- Prod: Manual approval required for apply" -ForegroundColor White
