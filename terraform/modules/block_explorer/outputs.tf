output "dns_name" {
  value = aws_lb.block_explorer_alb.dns_name
}

output "ecr_repo_name" {
  value = aws_ecr_repository.block_explorer.name
}
