resource "aws_elb" "elk_elb" {
  name = "elk-elb"
  security_groups = ["${aws_security_group.elk_elb_sg.id}"]
  subnets = ["${module.elk_vpc.private_subnets[1]}", "${module.elk_vpc.public_subnets[0]}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 8080
    instance_protocol = "http"
  }
}

resource "aws_elb_attachment" "elk_master" {
  elb      = "${aws_elb.elk_elb.id}"
  instance = "${module.elk_master.id[0]}"
}

resource "aws_elb_attachment" "elk_worker_1" {
  elb      = "${aws_elb.elk_elb.id}"
  instance = "${module.elk_worker_1.id[0]}"
}
