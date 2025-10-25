### Task : 

One of the DevOps team member was trying to install a WordPress website on a LAMP stack which is essentially deployed on Kubernetes cluster. It was working well and we could see the installation page a few hours ago. However something is messed up with the stack now due to a website went down. Please look into the issue and fix it:

FYI, deployment name is lamp-wp and its using a service named lamp-service. The Apache is using http default port and nodeport is 30008. From the application logs it has been identified that application is facing some issues while connecting to the database in addition to other issues. Additionally, there are some environment variables associated with the pods like MYSQL_ROOT_PASSWORD, MYSQL_DATABASE,  MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST.


Also do not try to delete/modify any other existing components like deployment name, service name, types, labels etc.

### What I Did
```
thor@jumphost ~$ kubectl get deployments.apps 
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
lamp-wp   1/1     1            1           57s

thor@jumphost ~$ kubectl get svc
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        22m
lamp-service    NodePort    10.96.122.177   <none>        80:30009/TCP   72s
mysql-service   ClusterIP   10.96.134.183   <none>        3306/TCP       72s

# ERROR IDENTIFIED : NodePort service - lamp-service not running on port 30008 instead running on 30009

thor@jumphost ~$ kubectl get svc lamp-service -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"app":"lamp"},"name":"lamp-service","namespace":"default"},"spec":{"ports":[{"nodePort":30009,"port":80}],"selector":{"app":"lamp","tier":"frontend"},"type":"NodePort"}}
  creationTimestamp: "2025-10-25T03:13:33Z"
  labels:
    app: lamp
  name: lamp-service
  namespace: default
  resourceVersion: "2099"
  uid: 005caa59-fbae-427a-bbef-571aa395838c
spec:
  clusterIP: 10.96.122.177
  clusterIPs:
  - 10.96.122.177
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 30009
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: lamp
    tier: frontend
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}

# Edit the NodePort service and change port to 30008

thor@jumphost ~$ kubectl edit svc lamp-service -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"app":"lamp"},"name":"lamp-service","namespace":"default"},"spec":{"ports":[{"nodePort":30008,"port":80}],"selector":{"app":"lamp","tier":"frontend"},"type":"NodePort"}}
  creationTimestamp: "2025-10-25T03:13:33Z"
  labels:
    app: lamp
  name: lamp-service
  namespace: default
  resourceVersion: "2460"
  uid: 005caa59-fbae-427a-bbef-571aa395838c
spec:
  clusterIP: 10.96.122.177
  clusterIPs:
  - 10.96.122.177
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 30008
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: lamp
    tier: frontend
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}

# Verify the same

thor@jumphost ~$ kubectl get svc lamp-service 
NAME           TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
lamp-service   NodePort   10.96.122.177   <none>        80:30008/TCP   4m49s

thor@jumphost ~$ kubectl get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/lamp-wp-56c7c454fc-4vg4r   2/2     Running   0          5m37s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        26m
service/lamp-service    NodePort    10.96.122.177   <none>        80:30008/TCP   5m37s
service/mysql-service   ClusterIP   10.96.134.183   <none>        3306/TCP       5m37s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/lamp-wp   1/1     1            1           5m37s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/lamp-wp-56c7c454fc   1         1         1       5m37s

thor@jumphost ~$ kubectl describe deploy lamp-wp 
Name:               lamp-wp
Namespace:          default
CreationTimestamp:  Sat, 25 Oct 2025 03:13:33 +0000
Labels:             app=lamp
Annotations:        deployment.kubernetes.io/revision: 1
Selector:           app=lamp,tier=frontend
Replicas:           1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:       Recreate
MinReadySeconds:    0
Pod Template:
  Labels:  app=lamp
           tier=frontend
  Containers:
   httpd-php-container:
    Image:      webdevops/php-apache:alpine-3-php7
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:
      MYSQL_ROOT_PASSWORD:  <set to the key 'password' in secret 'mysql-root-pass'>  Optional: false
      MYSQL_DATABASE:       <set to the key 'database' in secret 'mysql-db-url'>     Optional: false
      MYSQL_USER:           <set to the key 'username' in secret 'mysql-user-pass'>  Optional: false
      MYSQL_PASSWORD:       <set to the key 'password' in secret 'mysql-user-pass'>  Optional: false
      MYSQL_HOST:           <set to the key 'host' in secret 'mysql-host'>           Optional: false
    Mounts:
      /opt/docker/etc/php/php.ini from php-config-volume (rw,path="php.ini") 
      mysql-container:
    Image:      mysql:5.6
    Port:       3306/TCP
    Host Port:  0/TCP
    Environment:
      MYSQL_ROOT_PASSWORD:  <set to the key 'password' in secret 'mysql-root-pass'>  Optional: false
      MYSQL_DATABASE:       <set to the key 'database' in secret 'mysql-db-url'>     Optional: false
      MYSQL_USER:           <set to the key 'username' in secret 'mysql-user-pass'>  Optional: false
      MYSQL_PASSWORD:       <set to the key 'password' in secret 'mysql-user-pass'>  Optional: false
      MYSQL_HOST:           <set to the key 'host' in secret 'mysql-host'>           Optional: false
    Mounts:                 <none>
  Volumes:
   php-config-volume:
    Type:          ConfigMap (a volume populated by a ConfigMap)
    Name:          php-config
    Optional:      false
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   lamp-wp-56c7c454fc (1/1 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  6m50s  deployment-controller  Scaled up replica set lamp-wp-56c7c454fc to 1

thor@jumphost ~$ kubectl get cm
NAME               DATA   AGE
kube-root-ca.crt   1      29m
php-config         1      8m56s

thor@jumphost ~$ kubectl describe cm php-config 
Name:         php-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
php.ini:
----
variables_order = "EGPCS"


BinaryData
====

Events:  <none>

thor@jumphost ~$ kubectl exec -it lamp-wp-56c7c454fc-4vg4r -c httpd-php-container -- sh
/ # ls
app             docker.stdout   etc             media           root            sys
bin             entrypoint      home            mnt             run             tmp
dev             entrypoint.cmd  lib             opt             sbin            usr
docker.stderr   entrypoint.d    log             proc            srv             var

/ # cd app/

/app # ls
index.php

/app # cat index.php 
<?php
$dbname = $_ENV['MYSQL_DATABASE'];
$dbuser = $_ENV['MYSQL_USER'];
$dbpass = $_ENV[''MYSQL_PASSWORD""];
$dbhost = $_ENV['MYSQL-HOST'];


$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

if ($result->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
/app # vi index.php 

/app # exit

thor@jumphost ~$ kubectl exec -it lamp-wp-56c7c454fc-4vg4r -c httpd-php-container -- sh
/ # cd app/
/app # ls
index.php
/app # cat index.php # Correct index.php
<?php
$dbname = $_ENV['MYSQL_DATABASE'];
$dbuser = $_ENV['MYSQL_USER'];
$dbpass = $_ENV['MYSQL_PASSWORD'];
$dbhost = $_ENV['MYSQL_HOST'];

$connect = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname) or die("Unable to Connect to '$dbhost'");

if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

echo "Connected successfully";
?>

;/app # exit
thor@jumphost ~$ 
```

<img width="1920" height="1080" alt="Screenshot (484)" src="https://github.com/user-attachments/assets/94616958-7134-4f7a-80ea-61644cd059d9" />
