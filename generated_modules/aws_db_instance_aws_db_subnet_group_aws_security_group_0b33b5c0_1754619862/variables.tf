variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "myproject"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}
