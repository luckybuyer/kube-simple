output "controller_cloudconfig" {
  value = "${data.template_file.controller_cloudconfig.rendered}"
}
output "worker_cloudconfig" {
  value = "${data.template_file.worker_cloudconfig.rendered}"
}
output "admin_key" {
  value = "${tls_private_key.kube_admin.private_key_pem}"
}
output "admin_cert" {
  value = "${tls_locally_signed_cert.kube_admin.cert_pem}"
}
output "root_ca" {
  value = "${tls_self_signed_cert.root.cert_pem}"
}
