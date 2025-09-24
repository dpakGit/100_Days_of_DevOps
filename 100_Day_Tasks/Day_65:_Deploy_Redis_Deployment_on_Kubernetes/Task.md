### Task : Day 65: Deploy Redis Deployment on Kubernetes

The Nautilus application development team observed some performance issues with one of the application that is deployed in Kubernetes cluster. After looking into number of factors, the team has suggested to use some in-memory caching utility for DB service. After number of discussions, they have decided to use Redis. Initially they would like to deploy Redis on kubernetes cluster for testing and later they will move it to production. Please find below more details about the task:

Create a redis deployment with following parameters:

Create a config map called my-redis-config having maxmemory 2mb in redis-config.

Name of the deployment should be redis-deployment, it should use
redis:alpine image and container name should be redis-container. Also make sure it has only 1 replica.

The container should request for 1 CPU.

Mount 2 volumes:

a. An Empty directory volume called data at path /redis-master-data.

b. A configmap volume called redis-config at path /redis-master.

c. The container should expose the port 6379.

Finally, redis-deployment should be in an up and running state.


### Let's break down the task in detail:

Task: Deploy Redis on a Kubernetes cluster for testing purposes.

What needs to be done?

The task requires creating a Redis deployment on a Kubernetes cluster with specific configuration and settings. This involves creating a ConfigMap, a Deployment, and configuring the container to use the specified settings.

Data Given:

The following information is provided to complete the task:

1. Application: Redis
    - Redis is an in-memory caching utility that will be used to improve the performance of the application.
2. Deployment Name: redis-deployment
    - The name of the deployment that needs to be created is specified as "redis-deployment".
3. Docker Image: redis:alpine
    - The Docker image that needs to be used for the Redis deployment is "redis:alpine", which is a lightweight version of the Redis image.
4. Container Name: redis-container
    - The name of the container that will be created within the deployment is specified as "redis-container".
5. Replicas: 1
    - The number of replicas for the deployment is set to 1, which means only one instance of the Redis container will be running.
6. CPU Request: 1 CPU
    - The container will request 1 CPU, which means it will be allocated 1 CPU core.
7. ConfigMap:
    - Name: my-redis-config
        - The name of the ConfigMap that needs to be created is specified as "my-redis-config".
    - maxmemory: 2mb
        - The ConfigMap will contain a configuration setting for Redis that sets the maximum memory to 2 megabytes.
8. Volumes:
    - Empty directory volume: data
        - An empty directory volume named "data" will be created and mounted at the path "/redis-master-data".
    - ConfigMap volume: redis-config
        - The ConfigMap "my-redis-config" will be mounted as a volume at the path "/redis-master".
9. Port: 6379
    - The container will expose port 6379, which is the default port for Redis.

Requirements:

The task requires creating a Redis deployment with the specified configuration and settings, including:

1. Creating a ConfigMap with the specified name and configuration.
2. Creating a deployment with the specified name, image, container name, replicas, and CPU request.
3. Mounting the empty directory volume and ConfigMap volume at the specified paths.
4. Exposing port 6379.
5. Ensuring the deployment is in an up and running state.

By following these requirements, the Redis deployment will be created with the specified configuration and settings, and will be ready for use.

#### Note : Decouple application configuration from code, making it easier to manage and update values without changing the code.


### What I Did

```
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
