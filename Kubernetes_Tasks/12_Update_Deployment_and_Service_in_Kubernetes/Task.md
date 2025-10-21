### Task : Update Deployment and Service in Kubernetes

An application deployed on the Kubernetes cluster requires an update with new features developed by the Nautilus application development team. The existing setup includes a deployment named nginx-deployment and a service named nginx-service. Below are the necessary changes to be implemented without deleting the deployment and service:


1.) Modify the service nodeport from 30008 to 32165

2.) Change the replicas count from 1 to 5

3.) Update the image from nginx:1.18 to nginx:latest

### What I Did

### You can achieve these changes without deleting the deployment and service by using the kubectl patch command or by editing the existing deployment and service configurations. Here are the steps for both methods:

### Method 1: Using kubectl patch


bash
#### Update the service NodePort
kubectl patch svc nginx-service -p '{"spec":{"ports":[{"nodePort":32165,"port":80,"protocol":"TCP","targetPort":80}]}}'

#### Update the deployment replicas count
kubectl scale deployment nginx-deployment --replicas=5

#### Update the deployment image
kubectl set image deployment/nginx-deployment nginx-container=nginx:latest

This command will update the image for the nginx-container in the nginx-deployment deployment to nginx:latest.


### Method 2: Editing the existing configurations

You can also edit the existing configurations using kubectl edit:


bash
#### Edit the service
kubectl edit svc nginx-service


Update the nodePort value to 32165 in the editor.


bash
#### Edit the deployment
kubectl edit deployment nginx-deployment


Update the replicas count to 5 and the image value to nginx:latest in the editor.

After applying these changes, verify that the deployment and service have been updated correctly:


bash
kubectl get deployment nginx-deployment -o wide

OR

kubectl get deployment nginx-deployment -o yaml


kubectl get svc nginx-service -o wide

The command kubectl get svc nginx-service -o wide will display detailed information about the nginx-service service, including the IP address, ports, and node ports.


You should see the updated nodePort, replicas count, and image version.


### The error message indicates that the container name "nginx" is not found in the deployment. You need to specify the correct container name.

To find the container name, you can use:


bash
kubectl describe deployment nginx-deployment






Look for the container name in the output. Let's assume the container name is also "nginx-deployment" or you can specify the container name in the command.

If the container name is the same as the deployment name, you can try:


bash
kubectl set image deployment/nginx-deployment nginx-deployment=nginx:latest


If you're still unsure about the container name, you can try using the following command to update the image for all containers in the deployment:


bash
kubectl set image deployment/nginx-deployment *= 5
kubectl set image deployment/nginx-deployment *=nginx:latest


The * wildcard will update the image for all containers in the deployment.

After running the command, verify that the deployment has been updated:


bash
kubectl get deployment nginx-deployment -o yaml


### 
