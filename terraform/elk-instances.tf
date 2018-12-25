module "elk_master" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[0]}"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${module.elk_backend_app_sg.this_security_group_id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.private_subnets[0]}"

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

module "elk_worker_1" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[1]}"
  associate_public_ip_address = false
  vpc_security_group_ids      = ["${module.elk_backend_app_sg.this_security_group_id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.private_subnets[0]}"

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

module "elk_bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  ami                         = "${data.aws_ami.ami.id}"
  instance_type               = "t2.micro"
  iam_instance_profile        = "shaz"
  name                        = "${var.elk_instance_tags[2]}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${module.elk_bastion_sg.this_security_group_id}"]
  key_name                    = "personal"
  subnet_id                   = "${module.elk_vpc.public_subnets[0]}"

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
