module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  env_prefix = var.env_prefix
}

module "block_explorer" {
  source = "./modules/block_explorer"

  # general config
  env_prefix = var.env_prefix

  # app config
  ecs_cluster_arn               = module.ecs_cluster.cluster_arn
  infura_api_config_secret_name = var.infura_api_config_secret_name

  # networking config
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
}
