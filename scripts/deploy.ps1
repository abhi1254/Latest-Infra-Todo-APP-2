# Todo App Infrastructure Deployment Script
# Usage: .\deploy.ps1 [dev|prod] [plan|apply|destroy]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev", "prod")]
    [string]$Environment,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("plan", "apply", "destroy")]
    [string]$Action
)

# Function to print colored output
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Function to check prerequisites
function Test-Prerequisites {
    Write-Status "Checking prerequisites..."
    
    # Check if Azure CLI is installed
    try {
        $null = Get-Command az -ErrorAction Stop
    }
    catch {
        Write-Error "Azure CLI is not installed. Please install it first."
        exit 1
    }
    
    # Check if Terraform is installed
    try {
        $null = Get-Command terraform -ErrorAction Stop
    }
    catch {
        Write-Error "Terraform is not installed. Please install it first."
        exit 1
    }
    
    # Check if user is logged in to Azure
    try {
        $null = az account show 2>$null
    }
    catch {
        Write-Error "Not logged in to Azure. Please run 'az login' first."
        exit 1
    }
    
    Write-Success "Prerequisites check passed"
}

# Function to initialize Terraform
function Initialize-Terraform {
    param([string]$Env)
    Write-Status "Initializing Terraform for $Env environment..."
    
    Set-Location "environments\$Env"
    terraform init
    Write-Success "Terraform initialized"
}

# Function to plan Terraform
function Plan-Terraform {
    param([string]$Env)
    Write-Status "Planning Terraform changes for $Env environment..."
    
    Set-Location "environments\$Env"
    terraform plan -out=tfplan
    Write-Success "Terraform plan completed"
}

# Function to apply Terraform
function Apply-Terraform {
    param([string]$Env)
    Write-Status "Applying Terraform changes for $Env environment..."
    
    Set-Location "environments\$Env"
    
    # Check if plan file exists
    if (-not (Test-Path "tfplan")) {
        Write-Warning "No plan file found. Running terraform plan first..."
        terraform plan -out=tfplan
    }
    
    # Apply with confirmation
    terraform apply tfplan
    Write-Success "Terraform apply completed"
}

# Function to destroy Terraform
function Destroy-Terraform {
    param([string]$Env)
    Write-Warning "This will destroy all resources in $Env environment!"
    $confirmation = Read-Host "Are you sure? Type 'yes' to continue"
    
    if ($confirmation -eq "yes") {
        Write-Status "Destroying Terraform resources for $Env environment..."
        Set-Location "environments\$Env"
        terraform destroy -auto-approve
        Write-Success "Terraform destroy completed"
    } else {
        Write-Status "Destroy cancelled"
        exit 0
    }
}

# Function to show outputs
function Show-Outputs {
    param([string]$Env)
    Write-Status "Showing Terraform outputs for $Env environment..."
    
    Set-Location "environments\$Env"
    terraform output
}

# Main execution
try {
    # Check prerequisites
    Test-Prerequisites
    
    # Change to script directory
    $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
    Set-Location (Split-Path -Parent $scriptPath)
    
    # Initialize Terraform
    Initialize-Terraform $Environment
    
    # Execute action
    switch ($Action) {
        "plan" {
            Plan-Terraform $Environment
        }
        "apply" {
            Apply-Terraform $Environment
            Show-Outputs $Environment
        }
        "destroy" {
            Destroy-Terraform $Environment
        }
    }
    
    Write-Success "Operation completed successfully!"
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    exit 1
}
