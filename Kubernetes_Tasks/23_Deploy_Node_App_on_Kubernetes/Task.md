### Task : Deploy Node App on Kubernetes

The Nautilus development team has completed development of one of the node applications, which they are planning to deploy on a Kubernetes cluster. They recently had a meeting with the DevOps team to share their requirements. Based on that, the DevOps team has listed out the exact requirements to deploy the app. Find below more details:


Create a deployment using gcr.io/kodekloud/centos-ssh-enabled:node image, replica count must be 2.

Create a service to expose this app, the service type must be NodePort, targetPort must be 8080 and nodePort should be 30012.

Make sure all the pods are in Running state after the deployment.

You can check the application by clicking on NodeApp button on top bar.


You can use any labels as per your choice.

### What I did

### Here are the YAML files for the deployment and service:

deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: node-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: node
  template:
    metadata:
      labels:
        app: node
    spec:
      containers:
      - name: node-container
        image: gcr.io/kodekloud/centos-ssh-enabled:node
        ports:
        - containerPort: 8080
```

service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: node-service
spec:
  type: NodePort
  selector:
    app: node
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 30012
```

Let's create the deployment and service:


bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml


After the deployment is created, you can verify the status of the deployment and pods:


bash
kubectl get deployment
kubectl get pods


Once the pods are running, you can access the Node application by clicking on the NodeApp button on the top bar.

Verification Steps:

1. Verify deployment creation: kubectl get deployment
2. Verify pod creation: kubectl get pods
3. Verify service creation: kubectl get svc
4. Access Node application by clicking on NodeApp button.

Alternatively, you can also use imperative commands to create the deployment and service:


```
kubectl create deployment node-deployment --image=gcr.io/kodekloud/centos-ssh-enabled:node --replicas=2 --port=8080
```
```
kubectl expose deployment node-deployment --type=NodePort --port=8080 --node-port=30012
```

Make sure to wait for the pods to be in Running state after the deployment.
