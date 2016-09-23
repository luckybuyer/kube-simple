resource "tls_private_key" "root" {
  algorithm = "ECDSA"
  ecdsa_curve = "P256"
}
resource "tls_self_signed_cert" "root" {
  key_algorithm = "${tls_private_key.root.algorithm}"
  private_key_pem = "${tls_private_key.root.private_key_pem}"

  validity_period_hours = "${var.ca_root_validity_period_hours}"
  early_renewal_hours = "${var.ca_root_early_renewal_hours}"

  is_ca_certificate = true

  allowed_uses = ["cert_signing"]

  subject {
    common_name = "Luckybuyer Inc. Root"
    organization = "Luckybuyer, Inc"
    organizational_unit = "IT"
    locality = "Beijing"
    province = "Beijing"
    country = "CN"
  }
}

# apiserver cert
resource "tls_private_key" "kube_apiserver" {
  algorithm = "ECDSA"
  ecdsa_curve = "P256"
}
data "tls_cert_request" "kube_apiserver" {
  key_algorithm = "${tls_private_key.kube_apiserver.algorithm}"
  private_key_pem = "${tls_private_key.kube_apiserver.private_key_pem}"
  dns_names = [
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster.local",
    "${var.kubeapi_dns_name}"
  ]
  subject {
    common_name = "kube-apiserver"
  }
}
resource "tls_locally_signed_cert" "kube_apiserver" {
  cert_request_pem = "${data.tls_cert_request.kube_apiserver.cert_request_pem}"

  ca_key_algorithm = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = "${var.cert_validity_period_hours}"
  early_renewal_hours = "${var.cert_renewl_hours}"
  allowed_uses = [
    "server_auth",
    "signing",
    "key_encipherment",
  ]
}

# worker cert
resource "tls_private_key" "kube_worker" {
  algorithm = "ECDSA"
  ecdsa_curve = "P256"
}
data "tls_cert_request" "kube_worker" {
  key_algorithm = "${tls_private_key.kube_worker.algorithm}"
  private_key_pem = "${tls_private_key.kube_worker.private_key_pem}"
  dns_names = [
    "*.*.compute.internal",
    "*.ec2.internal"
  ]
  subject {
    common_name = "kube-worker"
  }
}
resource "tls_locally_signed_cert" "kube_worker" {
  cert_request_pem = "${data.tls_cert_request.kube_worker.cert_request_pem}"

  ca_key_algorithm = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = "${var.cert_validity_period_hours}"
  early_renewal_hours = "${var.cert_renewl_hours}"
  allowed_uses = [
    "client_auth",
    "signing",
    "key_encipherment",
  ]
}

# admin cert
resource "tls_private_key" "kube_admin" {
  algorithm = "ECDSA"
  ecdsa_curve = "P256"
}
data "tls_cert_request" "kube_admin" {
  key_algorithm = "${tls_private_key.kube_admin.algorithm}"
  private_key_pem = "${tls_private_key.kube_admin.private_key_pem}"
  subject {
    common_name = "kube-admin"
  }
}
resource "tls_locally_signed_cert" "kube_admin" {
  cert_request_pem = "${data.tls_cert_request.kube_admin.cert_request_pem}"

  ca_key_algorithm = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = "${var.cert_validity_period_hours}"
  early_renewal_hours = "${var.cert_renewl_hours}"
  allowed_uses = [
    "client_auth",
    "signing",
    "key_encipherment",
  ]
}
