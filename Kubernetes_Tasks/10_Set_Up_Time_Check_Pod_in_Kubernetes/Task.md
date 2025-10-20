### Task : Set Up Time Check Pod in Kubernetes

The Nautilus DevOps team needs a time check pod created in a specific Kubernetes namespace for logging purposes. Initially, it's for testing, but it may be integrated into an existing cluster later. Here's what's required:

Create a pod called time-check in the devops namespace. The pod should contain a container named time-check, utilizing the busybox image with the latest tag (specify as busybox:latest).

Create a config map named time-config with the data TIME_FREQ=7 in the same namespace.

Configure the time-check container to execute the command: while true; do date; sleep $TIME_FREQ;done. Ensure the result is written /opt/finance/time/time-check.log. Also, add an environmental variable TIME_FREQ in the container, fetching its value from the config map TIME_FREQ key.

Create a volume log-volume and mount it at /opt/finance/time within the container.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


### What I Did

### Here's a step-by-step solution to create the pod, config map, and other resources as per the requirements:
```
Step 1: Create the config map


apiVersion: v1
kind: ConfigMap
metadata:
  name: time-config
  namespace: devops
data:
  TIME_FREQ: "7"


Save this YAML file (e.g., time-config.yaml) and apply it to your Kubernetes cluster using the following command:


bash
kubectl apply -f time-config.yaml


Step 2: Create the pod


apiVersion: v1
kind: Pod
metadata:
  name: time-check
  namespace: devops
spec:
  containers:
  - name: time-check
    image: busybox:latest
    command: ["/bin/sh", "-c"]
    args:
    - while true; do date; sleep $TIME_FREQ; done > /opt/finance/time/time-check.log
    env:
    - name: TIME_FREQ
      valueFrom:
        configMapKeyRef:
          name: time-config
          key: TIME_FREQ
    volumeMounts:
    - name: log-volume
      mountPath: /opt/finance/time
  volumes:
  - name: log-volume
    emptyDir: {}


Save this YAML file (e.g., time-check-pod.yaml) and apply it to your Kubernetes cluster using the following command:


bash
kubectl apply -f time-check-pod.yaml


This will create the pod, config map, and other resources as per the requirements. You can verify the pod and its logs using the following commands:


bash
kubectl get pods -n devops
kubectl logs time-check -n devops


You can also check the contents of the log file:


bash
kubectl exec -it time-check -n devops -- cat /opt/finance/time/time-check.log


Note that the emptyDir volume will be deleted when the pod is deleted. If you want to persist the logs even after the pod is deleted, you can use a persistentVolumeClaim instead.
```
### The error message indicates that the devops namespace doesn't exist in your Kubernetes cluster. You can create the namespace using the following command:


bash
kubectl create namespace devops


After creating the namespace, you can apply the YAML files again:


bash

kubectl apply -f time-config.yaml

kubectl apply -f time-check-pod.yaml


This should resolve the issue. If you want to create all resources in a single YAML file, you can combine the two YAML files into one:

```
apiVersion: v1
kind: Namespace
metadata:
  name: devops

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: time-config
  namespace: devops
data:
  TIME_FREQ: "7"

---
apiVersion: v1
kind: Pod
metadata:
  name: time-check
  namespace: devops
spec:
  containers:
  - name: time-check
    image: busybox:latest
    command: ["/bin/sh", "-c"]
    args:
    - while true; do date; sleep $TIME_FREQ; done > /opt/finance/time/time-check.log
    env:
    - name: TIME_FREQ
      valueFrom:
        configMapKeyRef:
          name: time-config
          key: TIME_FREQ
    volumeMounts:
    - name: log-volume
      mountPath: /opt/finance/time
  volumes:
  - name: log-volume
    emptyDir: {}
```

Save this YAML file (e.g., all-resources.yaml) and apply it:


bash

kubectl apply -f all-resources.yaml
