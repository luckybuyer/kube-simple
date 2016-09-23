variable "kubeapi_dns_name" {}
# the default expiracy of the certificates are relatively long
# If you can automatically issue certs, like with Vault, set them short.
variable "ca_root_validity_period_hours" {
  default = 87600  # 10 years
}
variable "ca_root_early_renewal_hours" {
  default = 8760  # 1 year
}
variable "cert_validity_period_hours" {
  default = 17520
}
variable "cert_renewl_hours" {
  default = 8760
}
variable "etcd_endpoints" {
  default = "http://10.0.0.50:2379"
}
variable "controller_ip" {
  default = "10.0.0.50"
}
variable "pod_cidr" {
  default = "10.2.0.0/16"
}
variable "service_cidr" {
  default = "10.3.0.0/16"
}
variable "dns_service_ip" {
  default = "10.3.0.10"
}
variable "hyperkube_image_repo" {
  default = "quay.io/coreos/hyperkube"
}
variable "k8s_version" {
  default = "v1.2.4_coreos.cni.1"
}
