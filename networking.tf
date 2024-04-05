#### VPC Module ####
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "${var.env_name}-vpc"
  cidr            = var.vpc-cidr
  azs             = [local.az1, local.az2]
  public_subnets  = [var.public-subnet1-cidr, var.public-subnet2-cidr]
  # private_subnets = [var.private-subnet1-cidr, var.private-subnet2-cidr]
  map_public_ip_on_launch = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false

  create_igw = true

  tags = {
    Terraform   = "true"
    Environment = var.env_name
  }
}

#### Web Security group Module ####
module "web-sg" {
  source       = "terraform-aws-modules/security-group/aws"
  egress_rules = ["all-all"]


  name                = "${var.env_name}-websg"
  description         = "Security group for web app"
  depends_on          = [module.vpc]
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
   computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.web-sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
}