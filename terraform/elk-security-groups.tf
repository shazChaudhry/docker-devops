resource "aws_security_group" "elk_bastion_sg" {
  name = "elk-bastion-sg"
  vpc_id      = "${module.elk_vpc.vpc_id}"

  # Inbound HTTP from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elk_instances_sg" {
  name = "elk-instances-sg"
  vpc_id      = "${module.elk_vpc.vpc_id}"

  # Inbound HTTP from anywhere
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.elk_bastion_sg.id}", "${aws_security_group.elk_elb_sg.id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elk_elb_sg" {
  name = "elk-elb-sg"
  vpc_id      = "${module.elk_vpc.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
