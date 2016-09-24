# instance_profile

Create instance profile for kube-master and kube-controller.

The kube-master role grants access to "ec2:\*" and ELB. This allows kubernetes
to configure [load balancers](http://kubernetes.io/docs/user-guide/services/#type-loadbalancer).

The kube-worker role grants access to attach/detach EBS volumes. This allows
kubernetes to manage [awsElasticBlockStore](http://kubernetes.io/docs/user-guide/volumes/#awselasticblockstore).

## Variables

There are no input to this module.

## Outputs

* `controller_id`, `controller_arn`: id/arn of the instance profile of kube-controller
* `worker_id`, `worker_arn`: id/arn of the instance profile of kube-worker
