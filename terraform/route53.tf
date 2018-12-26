resource "aws_route53_zone" "elk" {
  name = "${var.DnsZoneName}"

  vpc {
    vpc_id = "${module.elk_vpc.vpc_id}"
  }

  comment = "DevOps private hosted zone"

  tags {
    Name = "route53_zone"
  }
}
