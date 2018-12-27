module "elk_master" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[0]}"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${aws_security_group.elk_instances_sg.id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.private_subnets[1]}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y busybox
              echo "Hello, elk_master" > index.html
              nohup busybox httpd -f -p 8080 &
              # Install docker
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              EOF

  tags = {
    Name        = "${var.elk_instance_tags[0]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
  }

  volume_tags = {
    Name        = "${var.elk_instance_tags[0]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
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

module "elk_worker_1" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[1]}"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${aws_security_group.elk_instances_sg.id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.private_subnets[1]}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y busybox
              echo "Hello, elk_worker_1" > index.html
              nohup busybox httpd -f -p 8080 &
              # Install docker
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              EOF

  tags = {
    Name        = "${var.elk_instance_tags[1]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
  }

  volume_tags = {
    Name        = "${var.elk_instance_tags[1]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
  }
}

resource "aws_route53_record" "elk_worker_1" {
  zone_id = "${aws_route53_zone.elk.zone_id}"
  name    = "elk_worker_1.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.elk_worker_1.private_ip}"]
}

module "elk_bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[2]}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.elk_bastion_sg.id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.public_subnets[0]}"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              # Install ansible
              pip install ansible
              EOF

  tags = {
    Name        = "${var.elk_instance_tags[2]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
  }

  volume_tags = {
    Name        = "${var.elk_instance_tags[2]}"
    Owner       = "${var.tags[0]}"
    Environment = "${var.tags[1]}"
  }
}

resource "aws_route53_record" "elk_bastion" {
  zone_id = "${aws_route53_zone.elk.zone_id}"
  name    = "elk_bastion.${var.DnsZoneName}"
  type    = "A"
  ttl     = "300"
  records = ["${module.elk_bastion.private_ip}"]
}
