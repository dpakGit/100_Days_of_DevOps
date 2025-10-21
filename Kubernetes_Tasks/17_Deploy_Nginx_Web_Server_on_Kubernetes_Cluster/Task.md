### Task : 

Some of the Nautilus team developers are developing a static website and they want to deploy it on Kubernetes cluster. They want it to be highly available and scalable. Therefore, based on the requirements, the DevOps team has decided to create a deployment for it with multiple replicas. Below you can find more details about it:

Create a deployment using nginx image with latest tag only and remember to mention the tag i.e nginx:latest. Name it as nginx-deployment. The container should be named as nginx-container, also make sure replica counts are 3.

Create a NodePort type service named nginx-service. The nodePort should be 30011.

### What I Did

### Here is the YAML configuration for the deployment and service:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
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
      - name: nginx-container
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30011
```

Let's create the deployment and service:


bash
kubectl apply -f deployment.yaml


After the deployment is created, you can verify the status of the deployment and pods:


bash
kubectl get deployment nginx-deployment
kubectl get pods


You can also verify the service:


bash
kubectl get svc nginx-service


Once the deployment and service are created, you can access the nginx service using the NodePort:


bash
http://<NodeIP>:30011


Replace <NodeIP> with the IP address of one of the nodes in your Kubernetes cluster.

Verification Steps:

1. Create the deployment and service using kubectl apply -f deployment.yaml
2. Verify the deployment status using kubectl get deployment nginx-deployment
3. Verify the pod status using kubectl get pods
4. Verify the service status using kubectl get svc nginx-service
5. Access the nginx service using the NodePort http://<NodeIP>:30011

