variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env_prefix" {
  type        = string
  description = "Value tha will be prefixed to all resources"
}

variable "infura_api_config_secret_name" {
  type        = string
  description = "Name of the Infura API Config secret"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs"
}
