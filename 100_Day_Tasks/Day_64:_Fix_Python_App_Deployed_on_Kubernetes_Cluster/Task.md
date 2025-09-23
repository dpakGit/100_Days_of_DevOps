### Task : Day 64: Fix Python App Deployed on Kubernetes Cluster
One of the DevOps engineers was trying to deploy a python app on Kubernetes cluster. Unfortunately, due to some mis-configuration, the application is not coming up. Please take a look into it and fix the issues. Application should be accessible on the specified nodePort.

The deployment name is python-deployment-xfusion, its using poroko/flask-demo-appimage. The deployment and service of this app is already deployed.

nodePort should be 32345 and targetPort should be python flask app's default port.

### What I Did

thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
thor@jumphost ~$ kubectl get all
NAME                                             READY   STATUS             RESTARTS   AGE
pod/python-deployment-xfusion-5dcd4fff84-hj7bh   0/1     ImagePullBackOff   0          74s

NAME                             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes               ClusterIP   10.96.0.1      <none>        443/TCP          3m10s
service/python-service-xfusion   NodePort    10.96.48.121   <none>        8080:32345/TCP   74s

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/python-deployment-xfusion   0/1     1            0           74s

NAME                                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/python-deployment-xfusion-5dcd4fff84   1         1         0       74s
thor@jumphost ~$ kubectl get pod
NAME                                         READY   STATUS             RESTARTS   AGE
python-deployment-xfusion-5dcd4fff84-hj7bh   0/1     ImagePullBackOff   0          2m12s
thor@jumphost ~$ kubectl get pod - o wide
Error from server (NotFound): pods "-" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
thor@jumphost ~$ kubectl get pod -o wide
NAME                                         READY   STATUS             RESTARTS   AGE     IP           NODE                      NOMINATED NODE   READINESS GATES
python-deployment-xfusion-5dcd4fff84-hj7bh   0/1     ImagePullBackOff   0          2m38s   10.244.0.5   kodekloud-control-plane   <none>           <none>
thor@jumphost ~$ kubectl describe po
Name:             python-deployment-xfusion-5dcd4fff84-hj7bh
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Tue, 23 Sep 2025 04:44:24 +0000
Labels:           app=python_app
                  pod-template-hash=5dcd4fff84
Annotations:      <none>
Status:           Pending
IP:               10.244.0.5
IPs:
  IP:           10.244.0.5
