### Task : Day 67: Deploy Guest Book App on Kubernetes

The Nautilus Application development team has finished development of one of the applications and it is ready for deployment. It is a guestbook application that will be used to manage entries for guests/visitors. As per discussion with the DevOps team, they have finalized the infrastructure that will be deployed on Kubernetes cluster. Below you can find more details about it.


BACK-END TIER

Create a deployment named redis-master for Redis master.

a.) Replicas count should be 1.

b.) Container name should be master-redis-xfusion and it should use image redis.

c.) Request resources as CPU should be 100m and Memory should be 100Mi.

d.) Container port should be redis default port i.e 6379.

Create a service named redis-master for Redis master. Port and targetPort should be Redis default port i.e 6379.

Create another deployment named redis-slave for Redis slave.

a.) Replicas count should be 2.

b.) Container name should be slave-redis-xfusion and it should use gcr.io/google_samples/gb-redisslave:v3 image.

c.) Requests resources as CPU should be 100m and Memory should be 100Mi.

d.) Define an environment variable named GET_HOSTS_FROM and its value should be dns.

e.) Container port should be Redis default port i.e 6379.

Create another service named redis-slave. It should use Redis default port i.e 6379.

FRONT END TIER

Create a deployment named frontend.

a.) Replicas count should be 3.

b.) Container name should be php-redis-xfusion and it should use gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff image.

c.) Request resources as CPU should be 100m and Memory should be 100Mi.

d.) Define an environment variable named as GET_HOSTS_FROM and its value should be dns.

e.) Container port should be 80.

Create a service named frontend. Its type should be NodePort, port should be 80 and its nodePort should be 30009.

Finally, you can check the guestbook app by clicking on App button.


You can use any labels as per your choice.

Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

------------------------------------------------

### Here's an elaboration of the requirements:

1. Back-end Tier:

- Redis Master:
    - Create a Deployment named redis-master with:
        - 1 replica
        - Container name: master-redis-xfusion
        - Image: redis
        - Resource requests: CPU - 100m, Memory - 100Mi
        - Port: 6379 (Redis default port)
    - Create a Service named redis-master with:
        - Port: 6379
        - TargetPort: 6379
- Redis Slave:
    - Create a Deployment named redis-slave with:
        - 2 replicas
        - Container name: slave-redis-xfusion
        - Image: gcr.io/google_samples/gb-redisslave:v3
        - Resource requests: CPU - 100m, Memory - 100Mi
        - Environment variable: GET_HOSTS_FROM with value dns
        - Port: 6379 (Redis default port)
    - Create a Service named redis-slave with:
        - Port: 6379

2. Front-end Tier:

- Frontend Application:
    - Create a Deployment named frontend with:
        - 3 replicas
        - Container name: php-redis-xfusion
        - Image: gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff
        - Resource requests: CPU - 100m, Memory - 100Mi
        - Environment variable: GET_HOSTS_FROM with value dns
        - Port: 80
    - Create a Service named frontend with:
        - Type: NodePort
        - Port: 80
        - NodePort: 30009

3. Configurations:

- Replicas Count: Specify the number of replicas for each deployment as mentioned above.
- Container Names: Use the specified container names for each deployment.
- Images: Use the specified images for each deployment.
- Resource Requests: Specify the resource requests (CPU and Memory) for each deployment as mentioned above.
- Environment Variables: Define the environment variables as specified above.
- Port Configurations: Use the specified ports for each service and deployment.
- NodePort Type: Use NodePort type for the Frontend service with the specified nodePort.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ vi guestbook-deployment.yaml

thor@jumphost ~$ kubectl apply -f guestbook-deployment.yaml
deployment.apps/redis-master created
service/redis-master created
deployment.apps/redis-slave created
service/redis-slave created
deployment.apps/frontend created
service/frontend created

thor@jumphost ~$ kubectl get deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
frontend       3/3     3            3           63s
redis-master   1/1     1            1           64s
redis-slave    2/2     2            2           64s


thor@jumphost ~$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
frontend-5468469847-8rwj6       1/1     Running   0          78s
frontend-5468469847-bngmd       1/1     Running   0          78s
frontend-5468469847-gn2dr       1/1     Running   0          78s
redis-master-679c6b9b44-6lqqm   1/1     Running   0          78s
redis-slave-67f788df9c-llrms    1/1     Running   0          78s
redis-slave-67f788df9c-rtjlw    1/1     Running   0          78s


thor@jumphost ~$ kubectl get all
NAME                                READY   STATUS    RESTARTS   AGE
pod/frontend-5468469847-8rwj6       1/1     Running   0          90s
pod/frontend-5468469847-bngmd       1/1     Running   0          90s
pod/frontend-5468469847-gn2dr       1/1     Running   0          90s
pod/redis-master-679c6b9b44-6lqqm   1/1     Running   0          90s
pod/redis-slave-67f788df9c-llrms    1/1     Running   0          90s
pod/redis-slave-67f788df9c-rtjlw    1/1     Running   0          90s

NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/frontend       NodePort    10.96.237.70    <none>        80:30009/TCP   90s
service/kubernetes     ClusterIP   10.96.0.1       <none>        443/TCP        23m
service/redis-master   ClusterIP   10.96.109.168   <none>        6379/TCP       91s
service/redis-slave    ClusterIP   10.96.15.80     <none>        6379/TCP       90s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/frontend       3/3     3            3           90s
deployment.apps/redis-master   1/1     1            1           91s
deployment.apps/redis-slave    2/2     2            2           91s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/frontend-5468469847       3         3         3       90s
replicaset.apps/redis-master-679c6b9b44   1         1         1       91s
replicaset.apps/redis-slave-67f788df9c    2         2         2       90s
```


```
history | cut -c 8-
pwd
ls
vi guestbook-deployment.yaml
kubectl apply -f guestbook-deployment.yaml
kubectl get all
kubectl get deployment
kubectl get pod
kubectl get all
history | cut -c 8-
```

### # guestbook-deployment.yaml

click on the following link to copy the yaml : https://g.co/gemini/share/6a08e695ecc8

```
#
# Guestbook Application Kubernetes Manifests
# This single file contains all the necessary Kubernetes objects to deploy the guestbook application.
# It includes the Redis master and slave instances for the back-end, and the PHP front-end.
# The documents are separated by a '---' marker for easy, single-command deployment.
#

---
#
# 1. Redis Master Deployment
# This deployment creates and manages a single replica of the Redis master database.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-master
spec:
  # The number of desired pods to maintain.
  replicas: 1
  selector:
    # This selector links the deployment to the pods it manages.
    matchLabels:
      app: redis-master
  template:
    metadata:
      labels:
        app: redis-master
    spec:
      containers:
      - name: master-redis-xfusion
        # Uses the official Redis image.
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        # Exposes the default Redis port.
        ports:
        - containerPort: 6379

---
#
# 2. Redis Master Service
# This service creates a stable network endpoint for the Redis master pod.
# It allows other pods, like the Redis slaves, to find and connect to it.
#
apiVersion: v1
kind: Service
metadata:
  name: redis-master
spec:
  # This selector links the service to the Redis master pod.
  selector:
    app: redis-master
  ports:
  - name: redis
    # The port on which the service will listen.
    port: 6379
    # The port on the container to which traffic will be forwarded.
    targetPort: 6379

---
#
# 3. Redis Slave Deployment
# This deployment creates and manages two replicas of the Redis slave instances.
# They connect to the Redis master to replicate data.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-slave
spec:
  # Specifies two replicas for redundancy.
  replicas: 2
  selector:
    matchLabels:
      app: redis-slave
  template:
    metadata:
      labels:
        app: redis-slave
    spec:
      containers:
      - name: slave-redis-xfusion
        # Uses the specific Google-provided image for the Redis slave.
        image: gcr.io/google_samples/gb-redisslave:v3
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        # This environment variable tells the slaves how to find the master (via DNS).
        env:
        - name: GET_HOSTS_FROM
          value: dns
        ports:
        - containerPort: 6379

---
#
# 4. Redis Slave Service
# This service provides a stable network endpoint for the Redis slave pods.
# The frontend pods will use this service to connect to the slaves.
#
apiVersion: v1
kind: Service
metadata:
  name: redis-slave
spec:
  # This selector links the service to the Redis slave pods.
  selector:
    app: redis-slave
  ports:
  - name: redis
    # The port on which the service will listen.
    port: 6379
    # The port on the container to which traffic will be forwarded.
    targetPort: 6379

---
#
# 5. Frontend Deployment
# This deployment manages the front-end guestbook application.
# It creates three replicas for high availability and load balancing.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  # Specifies three replicas for the front-end.
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: php-redis-xfusion
        # Uses the specific Google-provided image for the front-end.
        image: gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        # This environment variable tells the front-end where to find the Redis slaves.
        env:
        - name: GET_HOSTS_FROM
          value: dns
        ports:
        - containerPort: 80

---
#
# 6. Frontend Service
# This service exposes the front-end application to the outside world.
# A NodePort service makes the application accessible on a specific port on each node.
#
apiVersion: v1
kind: Service
metadata:
  name: frontend
spec:
  # This service type exposes the service on each node's IP at a static port.
  type: NodePort
  # This selector links the service to the frontend pods.
  selector:
    app: frontend
  ports:
  - name: http
    # The port on which the service will listen (inside the cluster).
    port: 80
    # The port on the container to which traffic will be forwarded.
    targetPort: 80
    # The port on the node's IP that is used to access the service.
    nodePort: 30009
```

