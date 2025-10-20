### Task : Deploy ReplicaSet in Kubernetes Cluster

The Nautilus DevOps team is gearing up to deploy applications on a Kubernetes cluster for migration purposes. A team member has been tasked with creating a ReplicaSet outlined below:



1. Create a ReplicaSet using httpd image with latest tag (ensure to specify as httpd:latest) and name it httpd-replicaset.


2. Apply labels: app as httpd_app, type as front-end.


3. Name the container httpd-container. Ensure the replica count is 4.


Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.

### What I Did

Here's a YAML file that defines the ReplicaSet as per the requirements:

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
  labels:
    app: nginx_app
    type: front-end
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx_app
      type: front-end
  template:
    metadata:
      labels:
        app: nginx_app
        type: front-end
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
```

You can save this YAML file (e.g., nginx-replicaset.yaml) and apply it to your Kubernetes cluster using the following command:


bash

kubectl apply -f nginx-replicaset.yaml


This will create the ReplicaSet with the specified configuration. You can verify the ReplicaSet and its pods using the following commands:


bash

kubectl get rs

kubectl get pods


The kubectl get rs command will show you the ReplicaSet, and the kubectl get pods command will show you the pods created by the ReplicaSet. You should see 4 pods running with names starting with nginx-replicaset.
