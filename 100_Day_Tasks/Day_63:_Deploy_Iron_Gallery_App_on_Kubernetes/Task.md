### Task :

There is an iron gallery app that the Nautilus DevOps team was developing. They have recently customized the app and are going to deploy the same on the Kubernetes cluster. Below you can find more details:

1. Create a namespace iron-namespace-devops

2. Create a deployment iron-gallery-deployment-devops for iron gallery under the same namespace you created.

:- Labels run should be iron-gallery.

:- Replicas count should be 1.

:- Selector's matchLabels run should be iron-gallery.

:- Template labels run should be iron-gallery under metadata.

:- The container should be named as iron-gallery-container-devops, use kodekloud/irongallery:2.0 image ( use exact image name / tag ).

:- Resources limits for memory should be 100Mi and for CPU should be 50m.

:- First volumeMount name should be config, its mountPath should be /usr/share/nginx/html/data.

:- Second volumeMount name should be images, its mountPath should be /usr/share/nginx/html/uploads.

:- First volume name should be config and give it emptyDir and second volume name should be images, also give it emptyDir.

3. Create a deployment iron-db-deployment-devops for iron db under the same namespace.

:- Labels db should be mariadb.

:- Replicas count should be 1.

:- Selector's matchLabels db should be mariadb.

:- Template labels db should be mariadb under metadata.

:- The container name should be iron-db-container-devops, use kodekloud/irondb:2.0 image ( use exact image name / tag ).

:- Define environment, set MYSQL_DATABASE its value should be database_apache, set MYSQL_ROOT_PASSWORD and MYSQL_PASSWORD value should be with some complex passwords for DB connections, and MYSQL_USER value should be any custom user ( except root ).

:- Volume mount name should be db and its mountPath should be /var/lib/mysql. Volume name should be db and give it an emptyDir.

4. Create a service for iron db which should be named iron-db-service-devops under the same namespace. Configure spec as selector's db should be mariadb. Protocol should be TCP, port and targetPort should be 3306 and its type should be ClusterIP.

5. **Create a service for iron gallery which should be named iron-gallery-service-devops under the same namespace. Configure spec as selector's run should be iron-gallery. Protocol should be TCP, port and targetPort should be 80, nodePort should be 32678 and its type should be NodePort.



### What I Did


thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
thor@jumphost ~$ kubectl create ns iron-namespace-devops
namespace/iron-namespace-devops created
thor@jumphost ~$ kuvectl get ns
bash: kuvectl: command not found
thor@jumphost ~$ kubectl get ns
NAME                    STATUS   AGE
default                 Active   12m
iron-namespace-devops   Active   17s
kube-node-lease         Active   12m
kube-public             Active   12m
kube-system             Active   12m
local-path-storage      Active   12m
thor@jumphost ~$ vi iron-gallery-deployment.yaml
thor@jumphost ~$ vi iron-db-deployment.yaml
thor@jumphost ~$ kubectl apply -f iron-gallery-deployment.yaml 
deployment.apps/iron-gallery-deployment-devops created
thor@jumphost ~$ kubectl apply -f iron-db-deployment.yaml 
deployment.apps/iron-db-deployment-devops created
thor@jumphost ~$ kubectl get deployments.apps 
No resources found in default namespace.
thor@jumphost ~$ kubectl get deployments.apps -n iron-namespace-devops 
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
iron-db-deployment-devops        1/1     1            1           31s
iron-gallery-deployment-devops   1/1     1            1           45s
thor@jumphost ~$ kubectl get all deployments.apps -n iron-namespace-devops 
error: you must specify only one resource
thor@jumphost ~$ kubectl get all  -n iron-namespace-devops NAME                                                 READY   STATUS    RESTARTS   AGE
pod/iron-db-deployment-devops-66f694bd4d-5jcbk       1/1     Running   0          77s
pod/iron-gallery-deployment-devops-9c67c8cb7-sp52r   1/1     Running   0          91s

NAME                                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/iron-db-deployment-devops        1/1     1            1           77s
deployment.apps/iron-gallery-deployment-devops   1/1     1            1           91s

