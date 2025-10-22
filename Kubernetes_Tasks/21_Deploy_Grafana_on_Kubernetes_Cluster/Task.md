### Task : Deploy Grafana on Kubernetes Cluster

The Nautilus DevOps teams is planning to set up a Grafana tool to collect and analyze analytics from some applications. They are planning to deploy it on Kubernetes cluster. Below you can find more details.



1.) Create a deployment named grafana-deployment-xfusion using any grafana image for Grafana app. Set other parameters as per your choice.


2.) Create NodePort type service with nodePort 32000 to expose the app.


You need not to make any configuration changes inside the Grafana app once deployed, just make sure you are able to access the Grafana login page.


### What I Did

Here are the YAML files for the deployment and service:

deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana-deployment-xfusion
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana
        ports:
        - containerPort: 3000
```

service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: grafana-service
spec:
  type: NodePort
  selector:
    app: grafana
  ports:
  - port: 3000
    targetPort: 3000
    nodePort: 32000
```

Let's create the deployment and service:


bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml


After the deployment is created, you can verify the status of the deployment and pods:


bash
kubectl get deployment grafana-deployment-xfusion
kubectl get pods


Once the pod is running, you can access the Grafana login page in the browser using the NodePort:


bash
http://<NodeIP>:32000


Replace <NodeIP> with the IP address of one of the nodes in your Kubernetes cluster.

Verification Steps:

1. Verify deployment creation: kubectl get deployment grafana-deployment-xfusion
2. Verify pod creation: kubectl get pods
3. Verify service creation: kubectl get svc
4. Access Grafana login page in the browser: http://<NodeIP>:32000
