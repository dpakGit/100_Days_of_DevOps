

### What I Did
```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
index.php
thor@jumphost ~$ kubectl describe po nginx-phpfpm
```
#### - Output of the describe command
```
Name:             nginx-phpfpm
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Fri, 12 Sep 2025 05:39:46 +0000
Labels:           app=php-app
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  php-fpm-container:  # PHP-FPM CONTAINER SECTION/BLOCK ------------------------------------------------------------
    Container ID:   containerd://829de4ac66faab0d56ae794eefeb753a6d887ee6595719e888628dc92c9eb1ed
    Image:          php:7.2-fpm-alpine
    Image ID:       docker.io/library/php@sha256:2e2d92415f3fc552e9a62548d1235f852c864fcdc94bcf2905805d92baefc87f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 12 Sep 2025 05:39:50 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:                    - VOLUME MOUNT PHP-FPM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      /usr/share/nginx/html from shared-files (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xzx4n (ro)
  nginx-container:   # NGINX CONTAINER BLOCK -------------------------------------------------------------------------------
    Container ID:   containerd://712b642a7a9943ef5a86ce0231316c62e74b7cf73f3efb2c02621ec3ccae4c3c
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:d5f28ef21aabddd098f3dbc21fe5b7a7d7a184720bc07da0b6c9b9820e97f25e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 12 Sep 2025 05:39:57 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:                  - VOLUME MOUNT NGINX
      /etc/nginx/nginx.conf from nginx-config-volume (rw,path="nginx.conf")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xzx4n (ro)
      /var/www/html from shared-files (rw)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  shared-files:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  nginx-config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      nginx-config
    Optional:  false
  kube-api-access-xzx4n:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  107s  default-scheduler  Successfully assigned default/nginx-phpfpm to kodekloud-control-plane
  Normal  Pulling    106s  kubelet            Pulling image "php:7.2-fpm-alpine"
  Normal  Pulled     104s  kubelet            Successfully pulled image "php:7.2-fpm-alpine" in 2.490587121s (2.49060272s including waiting)
  Normal  Created    104s  kubelet            Created container php-fpm-container
  Normal  Started    103s  kubelet            Started container php-fpm-container
  Normal  Pulling    103s  kubelet            Pulling image "nginx:latest"
  Normal  Pulled     96s   kubelet            Successfully pulled image "nginx:latest" in 7.237040123s (7.23705506s including waiting)
  Normal  Created    96s   kubelet            Created container nginx-container
  Normal  Started    96s   kubelet            Started container nginx-container
```

```
thor@jumphost ~$ kubectl get pod nginx-phpfpm -o yaml > pod.yaml
thor@jumphost ~$ ls
index.php  pod.yaml
thor@jumphost ~$ vi pod.yaml 
thor@jumphost ~$ kubectl delete pod nginx-phpfpm
pod "nginx-phpfpm" deleted
thor@jumphost ~$ kubectl apply -f pod.yaml
pod/nginx-phpfpm created
thor@jumphost ~$ kubectl describe pod nginx-phpfpm

```
#### - Output of the describe command
```
Name:             nginx-phpfpm
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Fri, 12 Sep 2025 05:48:59 +0000
Labels:           app=php-app
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  php-fpm-container:
    Container ID:   containerd://4e6dfe6071b3ef3df1c0b91a071b52d0a3eae963390e84d5d4d02d760dea4f60
    Image:          php:7.2-fpm-alpine
    Image ID:       docker.io/library/php@sha256:2e2d92415f3fc552e9a62548d1235f852c864fcdc94bcf2905805d92baefc87f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 12 Sep 2025 05:49:00 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xzx4n (ro)
      /var/www/html from shared-files (rw)
  nginx-container:
    Container ID:   containerd://5dac5bbba4a0ffdc547c58c7fe03a72a15e919d0662017e171e7261131f4fff9
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:d5f28ef21aabddd098f3dbc21fe5b7a7d7a184720bc07da0b6c9b9820e97f25e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 12 Sep 2025 05:49:00 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /etc/nginx/nginx.conf from nginx-config-volume (rw,path="nginx.conf")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xzx4n (ro)
      /var/www/html from shared-files (rw)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  shared-files:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  nginx-config-volume:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      nginx-config
    Optional:  false
  kube-api-access-xzx4n:
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
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulled   24s   kubelet  Container image "php:7.2-fpm-alpine" already present on machine
  Normal  Created  24s   kubelet  Created container php-fpm-container
  Normal  Started  23s   kubelet  Started container php-fpm-container
  Normal  Pulling  23s   kubelet  Pulling image "nginx:latest"
  Normal  Pulled   23s   kubelet  Successfully pulled image "nginx:latest" in 161.481888ms (161.498327ms including waiting)
  Normal  Created  23s   kubelet  Created container nginx-container
  Normal  Started  23s   kubelet  Started container nginx-container
```
thor@jumphost ~$ kubectl cp /home/thor/index.php nginx-phpfpm:/var/www/html/ -c nginx-container



thor@jumphost ~$ history | cut -c 8-
ls
pwd
ls
kubectl describe po nginx-phpfpm 
kubectl get pod nginx-phpfpm -o yaml > pod.yaml
ls
vi pod.yaml 
kubectl delete pod nginx-phpfpm
kubectl apply -f pod.yaml
kubectl describe pod nginx-phpfpm
kubectl cp /home/thor/index.php nginx-phpfpm:/var/www/html/ -c nginx-container
history | cut -c 8-
thor@jumphost ~$ 
