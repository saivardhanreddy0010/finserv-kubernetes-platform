variable "aws_region" {
  description = "AWS region for the project."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used in resource tags."
  type        = string
  default     = "finserv-platform"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "learning"
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR block."
  type        = string
  default     = "10.40.0.0/16"
}
