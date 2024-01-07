resource "aws_ecr_repository" "block_explorer" {
  name                 = var.env_prefix
  image_tag_mutability = "MUTABLE"
}
