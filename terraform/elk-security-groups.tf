module "elk_frontend_app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "elk_frontend_app_sg"
  description         = "Security Group for resources in the ELK pubic subnets"
  vpc_id              = "${module.elk_vpc.vpc_id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    Name = "elk_frontend_app_sg"
  }
}

module "elk_backend_app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "elk_backend_app_sg"
  description         = "Security Group for resources in the ELK private subnets"
  vpc_id              = "${module.elk_vpc.vpc_id}"
  ingress_cidr_blocks = ["${module.elk_vpc.public_subnets_cidr_blocks}"]
  ingress_rules       = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    Name = "elk_backend_app_sg"
  }
}

module "elk_bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "elk_bastion_sg"
  description         = "Security Group for the bastion server in the ELK stack"
  vpc_id              = "${module.elk_vpc.vpc_id}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    Name = "elk_bastion_sg"
  }
}
