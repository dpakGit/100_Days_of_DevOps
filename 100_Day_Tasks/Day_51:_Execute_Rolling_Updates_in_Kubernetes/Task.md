thor@jumphost ~$ kubectl get all
NAME                                   READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-989f57c54-btxrt   1/1     Running   0          27m
pod/nginx-deployment-989f57c54-fkwqf   1/1     Running   0          27m
pod/nginx-deployment-989f57c54-g6qnx   1/1     Running   0          27m

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        44m
service/nginx-service   NodePort    10.96.71.229   <none>        80:30008/TCP   27m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           27m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-989f57c54   3         3         3       27m

thor@jumphost ~$ kubectl get deploy nginx-deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           28m

thor@jumphost ~$ kubectl get deploy nginx-deployment -o wide # This command will output the container name and the current image.
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3     3            3           28m   nginx-container   nginx:1.16   app=nginx-app
thor@jumphost ~$ kubectl describe deploy nginx-deployment 
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Wed, 10 Sep 2025 04:02:05 +0000
Labels:                 app=nginx-app
                        type=front-end
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:         nginx:1.16
    Port:          <none>
    Host Port:     <none>
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-989f57c54 (3/3 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  29m   deployment-controller  Scaled up replica set nginx-deployment-989f57c54 to 3
thor@jumphost ~$ ls
thor@jumphost ~$ # command to see the YAML file of the deployment      
thor@jumphost ~$ kubectl get deployment nginx-deployment -o yaml # This command will display the deployment's configuration in YAML format
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"nginx-app","type":"front-end"},"name":"nginx-deployment","namespace":"default"},"spec":{"replicas":3,"selector":{"matchLabels":{"app":"nginx-app"}},"strategy":{"type":"RollingUpdate"},"template":{"metadata":{"labels":{"app":"nginx-app"},"name":"nginx-replica"},"spec":{"containers":[{"image":"nginx:1.16","name":"nginx-container"}]}}}}
  creationTimestamp: "2025-09-10T04:02:05Z"
  generation: 1
  labels:
    app: nginx-app
    type: front-end
  name: nginx-deployment
  namespace: default
  resourceVersion: "1839"
  uid: f3032bae-26fd-4b4d-a2bd-deac80b73ab4
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-app
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-app
      name: nginx-replica
    spec:
      containers:
      - image: nginx:1.16
        imagePullPolicy: IfNotPresent
        name: nginx-container
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 3
  conditions:
  - lastTransitionTime: "2025-09-10T04:02:13Z"
    lastUpdateTime: "2025-09-10T04:02:13Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2025-09-10T04:02:05Z"
    lastUpdateTime: "2025-09-10T04:02:13Z"
    message: ReplicaSet "nginx-deployment-989f57c54" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 3
  replicas: 3
  updatedReplicas: 3
thor@jumphost ~$ kubectl get deploy nginx-deployment -o wideNAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3     3            3           32m   nginx-container   nginx:1.16   app=nginx-app
thor@jumphost ~$ kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 --recordFlag --record has been deprecated, --record will be removed in the future
deployment.apps/nginx-deployment image updated
thor@jumphost ~$ # To verify if the image update was successfully implemented
thor@jumphost ~$ kubectl get deployment nginx-deployment -o wid
error: unable to match a printer suitable for the output format "wid", allowed formats are: custom-columns,custom-columns-file,go-template,go-template-file,json,jsonpath,jsonpath-as-json,jsonpath-file,name,template,templatefile,wide,yaml
thor@jumphost ~$ kubectl get deployment nginx-deployment -o wide
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3     3            3           41m   nginx-container   nginx:1.19   app=nginx-app
thor@jumphost ~$ kubectl describe deployment nginx-deployment 
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Wed, 10 Sep 2025 04:02:05 +0000
Labels:                 app=nginx-app
                        type=front-end
Annotations:            deployment.kubernetes.io/revision: 2
                        kubernetes.io/change-cause: kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 --record=true
Selector:               app=nginx-app
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-app
  Containers:
   nginx-container:
    Image:         nginx:1.19
    Port:          <none>
    Host Port:     <none>
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  nginx-deployment-989f57c54 (0/0 replicas created)
NewReplicaSet:   nginx-deployment-dc49f85cc (3/3 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  41m    deployment-controller  Scaled up replica set nginx-deployment-989f57c54 to 3
  Normal  ScalingReplicaSet  2m39s  deployment-controller  Scaled up replica set nginx-deployment-dc49f85cc to 1
  Normal  ScalingReplicaSet  2m33s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 2 from 3
  Normal  ScalingReplicaSet  2m33s  deployment-controller  Scaled up replica set nginx-deployment-dc49f85cc to 2 from 1
  Normal  ScalingReplicaSet  2m31s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 1 from 2
  Normal  ScalingReplicaSet  2m31s  deployment-controller  Scaled up replica set nginx-deployment-dc49f85cc to 3 from 2
  Normal  ScalingReplicaSet  2m29s  deployment-controller  Scaled down replica set nginx-deployment-989f57c54 to 0 from 1
thor@jumphost ~$ kubectl describe deployment nginx-deployment -o wide
error: unknown shorthand flag: 'o' in -o
See 'kubectl describe --help' for usage.
thor@jumphost ~$ # To monitor the rollout status
thor@jumphost ~$ kubectl rollout status deployment nginx-deployment
deployment "nginx-deployment" successfully rolled out
thor@jumphost ~$ kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].image}'
nginx:1.19thor@jumphost ~$ 
thor@jumphost ~$ kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].image}'
thor@jumphost ~$ history | cut -c 8-
kubectl get all
kubectl describe deployment  nginx-deployment
kubectl get deployment <deployment-name> -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl describe deployment  nginx-deployment
kubectl describe deployment  nginx-deployment -o
kubectl get deployment <deployment-name> -o jsonpath='{.spec.template.spec.containers[*].image}'
kubectl get deployment nginx-deployment  -o jsonpath='{.spec.template.spec.containers[*].image}'
kubectl get deploy nginx-deployment 
kubectl get deploy nginx-deployment -o wide
kubectl rollout history deployment nginx-deployment
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubectl get all
kubectl get deploy nginx-deployment
kubectl get deploy nginx-deployment -o wide
kubectl describe deploy nginx-deployment 
ls
# command to see the YAML file of the deployment
kubectl get deployment nginx-deployment -o yaml # This command will display the deployment's configuration in YAML format
kubectl get deploy nginx-deployment -o wide
kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 --record
# To verify if the image update was successfully implemented
kubectl get deployment nginx-deployment -o wid
kubectl get deployment nginx-deployment -o wide
kubectl describe deployment nginx-deployment 
kubectl describe deployment nginx-deployment -o wide
# To monitor the rollout status
kubectl rollout status deployment nginx-deployment
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].image}'
history | cut -c 8-
thor@jumphost ~$ 