NAME                                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/iron-db-deployment-devops-66f694bd4d       1         1         1       77s
replicaset.apps/iron-gallery-deployment-devops-9c67c8cb7   1         1         1       91s
thor@jumphost ~$ kubectl get po -n iron-namespace-devops 
NAME                                             READY   STATUS    RESTARTS   AGE
iron-db-deployment-devops-66f694bd4d-5jcbk       1/1     Running   0          94s
iron-gallery-deployment-devops-9c67c8cb7-sp52r   1/1     Running   0          108s
thor@jumphost ~$ # Note : since the objects are created in a specific namespace to find the use namespace name with the command
thor@jumphost ~$ vi iron-db-service.yaml
thor@jumphost ~$ vi iron-gallery-service.yam
thor@jumphost ~$ kubectl apply -f iron-db-service.yaml
kubectl apply -f iron-gallery-service.yaml
service/iron-db-service-devops created
error: the path "iron-gallery-service.yaml" does not exist
thor@jumphost ~$ ls
iron-db-deployment.yaml  iron-gallery-deployment.yaml
iron-db-service.yaml     iron-gallery-service.yam
thor@jumphost ~$ mv iron-gallery-service.yam iron-gallery-service.yaml
thor@jumphost ~$ ls
iron-db-deployment.yaml  iron-gallery-deployment.yaml
iron-db-service.yaml     iron-gallery-service.yaml
thor@jumphost ~$ kubectl apply -f iron-gallery-service.yaml
service/iron-gallery-service-devops created
thor@jumphost ~$ kubectl get svc -n iron-namespace-devops 
NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
iron-db-service-devops        ClusterIP   10.96.15.187    <none>        3306/TCP       2m14s
iron-gallery-service-devops   NodePort    10.96.163.202   <none>        80:32678/TCP   26s
thor@jumphost ~$ kubectl get namespace
kubectl get deployments -n iron-namespace-devops
kubectl get pods -n iron-namespace-devops
kubectl get svc -n iron-namespace-devops
NAME                    STATUS   AGE
default                 Active   25m
iron-namespace-devops   Active   12m
kube-node-lease         Active   25m
kube-public             Active   25m
kube-system             Active   25m
local-path-storage      Active   25m
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
iron-db-deployment-devops        1/1     1            1           7m18s
iron-gallery-deployment-devops   1/1     1            1           7m32s
NAME                                             READY   STATUS    RESTARTS   AGE
iron-db-deployment-devops-66f694bd4d-5jcbk       1/1     Running   0          7m18s
iron-gallery-deployment-devops-9c67c8cb7-sp52r   1/1     Running   0          7m32s
NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
iron-db-service-devops        ClusterIP   10.96.15.187    <none>        3306/TCP       3m13s
iron-gallery-service-devops   NodePort    10.96.163.202   <none>        80:32678/TCP   85s
thor@jumphost ~$ ls
iron-db-deployment.yaml  iron-gallery-deployment.yaml
iron-db-service.yaml     iron-gallery-service.yaml
thor@jumphost ~$ history | cut -c 8-
pwd
ls
kubectl create ns iron-namespace-devops
kuvectl get ns
kubectl get ns
vi iron-gallery-deployment.yaml
vi iron-db-deployment.yaml
kubectl apply -f iron-gallery-deployment.yaml 
kubectl apply -f iron-db-deployment.yaml 
kubectl get deployments.apps 
kubectl get deployments.apps -n iron-namespace-devops 
kubectl get all deployments.apps -n iron-namespace-devops 
kubectl get all  -n iron-namespace-devops 
kubectl get po -n iron-namespace-devops 
# Note : since the objects are created in a specific namespace to find the use namespace name with the command
vi iron-db-service.yaml
vi iron-gallery-service.yam
kubectl apply -f iron-db-service.yaml
kubectl apply -f iron-gallery-service.yaml
ls
mv iron-gallery-service.yam iron-gallery-service.yaml
ls
kubectl apply -f iron-gallery-service.yaml
kubectl get svc -n iron-namespace-devops 
kubectl get namespace
kubectl get deployments -n iron-namespace-devops
kubectl get pods -n iron-namespace-devops
kubectl get svc -n iron-namespace-devops
ls
history | cut -c 8-
thor@jumphost ~$ ls
iron-db-deployment.yaml  iron-gallery-deployment.yaml
iron-db-service.yaml     iron-gallery-service.yaml
thor@jumphost ~$ cat iron-gallery-deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-gallery-deployment-devops
  namespace: iron-namespace-devops
spec:
  replicas: 1
  selector:
    matchLabels:
      run: iron-gallery
  template:
    metadata:
      labels:
        run: iron-gallery
    spec:
      containers:
      - name: iron-gallery-container-devops
        image: kodekloud/irongallery:2.0
        resources:
          limits:
            cpu: 50m
            memory: 100Mi
        volumeMounts:
        - name: config
          mountPath: /usr/share/nginx/html/data
        - name: images
          mountPath: /usr/share/nginx/html/uploads
      volumes:
      - name: config
        emptyDir: {}
      - name: images
        emptyDir: {}

thor@jumphost ~$ cat iron-db-deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-db-deployment-devops
  namespace: iron-namespace-devops
spec:
  replicas: 1
  selector:
    matchLabels:
      db: mariadb
  template:
    metadata:
      labels:
        db: mariadb
    spec:
      containers:
      - name: iron-db-container-devops
        image: kodekloud/irondb:2.0
        env:
        - name: MYSQL_DATABASE
          value: database_apache
        - name: MYSQL_ROOT_PASSWORD
          value: "admin"
        - name: MYSQL_PASSWORD
          value: "admin"
        - name: MYSQL_USER
          value: "admin"
        volumeMounts:
        - name: db
          mountPath: /var/lib/mysql
      volumes:
      - name: db
        emptyDir: {}

thor@jumphost ~$ ls
iron-db-deployment.yaml  iron-gallery-deployment.yaml
iron-db-service.yaml     iron-gallery-service.yaml
thor@jumphost ~$  cat iron-gallery-service.yaml 
apiVersion: v1
kind: Service
metadata:
  name: iron-gallery-service-devops
  namespace: iron-namespace-devops
spec:
  selector:
    run: iron-gallery
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 32678
  type: NodePort

thor@jumphost ~$  cat iron-db-service.yaml 
apiVersion: v1
kind: Service
metadata:
  name: iron-db-service-devops
  namespace: iron-namespace-devops
spec:
  selector:
    db: mariadb
  ports:
  - protocol: TCP
    port: 3306
    targetPort: 3306
  type: ClusterIP

thor@jumphost ~$ 
