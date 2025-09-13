### Task: Day 54: Kubernetes Shared Volumes

We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team is developing a similar template to replicate the scenario. Below you can find more details about it.

Create a pod named volume-share-nautilus.

For the first container, use image debian with latest tag only and remember to mention the tag i.e debian:latest, container should be named as volume-container-nautilus-1, and run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/official.

For the second container, use image debian with the latest tag only and remember to mention the tag i.e debian:latest, container should be named as volume-container-nautilus-2, and again run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/games.

Volume name should be volume-share of type emptyDir.


After creating the pod, exec into the first container i.e volume-container-nautilus-1, and just for testing create a file official.txt with any content under the mounted path of first container i.e /tmp/official.


The file official.txt should be present under the mounted path /tmp/games on the second container volume-container-nautilus-2 as well, since they are using a shared volume.



### What I Did
```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   38m

thor@jumphost ~$ vi volume-share-pod.yaml

thor@jumphost ~$ ls
volume-share-pod.yaml

thor@jumphost ~$ kubectl apply -f volume-share-pod.yaml 
pod/volume-share-nautilus created

thor@jumphost ~$ kubectl get pod volume-share-nautilus 
NAME                    READY   STATUS    RESTARTS   AGE
volume-share-nautilus   2/2     Running   0          35s

thor@jumphost ~$ kubectl exec -it volume-share-nautilus -c volume-container-nautilus-1 -- /bin/bash

root@volume-share-nautilus:/# echo "Hello World!" > /tmp/official/official.txt

# Verify that the file is created with the text

root@volume-share-nautilus:/# ls /tmp/official/
official.txt

root@volume-share-nautilus:/# cat /tmp/official/official.txt 
Hello World!

# File created inside container-1  
root@volume-share-nautilus:/# exit
exit

# Verify the file is shared with the second container

thor@jumphost ~$ kubectl exec -it volume-share-nautilus -c volume-container-nautilus-2 -- /bin/bash
root@volume-share-nautilus:/# pwd
/

root@volume-share-nautilus:/# ls /tmp/games/
official.txt

root@volume-share-nautilus:/# cat  /tmp/games/official.txt 
Hello World!

# File official.txt ,and the text inside it, created inside container-1 is present inside container-2.

root@volume-share-nautilus:/# exit
exit
```

### # volume-share-pod.yaml 
```
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-nautilus
spec:
  containers:
  - name: volume-container-nautilus-1
    image: debian:latest
    command: ["sleep", "1000"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/official
  - name: volume-container-nautilus-2
    image: debian:latest
    command: ["sleep", "1000"]
    volumeMounts:
    - name: volume-share
      mountPath: /tmp/games
  volumes:
  - name: volume-share
    emptyDir: {}
```

```
thor@jumphost ~$ history | cut -c 8-
pwd
ls
kubectl get all
vi volume-share-pod.yaml
ls
kubectl apply -f volume-share-pod.yaml 
kubectl get pod volume-share-nautilus 
kubectl exec -it volume-share-nautilus -c volume-container-nautilus-1 -- /bin/bash
kubectl exec -it volume-share-nautilus -c volume-container-nautilus-2 -- /bin/bash
history | cut -c 8-
thor@jumphost ~$ ls
volume-share-pod.yaml
```
