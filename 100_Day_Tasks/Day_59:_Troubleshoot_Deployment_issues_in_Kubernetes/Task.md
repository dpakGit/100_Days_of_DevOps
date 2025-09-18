### Task : Day 59: Troubleshoot Deployment issues in Kubernetes

Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.

The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.




### What I Did
```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
thor@jumphost ~$ kubectl get all
NAME                                    READY   STATUS              RESTARTS   AGE
pod/redis-deployment-54cdf4f76d-w88tp   0/1     ContainerCreating   0          51s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8m2s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deployment   0/1     1            0           51s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deployment-54cdf4f76d   1         1         0       51s


thor@jumphost ~$ kubectl describe pod redis-deployment-54cdf4f76d-w88tp

Name:             redis-deployment-54cdf4f76d-w88tp
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 18 Sep 2025 04:38:54 +0000
Labels:           app=redis
                  pod-template-hash=54cdf4f76d
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/redis-deployment-54cdf4f76d
Containers:
  redis-container:
    Container ID:   
    Image:          redis:alpin
    Image ID:       
    Port:           6379/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ng5v6 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      redis-conig
    Optional:  false
  kube-api-access-ng5v6:
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
  Type     Reason       Age                  From               Message
  ----     ------       ----                 ----               -------
  Normal   Scheduled    11m                  default-scheduler  Successfully assigned default/redis-deployment-54cdf4f76d-w88tp to kodekloud-control-plane
  Warning  FailedMount  91s (x13 over 11m)   kubelet            MountVolume.SetUp failed for volume "config" : configmap "redis-conig" not found
  Warning  FailedMount  46s (x5 over 9m44s)  kubelet            Unable to attach or mount volumes: unmounted volumes=[config], unattached volumes=[], failed to process volumes=[]: timed out waiting for the condition

#  Note the describe pod command : error is outlined in the Events section " MountVolume.SetUp failed for volume "config" : configmap "redis-conig" not found"
# Check the deployment

thor@jumphost ~$ kubectl describe deployment redis-deployment
Name:                   redis-deployment
Namespace:              default
CreationTimestamp:      Thu, 18 Sep 2025 04:38:54 +0000
Labels:                 app=redis
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=redis
Replicas:               1 desired | 1 updated | 1 total | 0 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=redis
  Containers:
   redis-container:
    Image:      redis:alpin # -------------> Error Detected wrong name it should be "alpine"
    Port:       6379/TCP
    Host Port:  0/TCP
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
  Volumes:
   data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   config:
    Type:          ConfigMap (a volume populated by a ConfigMap)
    Name:          redis-conig # --------------------------------> Error Detected wrong name it should be "config"
    Optional:      false
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    False   ProgressDeadlineExceeded
OldReplicaSets:  <none>
NewReplicaSet:   redis-deployment-54cdf4f76d (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  17m   deployment-controller  Scaled up replica set redis-deployment-54cdf4f76d to 1

# Two errors detected :
1.  Containers:
   redis-container:
    Image:      redis:alpin # *
    Port:       6379/TCP
    Host Port:  0/TCP
    # Incorrect Image name "redis:alpin" it should be "redis:alpine"

2. config:
    Type:          ConfigMap (a volume populated by a ConfigMap)
    Name:          redis-conig # *
    Optional:      false
  Node-Selectors:  <none>

# Incorrect Config map name "redis-conig" it should be "redis-config"

Use kubectl edit deployment redis-deployment command to make changes 
OR store the deployment yaml file, update the file delete the earlier deployment and redeploy by using the apply command. 

thor@jumphost ~$ kubectl edit deployment redis-deployment

OR

thor@jumphost ~$ kubectl get deployment redis-deployment -o yaml > redis-deployment.yaml
thor@jumphost ~$ ls
redis-deployment.yaml
thor@jumphost ~$ cat redis-deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"creationTimestamp":null,"labels":{"app":"redis"},"name":"redis-deployment","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"redis"}},"strategy":{},"template":{"metadata":{"creationTimestamp":null,"labels":{"app":"redis"}},"spec":{"containers":[{"image":"redis:alpin","name":"redis-container","ports":[{"containerPort":6379}],"resources":{"requests":{"cpu":"0.3"}},"volumeMounts":[{"mountPath":"/redis-master-data","name":"data"},{"mountPath":"/redis-master","name":"config"}]}],"volumes":[{"emptyDir":{},"name":"data"},{"configMap":{"name":"redis-conig"},"name":"config"}]}}}}
  creationTimestamp: "2025-09-18T04:38:54Z"
  generation: 1
  labels:
    app: redis
  name: redis-deployment
  namespace: default
  resourceVersion: "1831"
  uid: e3f65161-621a-4e65-a702-88a4f96a65d3
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: redis
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redis
    spec:
      containers:
      - image: redis:alpin
        imagePullPolicy: IfNotPresent
        name: redis-container
        ports:
        - containerPort: 6379
          protocol: TCP
        resources:
          requests:
            cpu: 300m
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /redis-master-data
          name: data
        - mountPath: /redis-master
          name: config
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - emptyDir: {}
        name: data
      - configMap:
          defaultMode: 420
          name: redis-conig
        name: config
status:
  conditions:
  - lastTransitionTime: "2025-09-18T04:38:54Z"
    lastUpdateTime: "2025-09-18T04:38:54Z"
    message: Deployment does not have minimum availability.
    reason: MinimumReplicasUnavailable
    status: "False"
    type: Available
  - lastTransitionTime: "2025-09-18T04:48:55Z"
    lastUpdateTime: "2025-09-18T04:48:55Z"
    message: ReplicaSet "redis-deployment-54cdf4f76d" has timed out progressing.
    reason: ProgressDeadlineExceeded
    status: "False"
    type: Progressing
  observedGeneration: 1
  replicas: 1
  unavailableReplicas: 1
  updatedReplicas: 1

thor@jumphost ~$ vi redis-deployment.yaml # update the yaml file with correct input

thor@jumphost ~$ kubectl apply -f redis-deployment.yaml 
deployment.apps/redis-deployment configured

thor@jumphost ~$ kubectl get po
NAME                                READY   STATUS              RESTARTS   AGE
redis-deployment-54cdf4f76d-w88tp   0/1     ContainerCreating   0          30m
redis-deployment-5bcd4c7d64-84b5p   0/1     ErrImagePull        0          8s
thor@jumphost ~$ kubectl get po
NAME                                READY   STATUS              RESTARTS   AGE
redis-deployment-54cdf4f76d-w88tp   0/1     ContainerCreating   0          30m
redis-deployment-5bcd4c7d64-84b5p   0/1     ImagePullBackOff    0          22s

# The above error is due to the wrong image name
# Following are the steps to resolve it :

thor@jumphost ~$ kubectl describe pod redis-deployment-5bcd4c7d64-84b5p 
Name:             redis-deployment-5bcd4c7d64-84b5p
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 18 Sep 2025 05:09:17 +0000
Labels:           app=redis
                  pod-template-hash=5bcd4c7d64
Annotations:      <none>
Status:           Pending
IP:               10.244.0.5
IPs:
  IP:           10.244.0.5
Controlled By:  ReplicaSet/redis-deployment-5bcd4c7d64
Containers:
  redis-container:
    Container ID:   
    Image:          redis:alpin
    Image ID:       
    Port:           6379/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-c8kk4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      redis-config
    Optional:  false
  kube-api-access-c8kk4:
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
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  92s                default-scheduler  Successfully assigned default/redis-deployment-5bcd4c7d64-84b5p to kodekloud-control-plane
  Normal   BackOff    20s (x4 over 91s)  kubelet            Back-off pulling image "redis:alpin"
  Warning  Failed     20s (x4 over 91s)  kubelet            Error: ImagePullBackOff
  Normal   Pulling    6s (x4 over 92s)   kubelet            Pulling image "redis:alpin"
  Warning  Failed     6s (x4 over 91s)   kubelet            Failed to pull image "redis:alpin": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/redis:alpin": failed to resolve reference "docker.io/library/redis:alpin": docker.io/library/redis:alpin: not found
  Warning  Failed     6s (x4 over 91s)   kubelet            Error: ErrImagePull

thor@jumphost ~$ vi   redis-deployment.yaml  # Update the yaml file with correct image name

thor@jumphost ~$ kubectl apply -f redis-deployment.yaml 
deployment.apps/redis-deployment created

thor@jumphost ~$ kubectl get deployments.apps 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   1/1     1            1           16s

thor@jumphost ~$ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/redis-deployment-7c8d4f6ddf-9npd8   1/1     Running   0          25s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   43m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deployment   1/1     1            1           25s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deployment-7c8d4f6ddf   1         1         1       25s

thor@jumphost ~$ kubectl get po
NAME                                READY   STATUS    RESTARTS   AGE
redis-deployment-7c8d4f6ddf-9npd8   1/1     Running   0          34s
thor@jumphost ~$ kubectl get po redis-deployment-7c8d4f6ddf-9npd8 
NAME                                READY   STATUS    RESTARTS   AGE
redis-deployment-7c8d4f6ddf-9npd8   1/1     Running   0          47s

thor@jumphost ~$ kubectl describe po redis-deployment-7c8d4f6ddf-9npd8 
Name:             redis-deployment-7c8d4f6ddf-9npd8
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 18 Sep 2025 05:14:59 +0000
Labels:           app=redis
                  pod-template-hash=7c8d4f6ddf
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:           10.244.0.6
Controlled By:  ReplicaSet/redis-deployment-7c8d4f6ddf
Containers:
  redis-container:
    Container ID:   containerd://1a2120c08aec2a19aeb657b962945c70831136665e77f38c3a933491798f3060
    Image:          redis:alpine
    Image ID:       docker.io/library/redis@sha256:987c376c727652f99625c7d205a1cba3cb2c53b92b0b62aade2bd48ee1593232
    Port:           6379/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 18 Sep 2025 05:15:03 +0000
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-r2f4j (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      redis-config
    Optional:  false
  kube-api-access-r2f4j:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  65s   default-scheduler  Successfully assigned default/redis-deployment-7c8d4f6ddf-9npd8 to kodekloud-control-plane
  Normal  Pulling    65s   kubelet            Pulling image "redis:alpine"
  Normal  Pulled     62s   kubelet            Successfully pulled image "redis:alpine" in 2.841936567s (2.841954916s including waiting)
  Normal  Created    62s   kubelet            Created container redis-container
  Normal  Started    61s   kubelet            Started container redis-container
```
