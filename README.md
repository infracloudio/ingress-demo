# Ingress Demo

This repo shows how to create an ingress controller in a Kubernetes cluster, create ingress resources and expose a service outside the cluster using ingress controller.

This demo is primarily aimed for AWS and will need modifications if running on any other cloud.

## Prerequisites

- Kops and terraform should be installed on your machine for this demo to work

- You can use Kops to create a cluster. We used instrcutions at [this link](https://github.com/kubernetes/kops/blob/master/docs/aws.md) to create a cluster.

## Components

### Ingress Controller

The ingress controller watches the ingress resources and makes changes to load balancer accordingly. All of manifest code in `nginx-ingress.yaml` is for creating ingress-controller and related serviceaccounts and role/role-bindings etc. 

### Load Balancer

The LoadBalancer in this case is a AWS LB. The manifest `service-l4.yaml` creates the LB with additional details specific to AWS. ATM this creates a classic LB, and not a ALB. You will notice some annotations being used and a full list of annotations [can be found here](https://kubernetes.io/docs/concepts/cluster-administration/cloud-providers/). The actual code which has all annotations [can be found here](https://github.com/kubernetes/kubernetes/blob/master/pkg/cloudprovider/providers/aws/aws.go)

### Ingress Resources and sample app

Once the above two is setup, the ingress resources can be created which will be routed to specific pods. We are using two simple Go lang based apps to demonstrate path based and domain based routing. All of code resides in `ingress-demo.yaml`

For example as of this writing, the URLs ingresstest.infracloud.space/prod and ingresstest.infracloud.space/canary both are served by same load balancer using ingress and controllers.