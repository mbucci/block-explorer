#################
# Load Balancer #
#################
resource "aws_lb" "block_explorer_alb" {
  name               = replace("${var.env_prefix}-alb", "_", "-")
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = false

  security_groups = [aws_security_group.block_explorer_alb_sg.id]
  subnets         = var.private_subnet_ids
}


################
# Target Group #
################
resource "aws_lb_target_group" "block_explorer_tg" {
  name     = replace("${var.env_prefix}-tg", "_", "-")
  port     = 80
  protocol = "HTTP"

  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}


############
# Listener #
############
resource "aws_lb_listener" "block_explorer_listener" {
  load_balancer_arn = aws_lb.block_explorer_alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.block_explorer_tg.arn
  }
}


##################
# Security Group #
##################
resource "aws_security_group" "block_explorer_alb_sg" {
  name        = replace("${var.env_prefix}-alb-sg", "_", "-")
  description = "Security Group for Block Explorer ALB"
  vpc_id      = var.vpc_id

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = "Internet Access"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }
}
