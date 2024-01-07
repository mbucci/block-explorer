provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      managed = "terraform"
    }
  }
}
