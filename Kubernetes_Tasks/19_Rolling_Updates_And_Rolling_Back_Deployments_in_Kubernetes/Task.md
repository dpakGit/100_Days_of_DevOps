### Task : Rolling Updates And Rolling Back Deployments in Kubernetes

There is a production deployment planned for next week. The Nautilus DevOps team wants to test the deployment update and rollback on Dev environment first so that they can identify the risks in advance. Below you can find more details about the plan they want to execute.

Create a namespace nautilus. Create a deployment called httpd-deploy under this new namespace, It should have one container called httpd, use httpd:2.4.27 image and 4 replicas. The deployment should use RollingUpdate strategy with maxSurge=1, and maxUnavailable=2. Also create a NodePort type service named httpd-service and expose the deployment on nodePort: 30008.

Now upgrade the deployment to version httpd:2.4.43 using a rolling update.

Finally, once all pods are updated undo the recent update and roll back to the previous/original version.

Note:

a. The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

b. Please make sure you only use the specified image(s) for this deployment and as per the sequence mentioned in the task description. If you mistakenly use a wrong image and fix it later, that will also distort the revision history which can eventually fail this task.


### What I Did

Here are the steps to create the deployment and service, upgrade the deployment, and roll back to the previous version:

Step 1: Create namespace

bash
kubectl create namespace nautilus


Step 2: Create deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deploy
  namespace: nautilus
spec:
  replicas: 4
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
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
        image: httpd:2.4.27
        ports:
        - containerPort: 80
```

Let's create the deployment:

bash
kubectl apply -f deployment.yaml


Step 3: Create NodePort service
```
apiVersion: v1
kind: Service
metadata:
  name: httpd-service
  namespace: nautilus
spec:
  type: NodePort
  selector:
    app: httpd
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30008
```

Let's create the service:

bash
kubectl apply -f service.yaml


Step 4: Upgrade deployment to httpd:2.4.43

bash
kubectl set image deployment/httpd-deploy httpd=httpd:2.4.43 -n nautilus


Step 5: Verify rollout status

bash
kubectl rollout status deployment/httpd-deploy -n nautilus


Step 6: Roll back to previous version

bash
kubectl rollout undo deployment/httpd-deploy -n nautilus


Verification Steps:

1. Verify deployment and service creation: kubectl get deployment,svc -n nautilus
2. Verify rollout status after upgrade: kubectl rollout status deployment/httpd-deploy -n nautilus
3. Verify pods are running with new image version after upgrade: kubectl get pods -n nautilus -o jsonpath='{.items[*].spec.containers[*].image}'
4. Roll back to previous version and verify: kubectl rollout undo deployment/httpd-deploy -n nautilus and kubectl get pods -n nautilus -o jsonpath='{.items[*].spec.containers[*].image}'
