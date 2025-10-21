### Task : Deploy Highly Available Pods with ReplicationController

The Nautilus DevOps team is establishing a ReplicationController to deploy multiple pods for hosting applications that require a highly available infrastructure. Follow the specifications below to create the ReplicationController:


Create a ReplicationController using the httpd image with latest tag, and name it httpd-replicationcontroller.

Assign labels app as httpd_app, and type as front-end. Ensure the container is named httpd-container and set the replica count to 3.


All pods should be running state post-deployment.


### What I Did

### Here's the YAML file to create the ReplicationController:

```
apiVersion: v1
kind: ReplicationController
metadata:
  name: httpd-replicationcontroller
spec:
  replicas: 3
  selector:
    app: httpd_app
    type: front-end
  template:
    metadata:
      labels:
        app: httpd_app
        type: front-end
    spec:
      containers:
      - name: httpd-container
        image: httpd:latest
        ports:
        - containerPort: 80
```

Save this YAML file (e.g., httpd-rc.yaml) and apply it to your Kubernetes cluster using the following command:


bash
kubectl apply -f httpd-rc.yaml


After applying the YAML file, you can verify that the ReplicationController and pods are created successfully:


bash
kubectl get rc
kubectl get pods --selector=app=httpd_app,type=front-end


All pods should be in the running state. If any pod is not in the running state, you can use kubectl describe to troubleshoot:


bash
kubectl describe pod <pod-name>


Replace <pod-name> with the actual name of the pod.


### You can use the following command to get more information about the pods and see what's causing the issue:


bash
kubectl get pods --selector=app=httpd_app,type=front-end -o wide


This will show you the status of each pod, including any errors or issues.

You can also use kubectl describe to get more detailed information about the pod that's not ready:


bash
kubectl describe pod <pod-name>


Replace <pod-name> with the actual name of the pod that's not ready.

Additionally, you can check the logs of the container to see if there are any error messages:


bash
kubectl logs <pod-name> -c httpd-container


This will show you the logs for the httpd-container container in the specified pod.

By checking the logs and the pod's description, you should be able to determine why the pod is not in the READY state.
