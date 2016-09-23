data "aws_ami" "coreos" {
  most_recent = true
  filter {
    name = "name"
    values = ["CoreOS-${var.coreos_channel}*"]
  }
  filter {
    name = "virtualization-type"
    values = ["paravirtual"]
  }
}

resource "aws_instance" "master" {
  ami = "${aws_ami.coreos.id}"
  instance_type = "${var.instance_type_master}"

}
