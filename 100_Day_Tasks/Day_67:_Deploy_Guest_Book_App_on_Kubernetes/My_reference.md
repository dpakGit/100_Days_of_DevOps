Here are the steps, commands, and YAML files to create the objects individually and separately :

Step 1: Create a Deployment and Service for Redis Master

Create a YAML file named redis-master-deployment.yaml with the following content:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-master
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis-master
  template:
    metadata:
      labels:
        app: redis-master
    spec:
      containers:
      - name: master-redis-xfusion
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        ports:
        - containerPort: 6379
  ```

Create a YAML file named redis-master-service.yaml with the following content:
```
apiVersion: v1
kind: Service
metadata:
  name: redis-master
spec:
  selector:
    app: redis-master
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
```
Apply the YAML files using the following commands:
```
kubectl apply -f redis-master-deployment.yaml
kubectl apply -f redis-master-service.yaml
```
Explanation:

- We create a deployment named redis-master with 1 replica, using the redis image, and requesting 100m CPU and 100Mi memory.
- We expose port 6379, which is the default port for Redis.
- We create a service named redis-master that selects the redis-master deployment and exposes port 6379.

Step 2: Create a Deployment and Service for Redis Slave

Create a YAML file named redis-slave-deployment.yaml with the following content:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-slave
spec:
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
        image: gcr.io/google_samples/gb-redisslave:v3
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        env:
        - name: GET_HOSTS_FROM
          value: dns
        ports:
        - containerPort: 6379
```
Create a YAML file named redis-slave-service.yaml with the following content:
```
apiVersion: v1
kind: Service
metadata:
  name: redis-slave
spec:
  selector:
    app: redis-slave
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
```
Apply the YAML files using the following commands:
```
kubectl apply -f redis-slave-deployment.yaml
kubectl apply -f redis-slave-service.yaml
```
Explanation:

- We create a deployment named redis-slave with 2 replicas, using the gcr.io/google_samples/gb-redisslave:v3 image, and requesting 100m CPU and 100Mi memory.
- We set an environment variable GET_HOSTS_FROM to dns.
- We expose port 6379, which is the default port for Redis.
- We create a service named redis-slave that selects the redis-slave deployment and exposes port 6379.

Step 3: Create a Deployment and Service for Frontend

Create a YAML file named frontend-deployment.yaml with the following content:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
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
        image: gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
        env:
        - name: GET_HOSTS_FROM
          value: dns
        ports:
        - containerPort: 80
```
Create a YAML file named frontend-service.yaml with the following content:
```
apiVersion: v1
kind: Service
metadata:
  name: frontend
spec:
  type: NodePort
  selector:
    app: frontend
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30009
```
Apply the YAML files using the following commands:

bash
kubectl apply -f redis-master-deployment.yaml
kubectl apply -f redis-master-service.yaml
kubectl apply -f redis-slave-deployment.yaml
kubectl apply -f redis-slave-service.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
