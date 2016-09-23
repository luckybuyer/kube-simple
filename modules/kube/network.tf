resource "aws_subnet" "master" {
  vpc_id = "${var.vpc_id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "kube" {
  subnet_id = "${aws_subnet.master.id}"
  route_table_id = "${var.route_table_id}"
}
