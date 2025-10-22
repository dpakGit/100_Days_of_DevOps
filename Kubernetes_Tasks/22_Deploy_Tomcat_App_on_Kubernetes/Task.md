### Task : Deploy Tomcat App on Kubernetes

A new java-based application is ready to be deployed on a Kubernetes cluster. The development team had a meeting with the DevOps team to share the requirements and application scope. The team is ready to setup an application stack for it under their existing cluster. Below you can find the details for this:


Create a namespace named tomcat-namespace-xfusion.

Create a deployment for tomcat app which should be named as tomcat-deployment-xfusion under the same namespace you created. Replica count should be 1, the container should be named as tomcat-container-xfusion, its image should be gcr.io/kodekloud/centos-ssh-enabled:tomcat and its container port should be 8080.

Create a service for tomcat app which should be named as tomcat-service-xfusion under the same namespace you created. Service type should be NodePort and nodePort should be 32227.


Before clicking on Check button please make sure the application is up and running.


You can use any labels as per your choice.


### What I Did

### Here are the YAML files for the namespace, deployment, and service:

namespace.yaml
```
apiVersion: v1
kind: Namespace
metadata:
  name: tomcat-namespace-xfusion
```

Or You can create the namespace using the following imperative command:


```
kubectl create namespace tomcat-namespace-xfusion
```

deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tomcat-deployment-xfusion
  namespace: tomcat-namespace-xfusion
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tomcat
  template:
    metadata:
      labels:
        app: tomcat
    spec:
      containers:
      - name: tomcat-container-xfusion
        image: gcr.io/kodekloud/centos-ssh-enabled:tomcat
        ports:
        - containerPort: 8080
```

service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: tomcat-service-xfusion
  namespace: tomcat-namespace-xfusion
spec:
  type: NodePort
  selector:
    app: tomcat
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 32227
```

Let's create the namespace, deployment, and service:


bash
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml


After the deployment is created, you can verify the status of the deployment and pods:


bash
kubectl get deployment -n tomcat-namespace-xfusion
kubectl get pods -n tomcat-namespace-xfusion


Once the pod is running, you can access the Tomcat application in the browser using the NodePort:


bash
http://<NodeIP>:32227


Replace <NodeIP> with the IP address of one of the nodes in your Kubernetes cluster.

Verification Steps:

1. Verify namespace creation: kubectl get namespace tomcat-namespace-xfusion
2. Verify deployment creation: kubectl get deployment -n tomcat-namespace-xfusion
3. Verify pod creation: kubectl get pods -n tomcat-namespace-xfusion
4. Verify service creation: kubectl get svc -n tomcat-namespace-xfusion
5. Access Tomcat application in the browser: http://<NodeIP>:32227
