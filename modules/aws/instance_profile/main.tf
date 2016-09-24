# controller
resource "aws_iam_role" "controller" {
  name = "kube-controller"
  path = "/"
  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      }
    }
  ],
  "Version": "2012-10-17"
}
EOF
}
resource "aws_iam_role_policy" "controller" {
  name = "kube-controller"
  role = "${aws_iam_role.controller.id}"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "elasticloadbalancing:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}
resource "aws_iam_instance_profile" "controller" {
  name = "kube-controller"
  path = "/"
  roles = ["${aws_iam_role.controller.name}"]
}

# worker
resource "aws_iam_role" "worker" {
  name = "kube-worker"
  path = "/"
  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      }
    }
  ],
  "Version": "2012-10-17"
}
EOF
}
resource "aws_iam_role_policy" "worker" {
  name = "kube-worker"
  role = "${aws_iam_role.worker.id}"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": "ec2:Describe*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "ec2:AttachVolume",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "ec2:DetachVolume",
      "Effect": "Allow",
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}
EOF
}
resource "aws_iam_instance_profile" "worker" {
  name = "kube-worker"
  path = "/"
  roles = ["${aws_iam_role.worker.name}"]
}

output "controller_id" {
  value = "${aws_iam_instance_profile.controller.id}"
}

output "controller_arn" {
  value = "${aws_iam_instance_profile.controller.arn}"
}

output "worker_id" {
  value = "${aws_iam_instance_profile.worker.id}"
}

output "worker_arn" {
  value = "${aws_iam_instance_profile.worker.arn}"
}
