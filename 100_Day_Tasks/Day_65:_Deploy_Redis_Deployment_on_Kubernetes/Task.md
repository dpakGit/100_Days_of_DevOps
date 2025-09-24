### Task : Day 65: Deploy Redis Deployment on Kubernetes


### what I Did

thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8m47s

thor@jumphost ~$ vi redis-configmap.yaml

thor@jumphost ~$ kubectl apply -f redis-configmap.yaml
configmap/my-redis-config created

thor@jumphost ~$ kubectl get cm 
NAME               DATA   AGE
kube-root-ca.crt   1      26m
my-redis-config    1      11s

thor@jumphost ~$ vi redis-deployment.yaml

thor@jumphost ~$ kubectl apply -f redis-deployment.yaml 
deployment.apps/redis-deployment created

thor@jumphost ~$ kubectl get deployments.apps 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           11s

thor@jumphost ~$ kubectl get pod
NAME                               READY   STATUS    RESTARTS   AGE
redis-deployment-fd7d5749d-xw78z   1/1     Running   0          30s

thor@jumphost ~$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/redis-deployment-fd7d5749d-xw78z   1/1     Running   0          38s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   30m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deployment   1/1     1            1           38s

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deployment-fd7d5749d   1         1         1       38s
```

### History of commands
```
pwd
ls
kubectl get all
vi redis-configmap.yaml
kubectl apply -f redis-configmap.yaml
kubectl get cm 
vi redis-deployment.yaml
kubectl apply -f redis-deployment.yaml 
kubectl get deployments.apps 
kubectl get pod
kubectl get all
history | cut -c 8-
```


### # redis-configmap.yaml

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-redis-config
data:
  redis-config: |
    maxmemory 2mb
    maxmemory-policy allkeys-lru
```

### # redis-deployment.yaml 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis-container
        image: redis:alpine
        ports:
        - containerPort: 6379
        resources:
          requests:
            cpu: 1
        volumeMounts:
        - name: data
          mountPath: /redis-master-data
        - name: redis-config
          mountPath: /redis-master
      volumes:
      - name: data
        emptyDir: {}
      - name: redis-config
        configMap:
          name: my-redis-config
          items:
          - key: redis-config
            path: redis.conf
```