Controlled By:  ReplicaSet/python-deployment-xfusion-5dcd4fff84
Containers:
  python-container-xfusion:
    Container ID:   
    Image:          poroko/flask-app-demo
    Image ID:       
    Port:           5000/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4qwjs (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-4qwjs:
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
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  3m12s                default-scheduler  Successfully assigned default/python-deployment-xfusion-5dcd4fff84-hj7bh to kodekloud-control-plane
  Normal   Pulling    96s (x4 over 3m12s)  kubelet            Pulling image "poroko/flask-app-demo"
  Warning  Failed     96s (x4 over 3m11s)  kubelet            Failed to pull image "poroko/flask-app-demo": rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/poroko/flask-app-demo:latest": failed to resolve reference "docker.io/poroko/flask-app-demo:latest": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed
  Warning  Failed     96s (x4 over 3m11s)  kubelet            Error: ErrImagePull
  Warning  Failed     85s (x6 over 3m10s)  kubelet            Error: ImagePullBackOff
  Normal   BackOff    71s (x7 over 3m10s)  kubelet            Back-off pulling image "poroko/flask-app-demo"
thor@jumphost ~$ kubectl get deploy
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
python-deployment-xfusion   0/1     1            0           11m
thor@jumphost ~$ kubectl describe deploy python-deployment-xfusion 
Name:                   python-deployment-xfusion
Namespace:              default
CreationTimestamp:      Tue, 23 Sep 2025 04:44:24 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=python_app
Replicas:               1 desired | 1 updated | 1 total | 0 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=python_app
  Containers:
   python-container-xfusion:
    Image:         poroko/flask-app-demo
    Port:          5000/TCP
    Host Port:     0/TCP
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    False   ProgressDeadlineExceeded
OldReplicaSets:  <none>
NewReplicaSet:   python-deployment-xfusion-5dcd4fff84 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  11m   deployment-controller  Scaled up replica set python-deployment-xfusion-5dcd4fff84 to 1
thor@jumphost ~$ kubectl get deployments.apps python-deployment-xfusion -o yaml > python-deployment-xfusion.yaml
thor@jumphost ~$ ls
python-deployment-xfusion.yaml
thor@jumphost ~$ cat python-deployment-xfusion.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"python-deployment-xfusion","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"python_app"}},"template":{"metadata":{"labels":{"app":"python_app"}},"spec":{"containers":[{"image":"poroko/flask-app-demo","name":"python-container-xfusion","ports":[{"containerPort":5000}]}]}}}}
  creationTimestamp: "2025-09-23T04:44:24Z"
  generation: 1
  name: python-deployment-xfusion
  namespace: default
  resourceVersion: "1435"
  uid: 367911f6-796e-485c-adc2-c4b2a2ce7f07
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: python_app
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: python_app
    spec:
      containers:
      - image: poroko/flask-app-demo
        imagePullPolicy: Always
        name: python-container-xfusion
        ports:
        - containerPort: 5000
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  conditions:
  - lastTransitionTime: "2025-09-23T04:44:24Z"
    lastUpdateTime: "2025-09-23T04:44:24Z"
    message: Deployment does not have minimum availability.
    reason: MinimumReplicasUnavailable
    status: "False"
    type: Available
  - lastTransitionTime: "2025-09-23T04:54:25Z"
    lastUpdateTime: "2025-09-23T04:54:25Z"
    message: ReplicaSet "python-deployment-xfusion-5dcd4fff84" has timed out progressing.
    reason: ProgressDeadlineExceeded
    status: "False"
    type: Progressing
  observedGeneration: 1
  replicas: 1
  unavailableReplicas: 1
  updatedReplicas: 1
thor@jumphost ~$ docker pull poroko/flask-app-demo
bash: docker: command not found
thor@jumphost ~$ docker
bash: docker: command not found
thor@jumphost ~$ vi python-deployment-xfusion.yaml 
thor@jumphost ~$ kubectl apply -f python-deployment-xfusion.yaml 
deployment.apps/python-deployment-xfusion configured
thor@jumphost ~$ kubectl get po
NAME                                         READY   STATUS              RESTARTS   AGE
python-deployment-xfusion-5dcd4fff84-hj7bh   0/1     ImagePullBackOff    0          32m
python-deployment-xfusion-74f98d699b-92tk7   0/1     ContainerCreating   0          8s
thor@jumphost ~$ kubectl get po
NAME                                         READY   STATUS    RESTARTS   AGE
python-deployment-xfusion-74f98d699b-92tk7   1/1     Running   0          32s
thor@jumphost ~$ kubectl get deployments.apps python-deployment-xfusion 
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
python-deployment-xfusion   1/1     1            1           33m
thor@jumphost ~$ curl localhost:32345
curl: (7) Failed to connect to localhost port 32345: Connection refused
thor@jumphost ~$ kubectl get nodes -o wide
NAME                      STATUS   ROLES           AGE   VERSION                     INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
kodekloud-control-plane   Ready    control-plane   38m   v1.27.16-1+f5da3b717fc217   172.17.0.2    <none>        Ubuntu 23.10   5.4.0-1106-gcp   containerd://1.7.1-2-g8f682ed69
thor@jumphost ~$ curl http://172.17.0.2:32345
^C
thor@jumphost ~$ kubectl get svc
NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes               ClusterIP   10.96.0.1      <none>        443/TCP          39m
python-service-xfusion   NodePort    10.96.48.121   <none>        8080:32345/TCP   37m
thor@jumphost ~$ kubectl get svc -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Service
  metadata:
    creationTimestamp: "2025-09-23T04:42:28Z"
    labels:
      component: apiserver
      provider: kubernetes
    name: kubernetes
    namespace: default
    resourceVersion: "227"
    uid: 28e2589b-34ad-4fc2-932d-d9ea9aa0a93b
  spec:
    clusterIP: 10.96.0.1
    clusterIPs:
    - 10.96.0.1
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - name: https
      port: 443
      protocol: TCP
      targetPort: 6443
    sessionAffinity: None
    type: ClusterIP
  status:
    loadBalancer: {}
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"python-service-xfusion","namespace":"default"},"spec":{"ports":[{"nodePort":32345,"port":8080}],"selector":{"app":"python_app"},"type":"NodePort"}}
    creationTimestamp: "2025-09-23T04:44:24Z"
    name: python-service-xfusion
    namespace: default
    resourceVersion: "602"
    uid: c3f067d4-9110-48db-9d99-2d4e3207d719
  spec:
    clusterIP: 10.96.48.121
    clusterIPs:
    - 10.96.48.121
    externalTrafficPolicy: Cluster
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - nodePort: 32345
      port: 8080
      protocol: TCP
      targetPort: 8080
    selector:
      app: python_app
    sessionAffinity: None
    type: NodePort
  status:
    loadBalancer: {}
kind: List
metadata:
  resourceVersion: ""
