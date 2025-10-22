### Task : Deploy Jenkins on Kubernetes

The Nautilus DevOps team is planning to set up a Jenkins CI server to create/manage some deployment pipelines for some of the projects. They want to set up the Jenkins server on Kubernetes cluster. Below you can find more details about the task:

1) Create a namespace jenkins

2) Create a Service for jenkins deployment. Service name should be jenkins-service under jenkins namespace, type should be NodePort, nodePort should be 30008

3) Create a Jenkins Deployment under jenkins namespace, It should be name as jenkins-deployment , labels app should be jenkins , container name should be jenkins-container , use jenkins/jenkins image , containerPort should be 8080 and replicas count should be 1.

Make sure to wait for the pods to be in running state and make sure you are able to access the Jenkins login screen in the browser before hitting the Check button.


### What I Did

### Here are the YAML files for the namespace, service, and deployment:

Namespace:
```
apiVersion: v1
kind: Namespace
metadata:
  name: jenkins
```

Service:
```
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
  namespace: jenkins
spec:
  type: NodePort
  selector:
    app: jenkins
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: 30008
```

Deployment:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deployment
  namespace: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins-container
        image: jenkins/jenkins
        ports:
        - containerPort: 8080
```

Let's create the namespace, service, and deployment:


bash
kubectl create namespace jenkins
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml


After the deployment is created, you can verify the status of the deployment and pods:


bash
kubectl get deployment -n jenkins
kubectl get pods -n jenkins


Once the pod is running, you can access the Jenkins login screen in the browser using the NodePort:


bash
http://<NodeIP>:30008


Replace <NodeIP> with the IP address of one of the nodes in your Kubernetes cluster.

Verification Steps:

1. Verify namespace creation: kubectl get namespace jenkins
2. Verify service creation: kubectl get svc -n jenkins
3. Verify deployment creation: kubectl get deployment -n jenkins
4. Verify pod creation: kubectl get pods -n jenkins
5. Access Jenkins login screen in the browser: http://<NodeIP>:30008


### Yes, we can create the namespace in an imperative manner using the kubectl create namespace command:


bash
kubectl create namespace jenkins


This will create the jenkins namespace immediately.

So, to create all the resources (namespace, service, and deployment) in an imperative manner, we can use the following commands:


bash
kubectl create namespace jenkins
kubectl create deployment jenkins-deployment --image=jenkins/jenkins --port=8080 --replicas=1 --namespace=jenkins
kubectl expose deployment jenkins-deployment --type=NodePort --port=8080 --node-port=30008 --namespace=jenkins


These commands will create the namespace, deployment, and service in an imperative manner.

Here's a brief explanation of each command:

1. kubectl create namespace jenkins: Creates a new namespace named jenkins.
2. kubectl create deployment jenkins-deployment ...: Creates a new deployment named jenkins-deployment with the specified image and port.
3. kubectl expose deployment jenkins-deployment ...: Exposes the deployment as a service with the specified type and port.

Note that the --namespace flag is used to specify the namespace for the deployment and service.
