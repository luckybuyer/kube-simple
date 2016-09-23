data "template_file" "controller_cloudconfig" {
  template = "${file("${path.module}/templates/controller.yml")}"

  vars = {
    etcd_endpoints = "${var.etcd_endpoints}"
    pod_cidr = "${var.pod_cidr}"
    k8s_version = "${var.k8s_version}"
    hyperkube_image_repo = "${var.hyperkube_image_repo}"
    dns_service_ip = "${var.dns_service_ip}"
    service_cidr = "${var.service_cidr}"
    ca_cert = "${tls_self_signed_cert.root.cert_pem}"
    apiserver_cert = "${tls_locally_signed_cert.kube_apiserver.cert_pem}"
    apiserver_key = "${tls_private_key.kube_apiserver.private_key_pem}"
  }
}

data "template_file" "worker_cloudconfig" {
  template = "${file("${path.module}/templates/worker.yml")}"

  vars = {
    etcd_endpoints = "${var.etcd_endpoints}"
    k8s_version = "${var.k8s_version}"
    hyperkube_image_repo = "${var.hyperkube_image_repo}"
    secure_apiservers = "${var.controller_ip}:443"
    dns_service_ip = "${var.dns_service_ip}"
    controller_ip = "${var.controller_ip}"
    ca_cert = "${tls_self_signed_cert.root.cert_pem}"
    worker_cert = "${tls_locally_signed_cert.kube_worker.cert_pem}"
    worker_key = "${tls_private_key.kube_worker.private_key_pem}"
  }
}
