### Task : Day 61: Init Containers in Kubernetes

There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.

Create a Deployment named as ic-deploy-datacenter.

Configure spec as replicas should be 1, labels app should be ic-datacenter, template's metadata lables app should be the same ic-datacenter.

The initContainers should be named as ic-msg-datacenter, use image fedora with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/news'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic.

Main container should be named as ic-main-datacenter, use image fedora with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/news; sleep 5; done'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic.

Volume to be named as ic-volume-datacenter and it should be an emptyDir type.


### Here's a pointwise explanation of the task:

#### Task Overview

- Deploy an application on a Kubernetes cluster using a Deployment.
- The application has some pre-requisites that need to be fulfilled before deploying the main application container.
- Use init containers to perform these pre-requisites.

Step-by-Step Requirements

1. Create a Deployment
    - Name: ic-deploy-datacenter
2. Configure Deployment Spec
    - Replicas: 1 (i.e., one copy of the application)
    - Labels:
        - app: ic-datacenter
    - Template's metadata labels:
        - app: ic-datacenter (same as above)
3. Init Container
    - Name: ic-msg-datacenter
    - Image: fedora:latest
    - Command:
        - /bin/bash
        - -c
        - echo Init Done - Welcome to xFusionCorp Industries > /ic/news
    - Volume Mount:
        - Name: ic-volume-datacenter
        - Mount Path: /ic
4. Main Container
    - Name: ic-main-datacenter
    - Image: fedora:latest
    - Command:
        - /bin/bash
        - -c
        - while true; do cat /ic/news; sleep 5; done
    - Volume Mount:
        - Name: ic-volume-datacenter
        - Mount Path: /ic
5. Volume
    - Name: ic-volume-datacenter
    - Type: emptyDir

What to Do

- Create a YAML file that defines the Deployment with the above specifications.
- Use the kubectl apply command to apply the YAML file and create the Deployment.
- Verify that the Deployment, init container, and main container are running as expected.
- Check the logs of the main container to see the output of the init container.

Purpose of Init Container

- The init container writes a message to a file /ic/news before the main container starts.
- The main container reads and displays the message every 5 seconds.

Purpose of Volume

- The volume is used to share data between the init container and the main container.
- The init container writes to the volume, and the main container reads from it.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor

thor@jumphost ~$ ls

thor@jumphost ~$ vi deployment.yaml 

thor@jumphost ~$ kubectl apply -f deployment.yaml 
deployment.apps/ic-deploy-datacenter created

thor@jumphost ~$ kubectl get deployments.apps 
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
ic-deploy-datacenter   1/1     1            1           11s

thor@jumphost ~$ kubectl get pods


# Run the following command to check the logs of the main container

thor@jumphost ~$ kubectl logs -f <pod-name> -c ic-main-datacenter
 


thor@jumphost ~$ kubectl get deployments.apps ic-deploy-datacenter 
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
ic-deploy-datacenter   1/1     1            1           3m3s


thor@jumphost ~$ kubectl get deployments.apps -o wide
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS           IMAGES          SELECTOR
ic-deploy-datacenter   1/1     1            1           23s   ic-main-datacenter   fedora:latest   app=ic-datacenter

thor@jumphost ~$ kubectl get deployments.apps ic-deploy-datacenter -o wide
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS           IMAGES          SELECTOR
ic-deploy-datacenter   1/1     1            1           3m10s   ic-main-datacenter   fedora:latest   app=ic-datacenter


thor@jumphost ~$ kubectl get all # This command gives all details of the deployment
NAME                                        READY   STATUS    RESTARTS   AGE
pod/ic-deploy-datacenter-768fc4859c-s8b56   1/1     Running   0          59s     

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   28m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ic-deploy-datacenter   1/1     1            1           59s     

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/ic-deploy-datacenter-768fc4859c   1         1         1       59s


thor@jumphost ~$ kubectl describe deployments.apps ic-deploy-datacenterName:                   ic-deploy-datacenter
Namespace:              default
CreationTimestamp:      Sat, 20 Sep 2025 12:18:47 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=ic-datacenter
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=ic-datacenter
  Init Containers:
   ic-msg-datacenter:
    Image:      fedora:latest
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
    Args:
      echo "Init Done - Welcome to xFusionCorp Industries" > /ic/news
    Environment:  <none>
    Mounts:
      /ic from ic-volume-datacenter (rw)
  Containers:
   ic-main-datacenter:
    Image:      fedora:latest
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/bash
      -c
    Args:
      while true; do cat /ic/news; sleep 5; done
    Environment:  <none>
    Mounts:
      /ic from ic-volume-datacenter (rw)
  Volumes:
   ic-volume-datacenter:
    Type:          EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:        
    SizeLimit:     <unset>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   ic-deploy-datacenter-768fc4859c (1/1 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  3m45s  deployment-controller  Scaled up replica set ic-deploy-datacenter-768fc4859c to 1


thor@jumphost ~$ kubectl get deployments,replicasets,pods
NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ic-deploy-datacenter   1/1     1            1           4m9s

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/ic-deploy-datacenter-768fc4859c   1         1         1       4m9s

NAME                                        READY   STATUS    RESTARTS   AGE
pod/ic-deploy-datacenter-768fc4859c-s8b56   1/1     Running   0          4m9s
```

### # deployment.yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-datacenter
  template:
    metadata:
      labels:
        app: ic-datacenter
    spec:
      containers:
      - name: ic-main-datacenter
        image: fedora:latest
        command: ['/bin/bash', '-c']
        args:
        - while true; do cat /ic/news; sleep 5; done
        volumeMounts:
        - name: ic-volume-datacenter
          mountPath: /ic
      initContainers:
      - name: ic-msg-datacenter
        image: fedora:latest
        command: ['/bin/bash', '-c']
        args:
        - echo "Init Done - Welcome to xFusionCorp Industries" > /ic/news
        volumeMounts:
        - name: ic-volume-datacenter
          mountPath: /ic
      volumes:
      - name: ic-volume-datacenter
        emptyDir: {}
```


```
    1  pwd
    2  ls
    3  kubectl get all
    4  vi deployment.yaml 
    5  kubectl -f deployment.yaml 
    6  kubectl apply -f deployment.yaml 
    7  kubectl get deployments.apps 
    8  kubectl get deployments.apps -o wide
    9  kubectl get all
   10  kubectl get deployments.apps ic-deploy-datacenter 
   11  kubectl get deployments.apps ic-deploy-datacenter -o wide
   12  kubectl describe deployments.apps ic-deploy-datacenter -o wide
   13  kubectl describe deployments.apps ic-deploy-datacenter
   14  kubectl get deployments,replicasets,pods
   15  kubectl get deployments,replicasets,pods -l app=ic-datacenter
   16  kubectl get deployments,replicasets,pods --all-namespaces 
  ```
