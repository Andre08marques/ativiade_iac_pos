module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  azs         = var.azs

  vpc = {
    cidr           = var.vpc.cidr
    public_subnets = var.vpc.public_subnets
  }
}