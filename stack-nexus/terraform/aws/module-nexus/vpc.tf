module "infra_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> v3.0.0"

  name = "${var.customer}-${var.project}-${var.env}-vpc"
  cidr = var.cidr
  azs = data.aws_availability_zones.available.names

  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  
  single_nat_gateway = true
  enable_nat_gateway = true

  tags = local.standard_tags
}