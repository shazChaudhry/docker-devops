resource "aws_route53_zone" "main" {
  name    = "${var.DnsZoneName}"
  vpc {
    vpc_id  = "${module.elk_vpc.vpc_id}"
  }
  comment = "private hosted zone"

  tags {
    Name = "route53_zone"
  }
}
