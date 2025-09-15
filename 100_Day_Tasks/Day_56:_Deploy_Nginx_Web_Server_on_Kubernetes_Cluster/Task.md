### Task Day 56: Deploy Nginx Web Server on Kubernetes Cluster + Nodeport service



### What I Did

```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls 

thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   14m

thor@jumphost ~$ vi nginx-deployment.yaml

thor@jumphost ~$ vi nginx-service.yaml

thor@jumphost ~$ kubectl apply -f nginx-deployment.yaml 
deployment.apps/nginx-deployment created

thor@jumphost ~$ kubectl apply -f nginx-service.yaml 
service/nginx-service created

thor@jumphost ~$ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-5b58668cfc-9hnxj   1/1     Running   0          24s
pod/nginx-deployment-5b58668cfc-b7skc   1/1     Running   0          24s
pod/nginx-deployment-5b58668cfc-nbf2n   1/1     Running   0          24s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        18m
service/nginx-service   NodePort    10.96.83.161   <none>        80:30011/TCP   13s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           24s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-5b58668cfc   3         3         3       24s

thor@jumphost ~$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           61s

thor@jumphost ~$ kubectl get deployment nginx-deployment 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           71s

thor@jumphost ~$ kubectl get deployment nginx-deployment -o wide
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES         SELECTOR
nginx-deployment   3/3     3            3           98s   nginx-container   nginx:latest   app=nginx

thor@jumphost ~$ kubectl describe deployment nginx-deployment 
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Mon, 15 Sep 2025 06:29:27 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx-container:
    Image:         nginx:latest
    Port:          80/TCP
    Host Port:     0/TCP
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-5b58668cfc (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  2m14s  deployment-controller  Scaled up replica set nginx-deployment-5b58668cfc to 3

thor@jumphost ~$ kubectl get pod
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5b58668cfc-9hnxj   1/1     Running   0          3m36s
nginx-deployment-5b58668cfc-b7skc   1/1     Running   0          3m36s
nginx-deployment-5b58668cfc-nbf2n   1/1     Running   0          3m36s

thor@jumphost ~$ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5b58668cfc-9hnxj   1/1     Running   0          3m40s
nginx-deployment-5b58668cfc-b7skc   1/1     Running   0          3m40s
nginx-deployment-5b58668cfc-nbf2n   1/1     Running   0          3m40s

thor@jumphost ~$ kubectl get service
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        22m
nginx-service   NodePort    10.96.83.161   <none>        80:30011/TCP   3m50s

thor@jumphost ~$ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        22m
nginx-service   NodePort    10.96.83.161   <none>        80:30011/TCP   4m

thor@jumphost ~$ kubectl describe svc nginx-service
Name:                     nginx-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=nginx
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.96.83.161
IPs:                      10.96.83.161
Port:                     http  80/TCP
TargetPort:               80/TCP
NodePort:                 http  30011/TCP
Endpoints:                10.244.0.5:80,10.244.0.6:80,10.244.0.7:80
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

# To get the node IP for the command http://<node-ip>:30011, you'll need to find the IP address of one of your cluster nodes. Here are a few ways to do it:

thor@jumphost ~$ kubectl get nodes -o wide
NAME                      STATUS   ROLES           AGE   VERSION                     INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
kodekloud-control-plane   Ready    control-plane   24m   v1.27.16-1+f5da3b717fc217   172.17.0.2    <none>        Ubuntu 23.10   5.4.0-1106-gcp   containerd://1.7.1-2-g8f682ed69
thor@jumphost ~$ http://172.17.0.2:30011
```

### # nginx-deployment.yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
        ports:
        - containerPort: 80
```

### # nginx-service.yaml 
```
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30011

```

```
thor@jumphost ~$ history | cut -c 8-
pwd
ls 
kubectl get all
vi nginx-deployment.yaml
vi nginx-service.yaml
kubectl apply -f nginx-deployment.yaml 
kubectl apply -f nginx-service.yaml 
kubectl get all
kubectl get deployments
kubectl get deployment nginx-deployment 
kubectl get deployment nginx-deployment -o wide
kubectl describe deployment nginx-deployment -o wide
kubectl describe deployment nginx-deployment 
kubectl get pod
kubectl get pods
kubectl get service
kubectl get svc
kubect describe svc nginx-service
kubectl describe svc nginx-service
# To get the node IP for the command http://<node-ip>:30011, you'll need to find the IP address of one of your cluster nodes. Here are a few ways to do it:
kubectl get nodes -o wide
http://172.17.0.2:30011
curl http://172.17.0.2:30011
```
