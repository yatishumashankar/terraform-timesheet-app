terraform {
  backend "s3" {
    bucket = "yatish-terraform-state-bucket-123"
    key    = "timesheet/terraform.tfstate"
    region = "ap-south-1"
  }
}# =========================
# VPC Module
# =========================
module "vpc" {
  source = "./modules/vpc"
}

# =========================
# Security Group Module
# =========================
module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}

# =========================
# Backend (Elastic Beanstalk)
# =========================
module "beanstalk" {
  source = "./modules/beanstalk"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
}

# =========================
# Database (RDS)
# =========================
module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id = module.security_group.security_group_id
}

# =========================
# Frontend (S3)
# =========================
module "frontend" {
  source = "./modules/frontend"

  bucket_name = "timesheet-frontend-yatish-78654"
}
