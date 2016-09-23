data "aws_availability_zones" "available" {}

resource "aws_vpc" "kube" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "kube"
  }
  enable_dns_hostnames = true
}
