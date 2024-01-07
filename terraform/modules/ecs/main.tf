resource "aws_ecs_cluster" "cluster" {
  name = "${var.aws_environment_name}-cluster"
}
