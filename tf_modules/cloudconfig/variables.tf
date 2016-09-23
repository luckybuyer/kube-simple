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
variable "kubeapi_dns_name" {}
