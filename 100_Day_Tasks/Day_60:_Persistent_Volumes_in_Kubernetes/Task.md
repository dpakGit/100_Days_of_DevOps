### Task : 

The Nautilus DevOps team is working on a Kubernetes template to deploy a web application on the cluster. There are some requirements to create/use persistent volumes to store the application code, and the template needs to be designed accordingly. Please find more details below:


Create a PersistentVolume named as pv-datacenter. Configure the spec as storage class should be manual, set capacity to 4Gi, set access mode to ReadWriteOnce, volume type should be hostPath and set path to /mnt/security (this directory is already created, you might not be able to access it directly, so you need not to worry about it).

Create a PersistentVolumeClaim named as pvc-datacenter. Configure the spec as storage class should be manual, request 1Gi of the storage, set access mode to ReadWriteOnce.

Create a pod named as pod-datacenter, mount the persistent volume you created with claim name pvc-datacenter at document root of the web server, the container within the pod should be named as container-datacenter using image httpd with latest tag only (remember to mention the tag i.e httpd:latest).

Create a node port type service named web-datacenter using node port 30008 to expose the web server running within the pod.


### Here's a breakdown of the task:

Task Overview

The task is to create a Kubernetes template to deploy a web application on a cluster. The template needs to use persistent volumes to store the application code.

Requirements

1. Create a PersistentVolume (PV)
    - Name: pv-datacenter
    - Storage class: manual
    - Capacity: 4Gi
    - Access mode: ReadWriteOnce
    - Volume type: hostPath
    - Path: /mnt/security
2. Create a PersistentVolumeClaim (PVC)
    - Name: pvc-datacenter
    - Storage class: manual
    - Requested storage: 1Gi
    - Access mode: ReadWriteOnce
3. Create a Pod
    - Name: pod-datacenter
    - Container name: container-datacenter
    - Image: httpd:latest
    - Mount the PVC pvc-datacenter at the document root of the web server
4. Create a Service
    - Name: web-datacenter
    - Type: NodePort
    - Node port: 30008
    - Expose the web server running within the pod

Objective

The objective is to create a Kubernetes deployment that uses a persistent volume to store application code and exposes a web server using a NodePort service.

To accomplish this task, you'll need to create YAML files for each of the required resources (PV, PVC, Pod, and Service) and apply them to the Kubernetes cluster.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ vi pv.yaml

thor@jumphost ~$ vi pvc.yaml

thor@jumphost ~$ vi pod.yaml

thor@jumphost ~$ vi service.yaml

thor@jumphost ~$ vi pod.yaml 

thor@jumphost ~$ ls
pod.yaml  pv.yaml  pvc.yaml  service.yaml

thor@jumphost ~$ kubectl apply -f pv.yaml 
persistentvolume/pv-datacenter created

thor@jumphost ~$ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc-datacenter created

thor@jumphost ~$ kubectl apply -f pod.yaml
pod/pod-datacenter created

thor@jumphost ~$ kubectl apply -f service.yaml 
service/web-datacenter created

thor@jumphost ~$ kubectl get pv
NAME            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                    STORAGECLASS   REASON   AGE
pv-datacenter   4Gi        RWO            Retain           Bound    default/pvc-datacenter   manual                  81s

thor@jumphost ~$ kubectl get pvc
NAME             STATUS   VOLUME          CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-datacenter   Bound    pv-datacenter   4Gi        RWO            manual         77s

thor@jumphost ~$ kubectl get svc
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes       ClusterIP   10.96.0.1      <none>        443/TCP        33m
web-datacenter   NodePort    10.96.23.140   <none>        80:30008/TCP   61s

thor@jumphost ~$ kubectl get pod
NAME             READY   STATUS    RESTARTS   AGE
pod-datacenter   1/1     Running   0          86s
```

```
thor@jumphost ~$ history
    1  pwd
    2  ls
    3  vi pv.yaml
    4  vi pvc.yaml
    5  vi pod.yaml
    6  vi service.yaml
    7  vi pod.yaml 
    8  ls
    9  kubectl apply -f pv.yaml 
   10  kubectl apply -f pvc.yaml 
   11  kubectl apply -f pod.yaml
   12  kubectl apply -f service.yaml 
   13  kubectl get pv
   14  kubectl get pvc
   15  kubectl get svc
   16  kubectl get pod
```

### # pv.yaml

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-datacenter
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/security
```

### # pvc.yaml 

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-datacenter
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
```

### # service.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: web-datacenter
spec:
  selector:
    app: pod-datacenter
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30008
  type: NodePort
```

### # pod.yaml

```
apiVersion: v1
kind: Pod
metadata:
  name: pod-datacenter
  labels:
    app: pod-datacenter
spec:
  containers:
  - name: container-datacenter
    image: httpd:latest
    volumeMounts:
    - name: datacenter-volume
      mountPath: /usr/local/apache2/htdocs/
  volumes:
  - name: datacenter-volume
    persistentVolumeClaim:
      claimName: pvc-datacenter
```
