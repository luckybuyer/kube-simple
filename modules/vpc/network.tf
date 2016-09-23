resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.kube.id}"
}

resource "aws_route_table" "kube" {
  vpc_id = "${aws_vpc.kube.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
