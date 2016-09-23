variable "apiserver_dns_name" {}

variable "controller_instance_type" {
  default = "m3.medium"
}
variable "worker_instance_type" {
  default = "m3.medium"
}
variable "worker_min_count" {
  default = 1
}
varialbe "worker_max_count" {
  default = 1
}
variable "worker_desired_count" {
  default = 1
}
