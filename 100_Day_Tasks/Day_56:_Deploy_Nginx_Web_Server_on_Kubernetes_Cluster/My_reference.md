### Task Overview

The task is to deploy a static website on a Kubernetes cluster using Nginx as the web server. The requirements are:

- High availability: The website should be accessible even if one or more instances (replicas) go down.
- Scalability: The website should be able to handle increased traffic by scaling up or down the number of instances.

To achieve this, the DevOps team will create:

1. A Deployment named nginx-deployment with multiple replicas (3) using the nginx:latest image.
2. A Service named nginx-service of type NodePort to expose the deployment to external traffic.

Use Case

This scenario is useful for deploying static websites or web applications that require high availability and scalability. By using a Deployment with multiple replicas, the website can:

- Handle increased traffic: If the website experiences a surge in traffic, the additional replicas can help distribute the load and ensure the website remains responsive.
- Recover from failures: If one or more replicas go down, the remaining replicas can continue to serve traffic, ensuring the website remains available.

The NodePort Service allows external traffic to access the website by exposing a specific port (30011) on each node in the cluster.

Benefits

This setup provides several benefits:

- High availability: Multiple replicas ensure the website remains accessible even if one or more instances go down.
- Scalability: Additional replicas can be added or removed as needed to handle changes in traffic.
- Load balancing: The Service will distribute traffic across the available replicas, ensuring no single instance is overwhelmed.
- Easy maintenance: The Deployment can be updated or rolled back without affecting the overall availability of the website.

Example YAML files

To accomplish this task, you would create two YAML files:

1. nginx-deployment.yaml:
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
```
2. nginx-service.yaml:
```
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30011
  selector:
    app: nginx
```
These YAML files define the Deployment and Service, respectively. You can apply them to your Kubernetes cluster using the kubectl apply command.


### Here's a step-by-step guide to accomplish the task:

Step 1: Create a YAML file for the deployment

Create a file named nginx-deployment.yaml with the following content:

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

This YAML file defines a Deployment named nginx-deployment with 3 replicas, using the nginx:latest image.

Step 2: Create a YAML file for the service

Create a file named nginx-service.yaml with the following content:

apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30011

This YAML file defines a Service named nginx-service of type NodePort, exposing port 80 and mapping it to port 30011 on the node.

Step 3: Apply the YAML files

Run the following commands to apply the YAML files:

bash
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml

These commands create the Deployment and Service in your Kubernetes cluster.

Step 4: Verify the deployment and service

Run the following commands to verify the deployment and service:

bash
kubectl get deployments
kubectl get pods
kubectl get svc

These commands display the status of the deployment, pods, and service.

Step 5: Access the service

You can access the service using the NodePort:

bash
http://<node-ip>:30011

Replace <node-ip> with the IP address of one of your cluster nodes.

That's it! You've successfully created a deployment and service for a static website using Nginx.

### To see the deployment, its replicas, and the pods created under it, you can use the following kubectl commands:

1. Get deployments:

bash
kubectl get deployments

This command displays the deployments in your cluster, including the nginx-deployment.

2. Get deployment details:

bash
kubectl describe deployment nginx-deployment

This command provides more detailed information about the nginx-deployment, including the number of replicas and the pods created.

3. Get pods:

bash
kubectl get pods

This command displays the pods in your cluster, including the pods created by the nginx-deployment.

4. Get pods with labels:

bash
kubectl get pods -l app=nginx

This command displays the pods with the label app=nginx, which should include the pods created by the nginx-deployment.

By running these commands, you can verify that the deployment was successful and that the replicas and pods are running as expected.


### To get the node IP for the command http://<node-ip>:30011, you'll need to find the IP address of one of your cluster nodes. Here are a few ways to do it:

Method 1: Using kubectl

You can use the kubectl get nodes command to get the IP addresses of your cluster nodes:

bash
kubectl get nodes -o wide

This command will display the nodes in your cluster along with their IP addresses.

Method 2: Using Node.js

If you want to get the local IP address programmatically, you can use Node.js with the os module:

const os = require('os');

const networkInterfaces = os.networkInterfaces();
const ip = networkInterfaces['eth0'][0].address;

console.log(ip);

Replace 'eth0' with the name of your network interface.

Method 3: Checking your cluster setup

If you're using a managed Kubernetes service like Google Kubernetes Engine (GKE) or Amazon Elastic Container Service for Kubernetes (EKS), you can find the node IP addresses in your cloud provider's console.

Once you have the node IP, you can access your service using http://<node-ip>:30011. Make sure to replace <node-ip> with the actual IP address of one of your cluster nodes ¹.


### To access the URL, you need to use a web browser or a tool like curl in the terminal.

Try using curl to test the URL:

bash
curl http://172.17.0.2:30011

This will send an HTTP request to the URL and display the response in the terminal.

If you want to access the URL in a web browser, simply copy and paste http://172.17.0.2:30011 into the address bar of your browser.

### To access the URL http://172.17.0.2:30011 in the terminal, you can use the curl command:

bash
curl http://172.17.0.2:30011

This will send an HTTP request to the URL and display the response in the terminal.

If you want to see more detailed information about the request and response, you can use the -v flag with curl:

bash
curl -v http://172.17.0.2:30011

This will display verbose output, including the request headers, response headers, and response body.

If the service is working correctly, you should see the HTML content of the Nginx welcome page or your static website in the terminal output.


### To check that the nginx-service is running and exposed on port 30011, you can use the following kubectl commands:

1. Get services:

bash
kubectl get svc

This command will display all services in your cluster, including the nginx-service. Check that the service is listed and that the PORT(S) column shows 80:30011/TCP.

2. Describe service:

bash
kubectl describe svc nginx-service

This command will provide more detailed information about the nginx-service, including the ports and endpoints. Check that the NodePort is set to 30011 and that there are endpoints listed.

3. Check service endpoints:

bash
kubectl get endpoints nginx-service

This command will display the endpoints for the nginx-service. Check that there are IP addresses listed, which indicates that the service is routing traffic to the pods.

4. Check pod status:

bash
kubectl get pods

This command will display the status of the pods running in your cluster. Check that the pods associated with the nginx-deployment are running and ready.

If everything looks good, your nginx-service should be running and exposed on port 30011. If you encounter any issues, you can use the kubectl logs command to check the logs of the pods and service for any errors.
