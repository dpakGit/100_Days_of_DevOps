### Task.md : Day 66: Deploy MySQL on Kubernetes

A new MySQL server needs to be deployed on Kubernetes cluster. The Nautilus DevOps team was working on to gather the requirements. Recently they were able to finalize the requirements and shared them with the team members to start working on it. Below you can find the details:

1.) Create a PersistentVolume mysql-pv, its capacity should be 250Mi, set other parameters as per your preference.

2.) Create a PersistentVolumeClaim to request this PersistentVolume storage. Name it as mysql-pv-claim and request a 250Mi of storage. Set other parameters as per your preference.

3.) Create a deployment named mysql-deployment, use any mysql image as per your preference. Mount the PersistentVolume at mount path /var/lib/mysql.

4.) Create a NodePort type service named mysql and set nodePort to 30007.

5.) Create a secret named mysql-root-pass having a key pair value, where key is password and its value is YUIidhb667, create another secret named mysql-user-pass having some key pair values, where frist key is username and its value is kodekloud_rin, second key is password and value is B4zNgHA7Ya, create one more secret named mysql-db-url, key name is database and value is kodekloud_db6

6.) Define some Environment variables within the container:

a) name: MYSQL_ROOT_PASSWORD, should pick value from secretKeyRef name: mysql-root-pass and key: password

b) name: MYSQL_DATABASE, should pick value from secretKeyRef name: mysql-db-url and key: database

c) name: MYSQL_USER, should pick value from secretKeyRef name: mysql-user-pass key key: username

d) name: MYSQL_PASSWORD, should pick value from secretKeyRef name: mysql-user-pass and key: password


### What I Did

```
thor@jumphost ~$ ls 

thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ vi mysql-deployment.yaml

thor@jumphost ~$ kubectl apply -f mysql-deployment.yaml 
persistentvolume/mysql-pv created
persistentvolumeclaim/mysql-pv-claim created
secret/mysql-root-pass created
secret/mysql-user-pass created
secret/mysql-db-url created
deployment.apps/mysql-deployment created
service/mysql created

thor@jumphost ~$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   
STORAGECLASS   REASON   AGE
mysql-pv                                   250Mi      RWO            Retain           Available                                                    14s
pvc-7f2be01c-a2ab-4224-a945-21ad228bfb9e   250Mi      RWO            Delete           Bound       default/mysql-pv-claim   standard                9s

thor@jumphost ~$ kubectl get pvc
NAME             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pv-claim   Bound    pvc-7f2be01c-a2ab-4224-a945-21ad228bfb9e   250Mi      RWO            standard       23s

thor@jumphost ~$ kubectl get secrets 
NAME              TYPE     DATA   AGE
mysql-db-url      Opaque   1      39s
mysql-root-pass   Opaque   1      39s
mysql-user-pass   Opaque   2      39s

thor@jumphost ~$ kubectl get deployments.apps 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
mysql-deployment   1/1     1            1           67s

thor@jumphost ~$ kubectl get svc
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP          21m
mysql        NodePort    10.96.62.20   <none>        3306:30007/TCP   79s

thor@jumphost ~$ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/mysql-deployment-6b76944657-gftjl   1/1     Running   0          95s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP          21m
service/mysql        NodePort    10.96.62.20   <none>        3306:30007/TCP   95s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-deployment   1/1     1            1           95s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-deployment-6b76944657   1         1         1       95s

thor@jumphost ~$ kubectl get secrets -o wide
NAME              TYPE     DATA   AGE
mysql-db-url      Opaque   1      2m14s
mysql-root-pass   Opaque   1      2m14s
mysql-user-pass   Opaque   2      2m14s

thor@jumphost ~$ kubectl describe secrets
Name:         mysql-db-url
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
database:  13 bytes


Name:         mysql-root-pass
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
password:  10 bytes


Name:         mysql-user-pass
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
username:  13 bytes
password:  10 bytes
```


history | cut -c 8-
```
ls 
pwd
vi mysql-deployment.yaml
kubectl apply -f mysql-deployment.yaml 
kubectl get pv
kubectl get pvc
kubectl get secrets 
kubectl get deployments.apps 
kubectl get svc
kubectl get all
kubectl get secrets -o wide
kubectl describe secrets
historykubectl get secret  -o jsonpath='{.data}' | base64 --decode
historykubectl get secret mysql-db-url  -o jsonpath='{.data}' | base64 --decode
kubectl get secret mysql-db-url  -o jsonpath='{.data}' | base64 --decode
history | cut -c 8-
thor@jumphost ~$ ls
mysql-deployment.yaml
```
### # mysql-deployment.yaml 

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 250Mi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data"

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi

---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-root-pass
type: Opaque
data:
  # The value YUIidhb667 encoded in base64.
  password: WVVLdWRoYjY2Nw==

---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-user-pass
type: Opaque
data:
  # The value kodekloud_rin encoded in base64.
  username: a29kZWtsb3VkX3Jpbg==
  # The value B4zNgHA7Ya encoded in base64.
  password: QjR6TmdIQTdZYQ==

---
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-url
type: Opaque
data:
  # The value kodekloud_db6 encoded in base64.
  database: a29kZWtsb3VkX2RiNg==

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0 # Using a specific version for stability.
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-root-pass
              key: password
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: mysql-db-url
              key: database
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: mysql-user-pass
              key: username
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-user-pass
              key: password
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-persistent-storage
        persistentVolumeClaim:
          claimName: mysql-pv-claim

---
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  selector:
    app: mysql
  ports:
  - name: mysql
    port: 3306
    targetPort: 3306
    nodePort: 30007
  type: NodePort
```


This file combines the PersistentVolume, PersistentVolumeClaim, all three Secret objects, the Deployment, and the Service into a single manifest, which you can apply with just one command: kubectl apply -f mysql-deployment.yaml.

In the multi-document YAML file. Each Kubernetes object (like the PersistentVolume, PersistentVolumeClaim, Secrets, Deployment, and Service) is separated by the --- separator.

This is a common and efficient practice in Kubernetes because it allows you to create all the necessary resources for an application with a single kubectl apply -f <filename> command, instead of applying multiple separate files.

The only changes I've made are correcting the base64-encoded values to match the required secret data. I also replaced the local volume type with hostPath for simplicity, as local volumes often require a node name, and this makes the file more universally usable.(It is refering to another yaml file provided by me).

