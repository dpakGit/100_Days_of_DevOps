### Task : Kubernetes Shared Volumes

We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.

Create a pod named volume-share-datacenter.

For the first container, use image ubuntu with latest tag only and remember to mention the tag i.e ubuntu:latest, container should be named as volume-container-datacenter-1, and run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/media.

For the second container, use image ubuntu with the latest tag only and remember to mention the tag i.e ubuntu:latest, container should be named as volume-container-datacenter-2, and again run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/demo.

Volume name should be volume-share of type emptyDir.

After creating the pod, exec into the first container i.e volume-container-datacenter-1, and just for testing create a file media.txt with any content under the mounted path of first container i.e /tmp/media.

The file media.txt should be present under the mounted path /tmp/demo on the second container volume-container-datacenter-2 as well, since they are using a shared volume.


### What I Did

### Here is the YAML configuration for the pod:

```
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-datacenter
spec:
  containers:
  - name: volume-container-datacenter-1
    image: ubuntu:latest
    command: ["sleep", "infinity"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/media
  - name: volume-container-datacenter-2
    image: ubuntu:latest
    command: ["sleep", "infinity"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/demo
  volumes:
  - name: volume-share
    emptyDir: {}
```

Let's create the pod:


bash
kubectl apply -f pod.yaml


After the pod is running, let's exec into the first container and create a file:


bash
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-1 -- /bin/bash
root@volume-share-datacenter:/# echo "Hello from container 1" > /tmp/media/media.txt
root@volume-share-datacenter:/# exit


Now, let's verify if the file is present in the second container:


bash
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-2 -- /bin/bash
root@volume-share-datacenter:/# cat /tmp/demo/media.txt
Hello from container 1


The file media.txt is present in both containers, and they are sharing the same volume.

Verification Steps:

1. Create the pod using kubectl apply -f pod.yaml
2. Exec into the first container using kubectl exec -it volume-share-datacenter -c volume-container-datacenter-1 -- /bin/bash
3. Create a file media.txt under /tmp/media with some content.
4. Exec into the second container using kubectl exec -it volume-share-datacenter -c volume-container-datacenter-2 -- /bin/bash
5. Verify if the file media.txt is present under /tmp/demo with the same content.

This demonstrates that the two containers are sharing the same volume volume-share of type emptyDir.

### You can use the following command to cat the file directly from outside the container:


bash
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-2 -- cat /tmp/demo/media.txt


This command will execute the cat command inside the container and display the output directly in your terminal.
