############
# Policies #
############
data "aws_iam_policy_document" "secrets_access" {
  statement {
    sid     = "secretaccess"
    effect  = "Allow"
    actions = ["secretsmanager:*"]

    resources = [
      "${data.aws_secretsmanager_secret.infura_config_secret.arn}*"
    ]
  }
}

resource "aws_iam_policy" "secrets_access" {
  name   = "${var.env_prefix}-secrets-access"
  path   = "/"
  policy = data.aws_iam_policy_document.secrets_access.json
}


#########
# Roles #
#########
resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.env_prefix}-ecs-task"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

###############
# Attachments #
###############
resource "aws_iam_role_policy_attachment" "ecs_task_execution_secrets_access" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_secrets_access" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.secrets_access.arn
}
