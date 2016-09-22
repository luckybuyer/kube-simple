variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

module "vpc" {
  source = "../tf_modules/vpc"
  aws_region = "${var.aws_region}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
}
