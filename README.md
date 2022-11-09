# Service Mesh

This repo implements a framework for evaluating different service mesh technologies within a local minikube instance.

##  Installing Minikube

Each service mesh deployment requires a local kubernetes cluster to be running. To install minikube, run the following:

```shell
minikube/install.sh
```

This will install and start a local cluster and add an entry to your kube config to allow access via kubectl.

You can switch kubectl to point to minikube at any time by running:

```shell
kubectl config set-context minikube
```

Note: If you wish to evaluate a different service mesh, it is advisable that you delete any previous clusters
containing a service mesh implementation using:

```shell
minikube delete
```
