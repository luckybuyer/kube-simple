resource "aws_security_group" "lb" {
  name = "sg_lb"
  vpc_id = "${var.vpc_id}"
  description = "sg for the public facing load balancer"
  # allow inbound on 22, 80, 443, 2222, icmp from internet
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 2222
    to_port = 2222
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "icmp"
  }
  tags = {
    Name = "sg_lb"
  }
}
resource "aws_security_group" "kube" {
  name = "sg_kube"
  vpc_id = "${var.vpc_id}"
  # allow all traffic among kube master and workers
  ingress {
    self = true
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  # allow inbound on 80, 443, icmp from lb
  ingress {
    security_groups = ["${aws_security_group.lb.id}"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  ingress {
    security_groups = ["${aws_security_group.lb.id}"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  ingress {
    security_groups = ["${aws_security_group.lb.id}"]
    from_port = 0
    to_port = 0
    protocol = "icmp"
  }
  # allow outbound on all
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "sg_kube"
  }
}
resource "aws_security_group" "rancher_master" {
  name = "sg_rancher_master"
  vpc_id = "${var.vpc_id}"
  # allow 22 from the internet
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  tags = {
    Name = "sg_rancher_master"
  }
}
