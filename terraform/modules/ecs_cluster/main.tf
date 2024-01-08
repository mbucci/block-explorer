resource "aws_ecs_cluster" "cluster" {
  name = var.env_prefix
}
