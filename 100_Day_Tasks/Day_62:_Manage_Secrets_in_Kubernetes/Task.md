### Task : Day 62: Manage Secrets in Kubernetes

The Nautilus DevOps team is working to deploy some tools in Kubernetes cluster. Some of the tools are licence based so that licence information needs to be stored securely within Kubernetes cluster. Therefore, the team wants to utilize Kubernetes secrets to store those secrets. Below you can find more details about the requirements:

1. We already have a secret key file beta.txt under /opt location on jump host. Create a generic secret named beta, it should contain the password/license-number present in beta.txt file.

2. Also create a pod named secret-devops.

3. Configure pod's spec as container name should be secret-container-devops, image should be ubuntu with latest tag (remember to mention the tag with image). Use sleep command for container so that it remains in running state. Consume the created secret and mount it under /opt/apps within the container.

4. To verify you can exec into the container secret-container-devops, to check the secret key under the mounted path /opt/apps. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ ls /opt
beta.txt

thor@jumphost ~$ cat /opt/beta.txt 
5ecur3

thor@jumphost ~$ kubectl create secret generic beta --from-file=/opt/beta.txt
secret/beta created

thor@jumphost ~$ kubectl get secrets 
NAME   TYPE     DATA   AGE
beta   Opaque   1      21s

thor@jumphost ~$ kubectl get secret
NAME   TYPE     DATA   AGE
beta   Opaque   1      27s

thor@jumphost ~$ vi pod.yaml

thor@jumphost ~$ kubectl apply -f pod.yaml 
pod/secret-devops created

thor@jumphost ~$ kubectl get po
NAME            READY   STATUS    RESTARTS   AGE
secret-devops   1/1     Running   0          8s

thor@jumphost ~$ kubectl exec -it secret-devops -- cat /opt/apps/beta.txt 
5ecur3

# Following command is same as the above kubectl exec command

thor@jumphost ~$ kubectl exec -it secret-devops -c secret-container-devops -- cat /opt/apps/beta.txt
5ecur3
```


History
```
     1  pwd
    2  ls
    3  ls /opt
    4  cat /opt/beta.txt
    5  cat /opt/beta.txt 
    6  kubectl create secret generic beta --from-file=/opt/beta.txt
    7  kubectl get secrets 
    8  kubectl get secret
    9  vi pod.yaml
   10  kubectl apply -f pod.yaml 
   11  kubectl get po
   12  kubectl exec -it secret-devops -- cat /opt/apps/beta.txt
   13  # Following command is same as the above kubectl exec command
   14  kubectl exec -it secret-devops -c secret-container-devops -- cat /opt/apps/beta.txt
```


### # pod.yaml 

```
apiVersion: v1
kind: Pod
metadata:
  name: secret-devops
spec:
  containers:
  - name: secret-container-devops
    image: ubuntu:latest
    command: ["sleep", "3600"]
    volumeMounts:
    - name: beta-secret
      mountPath: /opt/apps
  volumes:
  - name: beta-secret
    secret:
      secretName: beta
```
