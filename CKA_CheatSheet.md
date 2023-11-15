# Pods and Workloads in Kubernetes

This document provides essential information for creating Pods in Kubernetes, useful for preparing for the Certified Kubernetes Administrator (CKA) exam.

## Creating a Pod with kubectl

Here is a command to create a pod with certain specifications using `kubectl`:

```sh
kubectl run my-pod --image=nginx --restart=Never --port=80 --env="NAME=VALUE" --labels="key=value"
```
- `my-pod`: This is the name given to the created pod, which you can use to refer to the pod within your Kubernetes cluster.

- `--image=nginx`: This flag tells Kubernetes to use the `nginx` container image for the pod. This image will be pulled from the container registry.

- `--restart=Never`: This restart policy means the pod will not automatically restart if it stops or fails. The alternatives are `Always`, which will restart the pod indefinitely, and `OnFailure`, which will restart the pod only if it exits with an error.

- `--port=80`: This specifies that the container exposes port 80 to the Kubernetes cluster. This doesn't make the port accessible outside the cluster; for external access, you would need to create a Service or an Ingress.

- `--env="NAME=VALUE"`: This sets an environment variable `NAME` with the value `VALUE` within the container. Environment variables are commonly used for configuring applications.

- `--labels="key=value"`: This adds a label with key `key` and value `value` to the pod. Labels are used in Kubernetes to organize and select subsets of objects.

- `--dry-run=client`: The --dry-run flag is used in kubectl to simulate the execution of a command without making any actual changes to the cluster. It is particularly useful for generating resource manifest definitions without creating them, allowing us to verify configurations before they are effectively deployed.


**YAML remember:** For instance, by appending `--dry-run=client` -o yaml to a kubectl command, it will produce the YAML definition of the resource without creating it.

This will create the following .yaml file:
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    key: value
  name: my-pod
spec:
  containers:
  - image: nginx
    name: my-pod
    env:
    - name: NAME
      value: "VALUE"
    ports:
    - containerPort: 80
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
```

## Creating a Deployment (auto-scaling pods group) with kubectl

The `kubectl create deployment` command has the following flags:

**--filename, -f:** Specifies the name of a file containing the Deployment definition.

**--dry-run, -n:** Performs a dry run of the command without creating any resources.

**--output, -o:** Specifies the output format of the command.

**--replicas:** Selects the number of replicas of the deployment.


```sh
kubectl create deployment my-deployment --image=nginx:latest --replicas=3 --labels=app=nginx --selector=app=nginx -o my-deployment.yaml
```

The my-deployment.yaml file will look like this:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  labels:
    app: nginx
  name: my-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:latest
        name: nginx
```
In case that we want to edit the container ports of the deployment we created, we will need to update it manually via:
```sh
kubectl edit deployment my-deployment
```
And add it into the spec of the pod.

# Networking in Kubernetes

## Services
This section provides a brief summary of creating a Kubernetes service. A service in Kubernetes is an abstraction which defines a logical set of pods and a policy by which to access them. This can sometimes be referred to as a micro-service.

## Types of Services
- **ClusterIP**: Exposes the service on an internal IP in the cluster. This type is only reachable within the cluster.
- **NodePort**: Exposes the service on the same port of each selected node in the cluster using NAT. It makes a service accessible from outside the cluster using `<NodeIP>:<NodePort>`.
- **LoadBalancer**: Exposes the service externally using a cloud provider's load balancer.

## Creating a Service
To create a service, you can use the `kubectl` command-line tool. The most basic way to create a service is to use the `kubectl expose` command, which exposes a resource as a new Kubernetes service.

### Example Command
To create a service of type `ClusterIP`, you can use the following command:

```bash
kubectl expose deployment my-deployment --type=ClusterIP --name=my-service --port=8080 --target-port=8080 -o yaml > my-service.yaml
```
This will create the following .yaml:
```yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: my-deployment
  name: my-service
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    app: my-deployment
  type: ClusterIP
status:
  loadBalancer: {}
```
### NodePort
The NodePort service exposes a port between 30000 - 32767 for the external traffic outside the cluster. It can be found in the spec of the service:

```yaml
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 8080
    nodePort: 30299
```
## Ingress - HTTPRoute

An Ingress resource defines rules for incoming HTTP/S traffic, specifying how traffic should be routed to different services within a Kubernetes cluster.

![Ingress](https://kubernetes.io/docs/images/ingress.svg)

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: multihost-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: apache.fran.test
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: apache-service
            port:
              number: 8000
  - host: tomcat.fran.test
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: tomcat-service
            port:
              number: 8080
```
In this example, we use the nginx controller, and we have two prerequisites, one for Apache and another for Tomcat services. The ingress will redirect traffic using the "host" key to the specified "port". For example, the Tomcat pod's service should have port 8080 open to accept the traffic redirected by the ingress.

The **ingress controller** is the component responsible for fulfilling Ingress resources, acting as the entry point to handle external traffic that needs to be distributed to services within the Kubernetes cluster.

Example: [nginx-controller](https://github.com/kubernetes/ingress-nginx)


## Network Policies
Kubernetes Network Policies are a way to define rules and restrictions for the communication between pods within a Kubernetes cluster. 

For example, imagine we want a communication between pods with a frontend role to pods with a backend role:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
spec:
  podSelector:
    matchLabels:
      app: frontend
  ingress:
    - from:
      - podSelector:
          matchLabels:
            app: backend
```

We can previously match the pods labels as "frontend" or "backend" to ensure the routing traffic success.

# Storage in Kubernetes
