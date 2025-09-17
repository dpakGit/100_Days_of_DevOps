### Task : Day 58: Deploy Grafana on Kubernetes Cluster

The Nautilus DevOps teams is planning to set up a Grafana tool to collect and analyze analytics from some applications. They are planning to deploy it on Kubernetes cluster. Below you can find more details.

1.) Create a deployment named grafana-deployment-datacenter using any grafana image for Grafana app. Set other parameters as per your choice.

2.) Create NodePort type service with nodePort 32000 to expose the app.

You need not to make any configuration changes inside the Grafana app once deployed, just make sure you are able to access the Grafana login page.



### What I Did

```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls

thor@jumphost ~$ vi grafana-deployment.yaml 

thor@jumphost ~$ kubectl apply -f grafana-deployment.yaml 
deployment.apps/grafana-deployment-datacenter created

thor@jumphost ~$ kubectl get deployments.apps 
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
grafana-deployment-datacenter   0/1     1            0           16s

thor@jumphost ~$ kubectl get deploy
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
grafana-deployment-datacenter   1/1     1            1           39s

thor@jumphost ~$ kubectl get all
NAME                                                READY   STATUS    RESTARTS   AGE
pod/grafana-deployment-datacenter-77648df4c-62966   1/1     Running   0          3m48s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   22m

NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana-deployment-datacenter   1/1     1            1           3m48s

NAME                                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/grafana-deployment-datacenter-77648df4c   1         1         1       3m48s

thor@jumphost ~$ vi grafana-service.yaml

thor@jumphost ~$ kubectl apply -f grafana-service.yaml 
service/grafana-service-datacenter created

thor@jumphost ~$ kubectl get all
NAME                                                READY   STATUS    RESTARTS   AGE
pod/grafana-deployment-datacenter-77648df4c-62966   1/1     Running   0          6m30s

NAME                                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
service/grafana-service-datacenter   NodePort    10.96.3.135   <none>        3000:32000/TCP   82s

service/kubernetes                   ClusterIP   10.96.0.1     <none>        443/TCP          25m

NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana-deployment-datacenter   1/1     1            1           6m30s

NAME                                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/grafana-deployment-datacenter-77648df4c   1         1         1       6m30s
thor@jumphost ~$ kubectl get svc grafana-service-datacenter 
NAME                         TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
grafana-service-datacenter   NodePort   10.96.3.135   <none>        3000:32000/TCP   3m20s

# Command to get the node IP

thor@jumphost ~$ kubectl get nodes -o wide
NAME                      STATUS   ROLES           AGE   VERSION                     INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
kodekloud-control-plane   Ready    control-plane   28m   v1.27.16-1+f5da3b717fc217   172.17.0.2    <none>        Ubuntu 23.10   5.4.0-1106-gcp   containerd://1.7.1-2-g8f682ed69

# Run the following command in the browser

http://172.17.0.2:32000

```

### # grafana-deployment.yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana-deployment-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        ports:
        - containerPort: 3000
```

### # grafana-service.yaml 


```
apiVersion: v1
kind: Service
metadata:
  name: grafana-service-datacenter
spec:
  type: NodePort
  selector:
    app: grafana
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
      nodePort: 32000
```

```
thor@jumphost ~$ history | cut -c 8-
pwd
ls
vi grafana-deployment.yaml 
kubectl apply -f grafana-deployment.yaml 
kubectl get deployments.apps 
kubectl get deploy
kubectl get all
vi grafana-service.yaml
kubectl apply -f grafana-service.yaml 
kubects get all
kubectl get svc grafana-service-datacenter 
```
