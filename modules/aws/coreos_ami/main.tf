variable "channel" {
  default = "stable"
  description = "CoreOS channel. One of 'stable', 'beta', 'alpha'"
}
variable "virtualization" {
  default = "hvm"
  description = "Instance virtualization type. One of 'paravirtual', 'hvm'"
}

data "aws_ami" "coreos" {
  most_recent = true
  filter {
    name = "name"
    values = ["CoreOS-${var.channel}*"]
  }
  filter {
    name = "virtualization-type"
    values = ["${var.virtualization}"]
  }
}

output "ami" {
  value = "${map(
    "id", "${data.aws_ami.coreos.id}",
    "name", "${data.aws_ami.coreos.name}",
    "description", "${data.aws_ami.coreos.description}"
  )}"
}
