resource "aws_ecs_service" "block_explorer_service" {
  name = "${var.env_prefix}_service"

  cluster              = var.ecs_cluster_arn
  launch_type          = "FARGATE"
  force_new_deployment = true

  deployment_maximum_percent         = 200 # allow 2-at-a-time while deploying
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1

  platform_version    = "LATEST"
  propagate_tags      = "NONE"
  scheduling_strategy = "REPLICA"

  task_definition = aws_ecs_task_definition.block_explorer_definition.arn

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = "app"
    container_port   = 8000
    target_group_arn = aws_lb_target_group.block_explorer_tg.arn
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.block_explorer_alb_sg.id]
    subnets          = var.private_subnet_ids
  }
}


resource "aws_ecs_task_definition" "block_explorer_definition" {
  family             = "${var.env_prefix}_task_definition"
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode(
    [
      {
        cpu = 0
        secrets = [
          {
            name : "INFURA_API_KEY"
            valueFrom : "${data.aws_secretsmanager_secret.infura_config_secret.arn}:INFURA_API_KEY::"
          },
          {
            name : "INFURA_BASE_URL"
            valueFrom : "${data.aws_secretsmanager_secret.infura_config_secret.arn}:INFURA_BASE_URL::"
          },
        ]
        essential = true
        image     = "${aws_ecr_repository.block_explorer.repository_url}:latest"
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-create-group  = "true"
            awslogs-group         = "/ecs/block_explorer_task_definition"
            awslogs-region        = "us-east-1"
            awslogs-stream-prefix = "ecs"
          }
        }
        mountPoints = []
        name        = "app"
        portMappings = [
          {
            appProtocol   = "http"
            containerPort = 8000
            hostPort      = 8000
            name          = "api"
            protocol      = "tcp"
          },
        ]
        volumesFrom = []
      },
    ]
  )

  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE",
  ]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}
