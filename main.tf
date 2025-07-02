module "vpc" {

  source = "./modules/vpc"

  cidr_block = var.cidr_block
  pub_subnet = var.pub_subnet
  pri_subnet = var.pri_subnet
  azs        = var.azs
}