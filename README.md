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

## Deploying Test Services

Each test service has it's own `deploy.sh` script that will build a docker image using minikube's docker daemon, meaning the cluster can run the image without it having to be exported to an external registry.

It also deploys the appropriate kubernetes resources for the service.

###  Connecting to services outside kubernetes

To access services in the cluster using curl, browser postman etc, run the following command in a separate terminal:

```shell
minikube tunnel
```

The service should now be accessible via <<<<http://localhost:<port_nunber>>>>>

Note: If you specify a `host` in your services ingress rules section, you will need to add a line similar to the following to yout `/etc/hosts` file:

```
127.0.0.1 your-domain.local
```

## Test Services

3 test services are provided to allow testing connectiviting between external clients and between services within the cluster.
These can be deployed using the `deploy.sh` scripts within each test service.

`deploy.sh 1.0`

The deployment scripts take a version number that can be altered to test deployment strategies moving from one version to another.

### Time Service

Returns the current date and time.

Example:

```shell
$ curl http://localhost:32476
2022-11-09T11:03:53.866Z
```

###  User Service

Returns a username based on a URL parameter.

Example:

```shell
$ curl http://localhost:32477/2
Jane
```

###  Dashboard Service

Calls the user and time services to generate a string containing the time and a user name.

Example:

```shell
$ curl http://localhost:32478
Hello Jane, The time is 2022-11-09T11:03:53.866Z
```
