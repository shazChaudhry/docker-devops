module "elk_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_nat_gateway      = true
  map_public_ip_on_launch = true
  enable_dhcp_options     = true
  single_nat_gateway      = true

  cidr = "10.0.0.0/26"

  azs             = ["${data.aws_availability_zones.all.names}"]
  # azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["10.0.0.0/28", "10.0.0.16/28"]
  public_subnets  = ["10.0.0.32/28", "10.0.0.48/28"]

  dhcp_options_domain_name         = "${var.DnsZoneName}"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  dhcp_options_tags = {
    Name = "DevOps Internal_DHCP"
  }

  vpc_tags = {
    Name = "${var.tags[1]}_vpc"
  }

  public_subnet_tags = {
    Name = "${var.tags[1]}_public_subnets"
  }

  public_route_table_tags = {
    Name = "${var.tags[1]}_public_route_table"
  }

  private_subnet_tags = {
    Name = "${var.tags[1]}_private_subnet"
  }

  private_route_table_tags = {
    Name = "${var.tags[1]}_private_route_table"
  }

  nat_gateway_tags = {
    Name = "${var.tags[1]}_nat_gateway"
  }

  nat_eip_tags = {
    Name = "${var.tags[1]}_nat_eip"
  }

  igw_tags = {
    Name = "${var.tags[1]}_igw"
  }

  tags = {
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
    Terraform   = "true"
  }
}
