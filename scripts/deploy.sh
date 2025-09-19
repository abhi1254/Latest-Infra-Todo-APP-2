#!/bin/bash

# Todo App Infrastructure Deployment Script
# Usage: ./deploy.sh [dev|prod] [plan|apply|destroy]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Azure CLI is installed
    if ! command -v az &> /dev/null; then
        print_error "Azure CLI is not installed. Please install it first."
        exit 1
    fi
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed. Please install it first."
        exit 1
    fi
    
    # Check if user is logged in to Azure
    if ! az account show &> /dev/null; then
        print_error "Not logged in to Azure. Please run 'az login' first."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Function to validate environment
validate_environment() {
    local env=$1
    if [[ "$env" != "dev" && "$env" != "prod" ]]; then
        print_error "Invalid environment. Use 'dev' or 'prod'"
        exit 1
    fi
}

# Function to validate action
validate_action() {
    local action=$1
    if [[ "$action" != "plan" && "$action" != "apply" && "$action" != "destroy" ]]; then
        print_error "Invalid action. Use 'plan', 'apply', or 'destroy'"
        exit 1
    fi
}

# Function to initialize Terraform
init_terraform() {
    local env=$1
    print_status "Initializing Terraform for $env environment..."
    
    cd "environments/$env"
    terraform init
    print_success "Terraform initialized"
}

# Function to plan Terraform
plan_terraform() {
    local env=$1
    print_status "Planning Terraform changes for $env environment..."
    
    cd "environments/$env"
    terraform plan -out=tfplan
    print_success "Terraform plan completed"
}

# Function to apply Terraform
apply_terraform() {
    local env=$1
    print_status "Applying Terraform changes for $env environment..."
    
    cd "environments/$env"
    
    # Check if plan file exists
    if [[ ! -f "tfplan" ]]; then
        print_warning "No plan file found. Running terraform plan first..."
        terraform plan -out=tfplan
    fi
    
    # Apply with confirmation
    terraform apply tfplan
    print_success "Terraform apply completed"
}

# Function to destroy Terraform
destroy_terraform() {
    local env=$1
    print_warning "This will destroy all resources in $env environment!"
    read -p "Are you sure? Type 'yes' to continue: " confirmation
    
    if [[ "$confirmation" == "yes" ]]; then
        print_status "Destroying Terraform resources for $env environment..."
        cd "environments/$env"
        terraform destroy -auto-approve
        print_success "Terraform destroy completed"
    else
        print_status "Destroy cancelled"
        exit 0
    fi
}

# Function to show outputs
show_outputs() {
    local env=$1
    print_status "Showing Terraform outputs for $env environment..."
    
    cd "environments/$env"
    terraform output
}

# Main function
main() {
    # Check if correct number of arguments provided
    if [[ $# -ne 2 ]]; then
        print_error "Usage: $0 [dev|prod] [plan|apply|destroy]"
        exit 1
    fi
    
    local env=$1
    local action=$2
    
    # Validate inputs
    validate_environment "$env"
    validate_action "$action"
    
    # Check prerequisites
    check_prerequisites
    
    # Change to script directory
    cd "$(dirname "$0")/.."
    
    # Initialize Terraform
    init_terraform "$env"
    
    # Execute action
    case $action in
        "plan")
            plan_terraform "$env"
            ;;
        "apply")
            apply_terraform "$env"
            show_outputs "$env"
            ;;
        "destroy")
            destroy_terraform "$env"
            ;;
    esac
    
    print_success "Operation completed successfully!"
}

# Run main function with all arguments
main "$@"
