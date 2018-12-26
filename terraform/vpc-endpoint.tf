resource "aws_vpc_endpoint" "elk_vpc_s3" {
  vpc_id          = "${module.elk_vpc.vpc_id}"
  service_name    = "com.amazonaws.eu-west-2.s3"
  route_table_ids = ["${module.elk_vpc.private_route_table_ids}", "${module.elk_vpc.public_route_table_ids}"]
  auto_accept     = true
}
