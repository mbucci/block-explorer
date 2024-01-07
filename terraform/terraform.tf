terraform {
  required_version = "= 1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.13.1"
    }
  }

  backend "s3" {
    bucket = "block-explorer-tf-state"
    key    = "terraform"
    region = "us-east-1"
  }
}
