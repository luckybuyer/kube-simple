output "vpc_id" {
  value = "${aws_vpc.kube.id}"
}
output "route_table_id" {
  value = "${aws_route_table.kube.id}"
}
