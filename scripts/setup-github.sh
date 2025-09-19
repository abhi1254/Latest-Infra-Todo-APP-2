#!/bin/bash

# Setup GitHub Repository Script
# This script helps set up the GitHub repository with proper branching and workflows

set -e

echo "🚀 Setting up GitHub repository for Latest-Infra-Todo-APP-2"

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing git repository..."
    git init
fi

# Add remote origin
echo "🔗 Adding remote origin..."
git remote add origin https://github.com/abhi1254/Latest-Infra-Todo-APP-2.git || echo "Remote already exists"

# Create feature branch
echo "🌿 Creating feature branch..."
FEATURE_BRANCH="feature/terraform-infrastructure-$(date +%Y%m%d-%H%M%S)"
git checkout -b $FEATURE_BRANCH

# Add all files
echo "📝 Adding files to git..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "feat: Add Terraform infrastructure with GitHub Actions workflows

- Add dev and prod environments
- Add AKS, Key Vault, SQL Server modules
- Add GitHub Actions for security checks
- Add feature branch workflow
- Add dev plan workflow
- Add prod apply workflow with manual approval
- Add PR template and dependabot configuration"

# Push to feature branch
echo "🚀 Pushing to feature branch..."
git push -u origin $FEATURE_BRANCH

echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Go to https://github.com/abhi1254/Latest-Infra-Todo-APP-2"
echo "2. Create a Pull Request from $FEATURE_BRANCH to main"
echo "3. The security checks will run automatically"
echo "4. After approval and merge, dev environment will run plan"
echo "5. Use manual workflow dispatch for prod apply"
echo ""
echo "🔧 Required GitHub Secrets:"
echo "- AZURE_CREDENTIALS: Azure service principal credentials"
echo "- APPROVERS: Comma-separated list of GitHub usernames for manual approval"
echo ""
echo "🎯 Workflow Summary:"
echo "- Feature branches: Security checks on PR"
echo "- Main branch: Dev plan on push"
echo "- Prod: Manual approval required for apply"
