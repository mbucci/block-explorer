data "aws_secretsmanager_secret" "infura_config_secret" {
  name = var.infura_api_config_secret_name
}