thor@jumphost ~$ ls
python-deployment-xfusion.yaml
thor@jumphost ~$ kubectl get svc -o yaml > python-service-xfusion.yaml 
thor@jumphost ~$ ls
python-deployment-xfusion.yaml  python-service-xfusion.yaml
thor@jumphost ~$ vi python-service-xfusion.yaml 
thor@jumphost ~$ kubectl apply -f python-service-xfusion.yaml 
Warning: resource services/kubernetes is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
service/kubernetes configured
service/python-service-xfusion configured
thor@jumphost ~$ curl http://172.17.0.2:32345
^[[A^[[A^[[A^C
thor@jumphost ~$ 
thor@jumphost ~$ curl localhost:32345
curl: (7) Failed to connect to localhost port 32345: Connection refused
thor@jumphost ~$ curl 172.17.0.2:32345
^C
thor@jumphost ~$ history | cut -c 8-
pwd
ls
kubectl get all
kubectl get pod
kubectl get pod - o wide
kubectl get pod -o wide
kubectl describe po
kubectl get deploy
kubectl describe deploy python-deployment-xfusion 
kubectl get deployments.apps python-deployment-xfusion -o yaml > python-deployment-xfusion.yaml
ls
cat python-deployment-xfusion.yaml 
docker pull poroko/flask-app-demo
docker
vi python-deployment-xfusion.yaml 
kubectl apply -f python-deployment-xfusion.yaml 
kubectl get po
kubectl get deployments.apps python-deployment-xfusion 
curl localhost:32345
kubectl get nodes -o wide
curl http://172.17.0.2:32345
kubectl get svc
kubectl get svc -o yaml
ls
kubectl get svc -o yaml > python-service-xfusion.yaml 
ls
vi python-service-xfusion.yaml 
kubectl apply -f python-service-xfusion.yaml 
curl http://172.17.0.2:32345
curl localhost:32345
curl 172.17.0.2:32345
history | cut -c 8-
thor@jumphost ~$ ls
python-deployment-xfusion.yaml  python-service-xfusion.yaml
thor@jumphost ~$ cat python-deployment-xfusion.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"python-deployment-xfusion","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"python_app"}},"template":{"metadata":{"labels":{"app":"python_app"}},"spec":{"containers":[{"image":"poroko/flask-app-demo","name":"python-container-xfusion","ports":[{"containerPort":5000}]}]}}}}
  creationTimestamp: "2025-09-23T04:44:24Z"
  generation: 1
  name: python-deployment-xfusion
  namespace: default
  resourceVersion: "1435"
  uid: 367911f6-796e-485c-adc2-c4b2a2ce7f07
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: python_app
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: python_app
    spec:
      containers:
      - image: poroko/flask-demo-app
        imagePullPolicy: Always
        name: python-container-xfusion
        ports:
        - containerPort: 5000
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  conditions:
  - lastTransitionTime: "2025-09-23T04:44:24Z"
    lastUpdateTime: "2025-09-23T04:44:24Z"
    message: Deployment does not have minimum availability.
    reason: MinimumReplicasUnavailable
    status: "False"
    type: Available
  - lastTransitionTime: "2025-09-23T04:54:25Z"
    lastUpdateTime: "2025-09-23T04:54:25Z"
    message: ReplicaSet "python-deployment-xfusion-5dcd4fff84" has timed out progressing.
    reason: ProgressDeadlineExceeded
    status: "False"
    type: Progressing
  observedGeneration: 1
  replicas: 1
  unavailableReplicas: 1
  updatedReplicas: 1
thor@jumphost ~$ cat python-service-xfusion.yaml 
apiVersion: v1
items:
- apiVersion: v1
  kind: Service
  metadata:
    creationTimestamp: "2025-09-23T04:42:28Z"
    labels:
      component: apiserver
      provider: kubernetes
    name: kubernetes
    namespace: default
    resourceVersion: "227"
    uid: 28e2589b-34ad-4fc2-932d-d9ea9aa0a93b
  spec:
    clusterIP: 10.96.0.1
    clusterIPs:
    - 10.96.0.1
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - name: https
      port: 443
      protocol: TCP
      targetPort: 6443
    sessionAffinity: None
    type: ClusterIP
  status:
    loadBalancer: {}
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"python-service-xfusion","namespace":"default"},"spec":{"ports":[{"nodePort":32345,"port":8080}],"selector":{"app":"python_app"},"type":"NodePort"}}
    creationTimestamp: "2025-09-23T04:44:24Z"
    name: python-service-xfusion
    namespace: default
    resourceVersion: "602"
    uid: c3f067d4-9110-48db-9d99-2d4e3207d719
  spec:
    clusterIP: 10.96.48.121
    clusterIPs:
    - 10.96.48.121
    externalTrafficPolicy: Cluster
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - nodePort: 32345
      port: 8080
      protocol: TCP
      targetPort: 5000
    selector:
      app: python_app
    sessionAffinity: None
    type: NodePort
  status:
    loadBalancer: {}
kind: List
metadata:
  resourceVersion: ""
thor@jumphost ~$ ls
python-deployment-xfusion.yaml  python-service-xfusion.yaml
thor@jumphost ~$ 
