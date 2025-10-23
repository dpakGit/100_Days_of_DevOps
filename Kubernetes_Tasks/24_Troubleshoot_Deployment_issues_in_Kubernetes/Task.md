### Task : Troubleshoot Deployment issues in Kubernetes

Last week, the Nautilus DevOps team deployed a redis app on Kubernetes cluster, which was working fine so far. This morning one of the team members was making some changes in this existing setup, but he made some mistakes and the app went down. We need to fix this as soon as possible. Please take a look.

The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.

### What I Did

```
thor@jumphost ~$ kubectl get deploy redis-deployment 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
redis-deployment   0/1     1            0           42s

thor@jumphost ~$ kubectl get po
NAME                               READY   STATUS              RESTARTS   AGE
redis-deployment-6fd9d5fcb-lqxxd   0/1     ContainerCreating   0          108s

thor@jumphost ~$ kubectl get po -o wide
NAME                               READY   STATUS              RESTARTS   AGE    IP       NODE                      NOMINATED NODE   READINESS GATES
redis-deployment-6fd9d5fcb-lqxxd   0/1     ContainerCreating   0          115s   <none>   kodekloud-control-plane   <none>           <none>

thor@jumphost ~$ kubectl describe po redis-deployment-6fd9d5fcb-lqxxd
Name:             redis-deployment-6fd9d5fcb-lqxxd
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 23 Oct 2025 12:57:13 +0000
Labels:           app=redis
                  pod-template-hash=6fd9d5fcb
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/redis-deployment-6fd9d5fcb
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-g2nb6 (ro)
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
    Name:      redis-cofig
    Optional:  false
  kube-api-access-g2nb6:
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
  Normal   Scheduled    2m46s                default-scheduler  Successfully assigned default/redis-deployment-6fd9d5fcb-lqxxd to kodekloud-control-plane
  Warning  FailedMount  43s                  kubelet            Unable to attach or mount volumes: unmounted volumes=[config], unattached volumes=[], failed to process volumes=[]: timed out waiting for the condition
  Warning  FailedMount  38s (x9 over 2m46s)  kubelet            MountVolume.SetUp failed for volume "config" : configmap "redis-cofig" not found
thor@jumphost ~$ kubectl edit deploy redis-deployment 
deployment.apps/redis-deployment edited

# Trouble with the describe command output

There are two issues here:

1. ImagePullBackOff: The first issue is with the image name. You're trying to use the image "redis:alpin" which doesn't exist. The correct image name is "redis:alpine".

2. ConfigMap not found: The second issue is with the ConfigMap "redis-cofig" which is not found. You probably meant to use "redis-config".

To fix these issues, you can try the following:

1. Update the Deployment's configuration to use the correct image name "redis:alpine".


bash
kubectl edit deployment redis-deployment

  - Change the name of redis image from "redis:alpin" to "redis:alpine".
  
  - Also edit the name of Config map name from "redis-cofig" to "redis-config".


thor@jumphost ~$ kubectl get po
NAME                                READY   STATUS        RESTARTS   AGE
redis-deployment-6fd9d5fcb-lqxxd    0/1     Terminating   0          6m19s
redis-deployment-7c8d4f6ddf-gpwff   1/1     Running       0          50s

# Above we can see the older pods are getting  deleted and newer ones are coming up.

thor@jumphost ~$ kubectl get po
NAME                                READY   STATUS    RESTARTS   AGE
redis-deployment-7c8d4f6ddf-gpwff   1/1     Running   0          93s

#  Note : New pods came up with new names

thor@jumphost ~$ kubectl describe po redis-deployment-6fd9d5fcb-lqxxd
Error from server (NotFound): pods "redis-deployment-6fd9d5fcb-lqxxd" not found

# Above we can see the older pods are getting  deleted and newer ones are coming up.

# Verify the edited things

thor@jumphost ~$ kubectl describe po redis-deployment-7c8d4f6ddf-gpwff 
Name:             redis-deployment-7c8d4f6ddf-gpwff
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Thu, 23 Oct 2025 13:02:42 +0000
Labels:           app=redis
                  pod-template-hash=7c8d4f6ddf
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:           10.244.0.5
Controlled By:  ReplicaSet/redis-deployment-7c8d4f6ddf
Containers:
  redis-container:
    Container ID:   containerd://50ced45c951b6c96a151dd4085810291d3be80f4532d5db039c165bc67843a5e
    Image:          redis:alpine
    Image ID:       docker.io/library/redis@sha256:59b6e694653476de2c992937ebe1c64182af4728e54bb49e9b7a6c26614d8933
    Port:           6379/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 23 Oct 2025 13:02:45 +0000
    Ready:          True
    Restart Count:  0
    Requests:
      cpu:        300m
    Environment:  <none>
    Mounts:
      /redis-master from config (rw)
      /redis-master-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hjwr5 (ro)
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
  kube-api-access-hjwr5:
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
  Normal  Scheduled  2m6s  default-scheduler  Successfully assigned default/redis-deployment-7c8d4f6ddf-gpwff to kodekloud-control-plane
  Normal  Pulling    2m5s  kubelet            Pulling image "redis:alpine"
  Normal  Pulled     2m3s  kubelet            Successfully pulled image "redis:alpine" in 2.526054968s (2.526070426s including waiting)
  Normal  Created    2m3s  kubelet            Created container redis-container
  Normal  Started    2m3s  kubelet            Started container redis-container

```

### Points to Note :

When you use kubectl edit to make changes to a resource (like a Deployment), the changes aren't immediately reflected in the output of kubectl get po.

- ***This is because kubectl get po shows the current state of the Pods, whereas the changes you made with kubectl edit are applied to the Deployment configuration.***

After editing the Deployment, Kubernetes will:

1. Create a new ReplicaSet: With the updated configuration.

2. Scale down the old ReplicaSet: Terminating the old Pods.

3. Create new Pods: With the updated configuration.

So, when you run kubectl get po after editing the Deployment, you might see:

- The old Pod(s) terminating ( STATUS = "Terminating" )
- New Pod(s) being created ( STATUS = "ContainerCreating" or "Running" )

It might take a few seconds for the new Pods to be created and the old Pods to be terminated. Once the rollout is complete, kubectl get po will show the new Pod(s) with the updated configuration.

You can use kubectl rollout status to track the progress of the deployment rollout:


bash

kubectl rollout status deployment redis-deployment


This will show you the status of the rollout, including any errors or warnings.
```




