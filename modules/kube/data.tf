data "aws_availability_zones" "available" {}
data "aws_ami" "kube_master" {
  most_recent = true
  filter {
    name = "name"
    values = ["kube_master*"]
  }
  owners = ["self"]
}
data "aws_ami" "kube_worker" {
  most_recent = true
  filter {
    name = "name"
    values = ["kube_worker*"]
  }
  owners = ["self"]
}
