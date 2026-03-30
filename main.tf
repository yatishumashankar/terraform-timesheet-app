module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}

module "beanstalk" {
  source = "./modules/beanstalk"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
}
module "rds" {
  source = "./modules/rds"

  private_subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_group.security_group_id
}

module "frontend" {
  source = "./modules/frontend"

  bucket_name = "timesheet-frontend-yatish-12345"
}