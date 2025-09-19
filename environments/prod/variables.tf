variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "todo"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    "ManagedBy" = "Terraform"
    "Owner"     = "TodoAppTeam"
    "Project"   = "TodoApp"
  }
}
