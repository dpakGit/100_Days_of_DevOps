
### Task 

The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:

Create a pod named httpd-pod with a container named httpd-container. Use the httpd image with the latest tag (specify as httpd:latest). Set the following resource limits:

Requests: Memory: 15Mi, CPU: 100m

Limits: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

--------------------------------


### What I Did
```
thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   5m47s

thor@jumphost ~$ kubectl get pods
No resources found in default namespace.

thor@jumphost ~$ vi httpd-pod.yaml

thor@jumphost ~$ kubectl apply -f httpd-pod.yaml
pod/httpd-pod created

thor@jumphost ~$ kubectl get po
NAME        READY   STATUS    RESTARTS   AGE
httpd-pod   1/1     Running   0          10s

thor@jumphost ~$ kubectl get pod httpd-pod
NAME        READY   STATUS    RESTARTS   AGE
httpd-pod   1/1     Running   0          26s


thor@jumphost ~$ kubectl describe pod httpd-pod # In the output under limits check
Name:             httpd-pod
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Tue, 26 Aug 2025 05:59:07 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  httpd-container:
    Container ID:   containerd://2ab0ea9bb0ff36cbc87af1bf98ca64d50b0c7546ea571143ee2cb09af6076234
    Image:          httpd:latest
    Image ID:       docker.io/library/httpd@sha256:3198c1839e1a875f8b83803083758a7635f1ae999f0601f30f2f3b8ce2ac99e3
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 26 Aug 2025 05:59:13 +0000
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  20Mi
    Requests:
      cpu:        100m
      memory:     15Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-68bjg (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-68bjg:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m42s  default-scheduler  Successfully assigned default/httpd-pod to kodekloud-control-plane
  Normal  Pulling    3m42s  kubelet            Pulling image "httpd:latest"
  Normal  Pulled     3m37s  kubelet            Successfully pulled image "httpd:latest" in 4.966597124s (4.966620415s including waiting)
  Normal  Created    3m37s  kubelet            Created container httpd-container
  Normal  Started    3m36s  kubelet            Started container httpd-container
```
### # httpd-pod.yaml 

```
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    resources:
      requests:
        memory: 15Mi
        cpu: 100m
      limits:
        memory: 20Mi
        cpu: 100m
```

```
thor@jumphost ~$ history | cut -c 8-
kubectl
kubectl get all
kubectl get pods
vi httpd-pod.yaml
kubectl apply -f httpd-pod.yaml
kubectl get po
kubectl get pod httpd-pod
cat httpd-pod.yaml 
kubectl describe pod httpd-pod
kubectl top pods
kubectl get deployment metrics-server -n kube-system
history | cut -c 8-
thor@jumphost ~$
```

## If you prefer to create the pod directly using kubectl run, you can use the following command:


```
kubectl run httpd-pod --image=httpd:latest --requests='cpu=100m,memory=15Mi' --limits='cpu=100m,memory=20Mi'
```

- Note: When using kubectl run, the container name is automatically set to the same name as the pod. In this case, the container name would be httpd-pod.

If you want to specify a different container name, you can't do it directly with kubectl run. Instead, you'll need to create a YAML configuration file that defines the pod and container.

- If you still want to use kubectl run, you can stick with the default container name (httpd-pod).
