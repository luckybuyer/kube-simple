# kube-cloud-config

Render CoreOS cloud-config used to boot kube-controller and kube-worker.

By default, the following setup is assumed:

* There are 2 roles: kube-controller and kube-worker
* machine/instance cidr: 10.0.0.0/16
* pod cidr: 10.2.0.0/16
* service cidr: 10.3.0.0/16
* Only one controller is deployed, which sits on 10.0.0.50
* SkyDNS is deployed at 10.3.0.10
* there can be multiple workers, which all connects to api server at 10.0.0.50:443

All of the above can be customized through variables.

The module also generates tls assets used by the api server, worker and admin.

* All assets uses ECDSA with P256
* root ca: valid for 10 years. Only used for signing other certs
* apiserver cert: used by kube-apiserver, only for server auth. Valid for kube public dns name
  and internal kubernetes domains, like "kubernetes.default.svc.cluster.local"
* worker cert: used by kube-workers, only for client auth. Valid for ec2 internal dns names,
  like "\*.\*.compute.internal".

These assets are saved in **plain text** in the terraform state. You must understand the implication of this.

It is recommended to encrypt the state. For a local state file, you may try [git-crypt](https://github.com/AGWA/git-crypt).

Components run on kube-controller:
* etcd, flannel
* kube-apiserver
* kube-controller-manager
* kube-scheduler
* kubelet
* kube-proxy
* kube-dns

Components run on kube-worker:
* flannel
* kube-proxy
* kubelet

## Variables

Required:

* `kubeapi_dns_name`: public dns name to the kube-apiserver

See also `variables.tf`.

## Output

* `root_ca`: certificate authority
* `admin_key`, `admin_cert`: admin cert intended to be used with kubeconfig
* `controller_cloudconfig`, `worker_cloudconfig`: CoreOS cloud-config.

The certificates can be used to generate a kubeconfig:
1. put the certs in safe keeping on your local machine, e.g., `terraform output root_ca > ~/.ssh/root_ca`. Do the same for admin key and admin cert.
2. create a kubeconfig to reference them. See also [Manually Generating kubeconfig](http://kubernetes.io/docs/user-guide/sharing-clusters/).

The generated cloud-config can be referenced in another module:

    module "cloud_config" {
      source = "tf_modules/cloudconfig"
      kubeapi_dns_name = "kube.example.com"
    }

    # launch controller
    resource "aws_instance" "kube_controller" {
      ...
      userdata = "${module.cloud_config.controller_cloudconfig}"
    }

See also `output.tf`

## Roadmap

* make kube-controller scalable
  - run a etcd cluster and make them discover each other
* better pki
  - run a vault service to automatically issue certificates to the workers. #zero-trust
