Task : 
There is an application that needs to be deployed on Kubernetes cluster under Apache web server. The Nautilus application development team has asked the DevOps team to deploy it. We need to develop a template as per requirements mentioned below:


Create a namespace named as httpd-namespace-xfusion.

Create a deployment named as httpd-deployment-xfusion under newly created namespace. For the deployment use httpd image with latest tag only and remember to mention the tag i.e httpd:latest, and make sure replica counts are 2.

Create a service named as httpd-service-xfusion under same namespace to expose the deployment, nodePort should be 30004.

### What I Did

Here's a YAML template that creates the required resources:

```
apiVersion: v1
kind: Namespace
metadata:
  name: httpd-namespace-xfusion

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deployment-xfusion
  namespace: httpd-namespace-xfusion
spec:
  replicas: 2
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: httpd
        image: httpd:latest
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: httpd-service-xfusion
  namespace: httpd-namespace-xfusion
spec:
  selector:
    app: httpd
  type: NodePort
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30004
    protocol: TCP
```

To apply this template, save it to a file (e.g., httpd-deployment.yaml) and run the following command:


bash
kubectl apply -f httpd-deployment.yaml


This will create the following resources:

1. A namespace named httpd-namespace-xfusion.
2. A deployment named httpd-deployment-xfusion under the newly created namespace, using the httpd:latest image with 2 replicas.
3. A service named httpd-service-xfusion under the same namespace, exposing the deployment on NodePort 30004.

You can verify the resources by running the following commands:


bash

kubectl get namespace

kubectl get deployments -n httpd-namespace-xfusion

kubectl get svc -n httpd-namespace-xfusion
