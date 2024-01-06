provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      account             = var.aws_account_name
      environment         = var.aws_environment_name
      managed             = "terraform"
    }
  }
}
