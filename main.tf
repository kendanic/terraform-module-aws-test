module "vpc" {
  source                             = "../module/vpc"
  region                             = var.region
  project_name                       = var.project_name
  vpc_cidr                           = var.vpc_cidr
  public_subnet_az1_cidr             = var.public_subnet_az1_cidr
  public_subnet_az2_cidr             = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr        = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr        = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr       = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr       = var.private_data_subnet_az2_cidr

}

module "nat" {
  source = "../module/nat"

  public_subnet_az1_id              = module.vpc.public_subnet_az1_id
  internet_gateway                  = module.vpc.internet_gateway
  public_subnet_az2_id              = module.vpc.public_subnet_az2_id
  vpc_id                            = module.vpc.vpc_id
  private_app_subnet_az1_id         = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id         = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az1_id        = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id        = module.vpc.private_data_subnet_az2_id
}

module "security-group" {
  source = "../module/security-group"
  vpc_id = module.vpc.vpc_id
}

# creating Key for instances
module "key" {
  source = "../module/key"
}

# Creating Application Load balancer
module "alb" {
  source         = "../module/alb"
  project_name   = module.vpc.project_name
  alb_sg_id      = module.security-group.alb_sg_id
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id         = module.vpc.vpc_id
}

module "asg" {
  source         = "../module/asg"
  project_name   = module.vpc.project_name
  key_name       = module.key.key_name
  client_sg_id   = module.security-group.client_sg_id
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  tg_arn         = module.alb.tg_arn

}

# creating RDS instance

module "rds" {
  source         = "../module/rds"
  db_sg_id       = module.security-group.db_sg_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
  db_username    = var.db_username
  db_password    = var.db_password
}

# create cloudfront distribution 
module "cloudfront" {
  source = "../module/cloudfront"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name = module.alb.alb_dns_name
  additional_domain_name = var.additional_domain_name
  project_name = module.vpc.project_name
}

# Add record in route 53 hosted zone

module "route53" {
  source = "../module/route53"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id

}
