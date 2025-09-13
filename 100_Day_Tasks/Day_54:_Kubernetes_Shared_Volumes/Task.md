### Task: Day 54: Kubernetes Shared Volumes



### What I Did


Last login: Sat Sep 13 05:01:08 UTC 2025 on pts/2
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
root@volume-share-nautilus:/# ls /tmp/official/
official.txt
root@volume-share-nautilus:/# cat /tmp/official/official.txt 
Hello World!
root@volume-share-nautilus:/# # File created inside container-1  
root@volume-share-nautilus:/# exit
exit
thor@jumphost ~$ kubectl exec -it volume-share-nautilus -c volume-container-nautilus-2 -- /bin/bash
root@volume-share-nautilus:/# pwd
/
root@volume-share-nautilus:/# ls /tmp/games/
official.txt
root@volume-share-nautilus:/# cat  /tmp/games/official.txt 
Hello World!
root@volume-share-nautilus:/# # File official.txt ,and the text inside it, created inside container-1 is present inside container-2.
root@volume-share-nautilus:/# exit
exit
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
thor@jumphost ~$ cat volume-share-pod.yaml 
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

thor@jumphost ~$ 
