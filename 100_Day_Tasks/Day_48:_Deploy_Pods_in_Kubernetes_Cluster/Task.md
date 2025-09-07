
thor@jumphost ~$ ls
thor@jumphost ~$ ls -alh
total 72K
drwxr----- 1 thor thor 4.0K Sep  7 05:00 .
drwxr-xr-x 1 root root 4.0K Jun  7  2024 ..
-rwxrwx--- 1 thor thor   18 Feb 15  2024 .bash_logout
-rwxrwx--- 1 thor thor  141 Feb 15  2024 .bash_profile
-rwxrwx--- 1 thor thor  884 Sep  7 05:00 .bashrc
-rwxrwx--- 1 thor thor  37K Apr  5  2024 .complete_alias
drwxrwx--- 1 thor thor 4.0K Jun  7  2024 .config
drwxrwx--- 2 thor thor 4.0K Sep  7 05:00 .kube
drwxr----- 2 thor thor 4.0K Sep  7 05:00 .ssh
thor@jumphost ~$ kubectl
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes
  events          List events

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh, fish, or powershell)

Subcommands provided by plugins:

Other Commands:
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
thor@jumphost ~$ kubectl get pods
No resources found in default namespace.
thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27m
thor@jumphost ~$ docker images
bash: docker: command not found
thor@jumphost ~$ docker ps -a
bash: docker: command not found
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
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"app":"httpd_app"},"name":"pod-httpd","namespace":"default"},"spec":{"containers":[{"image":"httpd:latest","name":"httpd-container"}]}}
  creationTimestamp: "2025-09-07T05:23:32Z"
  labels:
    app: httpd_app
  name: pod-httpd
  namespace: default
  resourceVersion: "3906"
  uid: 8de28bc0-25eb-4d7e-8fd0-336cc164a004
spec:
  containers:
  - image: httpd:latest
    imagePullPolicy: Always
    name: httpd-container
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-cnmsf
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: kodekloud-control-plane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-cnmsf
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2025-09-07T05:23:32Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2025-09-07T05:23:38Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2025-09-07T05:23:38Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2025-09-07T05:23:32Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://f2d17e32b606b754f9033340b1f73b3f54b8756f463c5ceca62e7bf727464fc9
    image: docker.io/library/httpd:latest
    imageID: docker.io/library/httpd@sha256:3198c1839e1a875f8b83803083758a7635f1ae999f0601f30f2f3b8ce2ac99e3
    lastState: {}
    name: httpd-container
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2025-09-07T05:23:38Z"
  hostIP: 172.17.0.2
  phase: Running
  podIP: 10.244.0.5
  podIPs:
  - ip: 10.244.0.5
  qosClass: BestEff
