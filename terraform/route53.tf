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

# https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-values-weighted.html?shortFooter=true#rrsets-values-weighted-name
resource "aws_route53_record" "elk_master" {
  zone_id = "${aws_route53_zone.elk.zone_id}"
  name    = "elk_master.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.elk_master.private_ip}"]
}

resource "aws_route53_record" "elk_worker_1" {
  zone_id = "${aws_route53_zone.elk.zone_id}"
  name    = "elk_worker_1.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.elk_worker_1.private_ip}"]
}

resource "aws_route53_record" "elk_bastion" {
  zone_id = "${aws_route53_zone.elk.zone_id}"
  name    = "elk_bastion.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.elk_bastion.private_ip}"]
}
