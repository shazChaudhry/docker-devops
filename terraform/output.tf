output "elk_bastion_public_ip" {
  value = "${module.elk_bastion.public_ip[0]}"
}

output "elk_master_private_ip" {
  value = "${module.elk_master.private_ip[0]}"
}

output "elk_worker_1_private_ip" {
  value = "${module.elk_worker_1.private_ip[0]}"
}

output "elb_dns_name" {
  value = "${aws_elb.elk_elb.dns_name}"
}
