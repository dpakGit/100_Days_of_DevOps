
### What I did

```
thor@jumphost ~$ ls

thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27m

thor@jumphost ~$ vi pod.yaml

thor@jumphost ~$ kubectl apply -f pod.yaml
pod/pod-httpd created

thor@jumphost ~$ kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
pod-httpd   1/1     Running   0          25s

thor@jumphost ~$ kubectl get pods -l app=httpd_app

NAME        READY   STATUS    RESTARTS   AGE
pod-httpd   1/1     Running   0          3m36s

thor@jumphost ~$ kubectl describe pod pod-httpd

Name:             pod-httpd
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Sun, 07 Sep 2025 05:23:32 +0000
Labels:           app=httpd_app
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  httpd-container:
    Container ID:   containerd://f2d17e32b606b754f9033340b1f73b3f54b8756f463c5ceca62e7bf727464fc9
    Image:          httpd:latest
    Image ID:       docker.io/library/httpd@sha256:3198c1839e1a875f8b83803083758a7635f1ae999f0601f30f2f3b8ce2ac99e3
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 07 Sep 2025 05:23:38 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-cnmsf (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-cnmsf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  4m32s  default-scheduler  Successfully assigned default/pod-httpd to kodekloud-control-plane
  Normal  Pulling    4m31s  kubelet            Pulling image "httpd:latest"
  Normal  Pulled     4m27s  kubelet            Successfully pulled image "httpd:latest" in 4.372709614s (4.372728478s including waiting)
  Normal  Created    4m27s  kubelet            Created container httpd-container
  Normal  Started    4m26s  kubelet            Started container httpd-container


thor@jumphost ~$ kubectl get pod pod-httpd -o yaml
```

### # Pod.yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: pod-httpd
  labels:
    app: httpd_app
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
```
