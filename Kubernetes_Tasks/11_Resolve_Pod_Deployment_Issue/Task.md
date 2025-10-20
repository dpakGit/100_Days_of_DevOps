### Task : Resolve Pod Deployment Issue

A junior DevOps team member encountered difficulties deploying a stack on the Kubernetes cluster. The pod fails to start, presenting errors. Let's troubleshoot and rectify the issue promptly.

There is a pod named webserver, and the container within it is named httpd-container, its utilizing the httpd:latest image.

Additionally, there's a sidecar container named sidecar-container using the ubuntu:latest image.

Identify and address the issue to ensure the pod is in the running state and the application is accessible.

### What I Did

```
thor@jumphost ~$ kubectl get po
NAME        READY   STATUS             RESTARTS   AGE
webserver   1/2     ImagePullBackOff   0          27s
thor@jumphost ~$ kubectl get po -o wide
NAME        READY   STATUS         RESTARTS   AGE   IP           NODE                      NOMINATED NODE   READINESS GATES
webserver   1/2     ErrImagePull   0          36s   10.244.0.5   kodekloud-control-plane   <none>           <none>
thor@jumphost ~$ kubectl describe po
Name:             webserver
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Mon, 20 Oct 2025 06:27:37 +0000
Labels:           app=web-app
Annotations:      <none>
Status:           Pending
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  httpd-container:
    Container ID:   
    Image:          httpd:latests
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
  sidecar-container:
    Container ID:  containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2
    Image:         ubuntu:latest
    Image ID:      docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done
    State:          Running
      Started:      Mon, 20 Oct 2025 06:27:41 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  shared-logs:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-gdds9:
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
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  89s                default-scheduler  Successfully assigned default/webserver to kodekloud-control-plane
  Normal   Pulling    88s                kubelet            Pulling image "ubuntu:latest"
  Normal   Pulled     85s                kubelet            Successfully pulled image "ubuntu:latest" in 3.256489785s (3.256505989s including waiting)
  Normal   Created    85s                kubelet            Created container sidecar-container
  Normal   Started    85s                kubelet            Started container sidecar-container
  Normal   Pulling    46s (x3 over 89s)  kubelet            Pulling image "httpd:latests"
  Warning  Failed     46s (x3 over 88s)  kubelet            Failed to pull image "httpd:latests": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/httpd:latests": failed to resolve reference "docker.io/library/httpd:latests": docker.io/library/httpd:latests: not found
  Warning  Failed     46s (x3 over 88s)  kubelet            Error: ErrImagePull
  Normal   BackOff    7s (x6 over 84s)   kubelet            Back-off pulling image "httpd:latests"
  Warning  Failed     7s (x6 over 84s)   kubelet            Error: ImagePullBackOff
thor@jumphost ~$ ls
thor@jumphost ~$ ^C
thor@jumphost ~$ kubectl get po -o yaml > pods.yaml
thor@jumphost ~$ ls
pods.yaml
thor@jumphost ~$ vi pods.yaml 
thor@jumphost ~$ kubectl apply -f pods.yaml 
Error from server (Conflict): error when applying patch:
{"metadata":{"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"creationTimestamp\":\"2025-10-20T06:27:37Z\",\"labels\":{\"app\":\"web-app\"},\"name\":\"webserver\",\"namespace\":\"default\",\"resourceVersion\":\"1142\",\"uid\":\"ec102bfd-7a9a-4d54-a9b2-14f99cf11aaf\"},\"spec\":{\"containers\":[{\"image\":\"httpd:latests\",\"imagePullPolicy\":\"IfNotPresent\",\"name\":\"httpd-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]},{\"command\":[\"sh\",\"-c\",\"while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done\"],\"image\":\"ubuntu:latest\",\"imagePullPolicy\":\"Always\",\"name\":\"sidecar-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]}],\"dnsPolicy\":\"ClusterFirst\",\"enableServiceLinks\":true,\"nodeName\":\"kodekloud-control-plane\",\"preemptionPolicy\":\"PreemptLowerPriority\",\"priority\":0,\"restartPolicy\":\"Always\",\"schedulerName\":\"default-scheduler\",\"securityContext\":{},\"serviceAccount\":\"default\",\"serviceAccountName\":\"default\",\"terminationGracePeriodSeconds\":30,\"tolerations\":[{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/not-ready\",\"operator\":\"Exists\",\"tolerationSeconds\":300},{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/unreachable\",\"operator\":\"Exists\",\"tolerationSeconds\":300}],\"volumes\":[{\"emptyDir\":{},\"name\":\"shared-logs\"},{\"name\":\"kube-api-access-gdds9\",\"projected\":{\"defaultMode\":420,\"sources\":[{\"serviceAccountToken\":{\"expirationSeconds\":3607,\"path\":\"token\"}},{\"configMap\":{\"items\":[{\"key\":\"ca.crt\",\"path\":\"ca.crt\"}],\"name\":\"kube-root-ca.crt\"}},{\"downwardAPI\":{\"items\":[{\"fieldRef\":{\"apiVersion\":\"v1\",\"fieldPath\":\"metadata.namespace\"},\"path\":\"namespace\"}]}}]}}]},\"status\":{\"conditions\":[{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"Initialized\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"Ready\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"ContainersReady\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"PodScheduled\"}],\"containerStatuses\":[{\"image\":\"httpd:latest\",\"imageID\":\"\",\"lastState\":{},\"name\":\"httpd-container\",\"ready\":false,\"restartCount\":0,\"started\":false,\"state\":{\"waiting\":{\"message\":\"Back-off pulling image \\\"httpd:latests\\\"\",\"reason\":\"ImagePullBackOff\"}}},{\"containerID\":\"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2\",\"image\":\"docker.io/library/ubuntu:latest\",\"imageID\":\"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252\",\"lastState\":{},\"name\":\"sidecar-container\",\"ready\":true,\"restartCount\":0,\"started\":true,\"state\":{\"running\":{\"startedAt\":\"2025-10-20T06:27:41Z\"}}}],\"hostIP\":\"172.17.0.2\",\"phase\":\"Pending\",\"podIP\":\"10.244.0.5\",\"podIPs\":[{\"ip\":\"10.244.0.5\"}],\"qosClass\":\"BestEffort\",\"startTime\":\"2025-10-20T06:27:37Z\"}}\n"},"resourceVersion":"1142"},"status":{"containerStatuses":[{"image":"httpd:latest","imageID":"","lastState":{},"name":"httpd-container","ready":false,"restartCount":0,"started":false,"state":{"waiting":{"message":"Back-off pulling image \"httpd:latests\"","reason":"ImagePullBackOff"}}},{"containerID":"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2","image":"docker.io/library/ubuntu:latest","imageID":"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252","lastState":{},"name":"sidecar-container","ready":true,"restartCount":0,"started":true,"state":{"running":{"startedAt":"2025-10-20T06:27:41Z"}}}]}}
to:
Resource: "/v1, Resource=pods", GroupVersionKind: "/v1, Kind=Pod"
Name: "webserver", Namespace: "default"
for: "pods.yaml": error when patching "pods.yaml": Operation cannot be fulfilled on pods "webserver": the object has been modified; please apply your changes to the latest version and try again
thor@jumphost ~$ kubectl delete pod webserver
pod "webserver" deleted



^Cthor@jumphost ~$ kubectl get po
NAME        READY   STATUS        RESTARTS   AGE
webserver   1/2     Terminating   0          8m46s
thor@jumphost ~$ kubectl get po
No resources found in default namespace.
thor@jumphost ~$ kubectl apply -f pods.yaml 
pod/webserver created
thor@jumphost ~$ kubectl get po
NAME        READY   STATUS             RESTARTS   AGE
webserver   1/2     ImagePullBackOff   0          4s
thor@jumphost ~$ kubectl get po
NAME        READY   STATUS             RESTARTS   AGE
webserver   1/2     ImagePullBackOff   0          14s
thor@jumphost ~$ kubectl describe po
Name:             webserver
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Mon, 20 Oct 2025 06:36:36 +0000
Labels:           app=web-app
Annotations:      <none>
Status:           Pending
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  httpd-container:
    Container ID:   
    Image:          httpd:latests
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
  sidecar-container:
    Container ID:  containerd://b24de38edc1a421940f81cbbf2b8967cef662dc6d41a01fa01d9914cdc10377f
    Image:         ubuntu:latest
    Image ID:      docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done
    State:          Running
      Started:      Mon, 20 Oct 2025 06:36:37 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  shared-logs:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-gdds9:
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
  Type     Reason   Age                From     Message
  ----     ------   ----               ----     -------
  Normal   Pulling  25s                kubelet  Pulling image "ubuntu:latest"
  Normal   Pulled   25s                kubelet  Successfully pulled image "ubuntu:latest" in 145.948049ms (145.967289ms including waiting)
  Normal   Created  25s                kubelet  Created container sidecar-container
  Normal   Started  25s                kubelet  Started container sidecar-container
  Normal   BackOff  23s (x2 over 24s)  kubelet  Back-off pulling image "httpd:latests"
  Warning  Failed   23s (x2 over 24s)  kubelet  Error: ImagePullBackOff
  Normal   Pulling  7s (x2 over 26s)   kubelet  Pulling image "httpd:latests"
  Warning  Failed   7s (x2 over 25s)   kubelet  Failed to pull image "httpd:latests": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/httpd:latests": failed to resolve reference "docker.io/library/httpd:latests": docker.io/library/httpd:latests: not found
  Warning  Failed   7s (x2 over 25s)   kubelet  Error: ErrImagePull
thor@jumphost ~$ vi pods.yaml 
thor@jumphost ~$ kubectl apply -f pods.yaml 
Error from server (Conflict): error when applying patch:
{"metadata":{"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"creationTimestamp\":\"2025-10-20T06:27:37Z\",\"labels\":{\"app\":\"web-app\"},\"name\":\"webserver\",\"namespace\":\"default\",\"resourceVersion\":\"1142\",\"uid\":\"ec102bfd-7a9a-4d54-a9b2-14f99cf11aaf\"},\"spec\":{\"containers\":[{\"image\":\"httpd:latest\",\"imagePullPolicy\":\"IfNotPresent\",\"name\":\"httpd-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]},{\"command\":[\"sh\",\"-c\",\"while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done\"],\"image\":\"ubuntu:latest\",\"imagePullPolicy\":\"Always\",\"name\":\"sidecar-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]}],\"dnsPolicy\":\"ClusterFirst\",\"enableServiceLinks\":true,\"nodeName\":\"kodekloud-control-plane\",\"preemptionPolicy\":\"PreemptLowerPriority\",\"priority\":0,\"restartPolicy\":\"Always\",\"schedulerName\":\"default-scheduler\",\"securityContext\":{},\"serviceAccount\":\"default\",\"serviceAccountName\":\"default\",\"terminationGracePeriodSeconds\":30,\"tolerations\":[{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/not-ready\",\"operator\":\"Exists\",\"tolerationSeconds\":300},{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/unreachable\",\"operator\":\"Exists\",\"tolerationSeconds\":300}],\"volumes\":[{\"emptyDir\":{},\"name\":\"shared-logs\"},{\"name\":\"kube-api-access-gdds9\",\"projected\":{\"defaultMode\":420,\"sources\":[{\"serviceAccountToken\":{\"expirationSeconds\":3607,\"path\":\"token\"}},{\"configMap\":{\"items\":[{\"key\":\"ca.crt\",\"path\":\"ca.crt\"}],\"name\":\"kube-root-ca.crt\"}},{\"downwardAPI\":{\"items\":[{\"fieldRef\":{\"apiVersion\":\"v1\",\"fieldPath\":\"metadata.namespace\"},\"path\":\"namespace\"}]}}]}}]},\"status\":{\"conditions\":[{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"Initialized\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"Ready\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"ContainersReady\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"PodScheduled\"}],\"containerStatuses\":[{\"image\":\"httpd:latest\",\"imageID\":\"\",\"lastState\":{},\"name\":\"httpd-container\",\"ready\":false,\"restartCount\":0,\"started\":false,\"state\":{\"waiting\":{\"message\":\"Back-off pulling image \\\"httpd:latests\\\"\",\"reason\":\"ImagePullBackOff\"}}},{\"containerID\":\"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2\",\"image\":\"docker.io/library/ubuntu:latest\",\"imageID\":\"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252\",\"lastState\":{},\"name\":\"sidecar-container\",\"ready\":true,\"restartCount\":0,\"started\":true,\"state\":{\"running\":{\"startedAt\":\"2025-10-20T06:27:41Z\"}}}],\"hostIP\":\"172.17.0.2\",\"phase\":\"Pending\",\"podIP\":\"10.244.0.5\",\"podIPs\":[{\"ip\":\"10.244.0.5\"}],\"qosClass\":\"BestEffort\",\"startTime\":\"2025-10-20T06:27:37Z\"}}\n"},"creationTimestamp":"2025-10-20T06:27:37Z","resourceVersion":"1142","uid":"ec102bfd-7a9a-4d54-a9b2-14f99cf11aaf"},"spec":{"$setElementOrder/containers":[{"name":"httpd-container"},{"name":"sidecar-container"}],"containers":[{"image":"httpd:latest","name":"httpd-container"}]},"status":{"$setElementOrder/conditions":[{"type":"Initialized"},{"type":"Ready"},{"type":"ContainersReady"},{"type":"PodScheduled"}],"$setElementOrder/podIPs":[{"ip":"10.244.0.5"}],"conditions":[{"lastTransitionTime":"2025-10-20T06:27:37Z","type":"Initialized"},{"lastTransitionTime":"2025-10-20T06:27:37Z","type":"Ready"},{"lastTransitionTime":"2025-10-20T06:27:37Z","type":"ContainersReady"},{"lastTransitionTime":"2025-10-20T06:27:37Z","type":"PodScheduled"}],"containerStatuses":[{"image":"httpd:latest","imageID":"","lastState":{},"name":"httpd-container","ready":false,"restartCount":0,"started":false,"state":{"waiting":{"message":"Back-off pulling image \"httpd:latests\"","reason":"ImagePullBackOff"}}},{"containerID":"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2","image":"docker.io/library/ubuntu:latest","imageID":"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252","lastState":{},"name":"sidecar-container","ready":true,"restartCount":0,"started":true,"state":{"running":{"startedAt":"2025-10-20T06:27:41Z"}}}],"podIP":"10.244.0.5","podIPs":[{"ip":"10.244.0.5"}],"startTime":"2025-10-20T06:27:37Z"}}
to:
Resource: "/v1, Resource=pods", GroupVersionKind: "/v1, Kind=Pod"
Name: "webserver", Namespace: "default"
for: "pods.yaml": error when patching "pods.yaml": Operation cannot be fulfilled on pods "webserver": the object has been modified; please apply your changes to the latest version and try again
thor@jumphost ~$ kubectl get all
NAME            READY   STATUS             RESTARTS   AGE
pod/webserver   1/2     ImagePullBackOff   0          2m45s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        16m
service/nginx-service   NodePort    10.96.31.170   <none>        80:30008/TCP   11m
thor@jumphost ~$ kubectl delete pod webserver
pod "webserver" deleted
thor@jumphost ~$ kubectl get po
No resources found in default namespace.
thor@jumphost ~$ kubectl apply -f pods.yaml 
pod/webserver created
thor@jumphost ~$ kubectl get po
NAME        READY   STATUS              RESTARTS   AGE
webserver   0/2     ContainerCreating   0          4s
thor@jumphost ~$ kubectl get po
NAME        READY   STATUS    RESTARTS   AGE
webserver   2/2     Running   0          8s
thor@jumphost ~$ kubectl get all
NAME            READY   STATUS    RESTARTS   AGE
pod/webserver   2/2     Running   0          52s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        19m
service/nginx-service   NodePort    10.96.31.170   <none>        80:30008/TCP   14m
thor@jumphost ~$ ls
pods.yaml
thor@jumphost ~$ 
```

### The issue here is a typo in the image name for the httpd-container. It's currently set to httpd:latests, but it should be httpd:latest.

To fix this, you can update the pod's configuration to use the correct image name. Since you've already created the pod, you'll need to delete and recreate it with the correct configuration.

Here's an example YAML file that defines the pod with the correct image name:
```
apiVersion: v1
kind: Pod
metadata:
  name: webserver
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/httpd
  - name: sidecar-container
    image: ubuntu:latest
    command: ["sh", "-c"]
    args:
    - while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/httpd
  volumes:
  - name: shared-logs
    emptyDir: {}
```
Save this YAML file (e.g., webserver.yaml) and apply it to your Kubernetes cluster using the following command:

bash

kubectl apply -f webserver.yaml

This should create the pod with the correct configuration, and you should see the httpd-container running alongside the sidecar-container. You can verify this using:

bash

kubectl get po -o wide

This should show you the pod's status and IP address. If everything is set up correctly, you should be able to access the application using the pod's IP address.

### You can use the following command to get the YAML configuration of a pod and save it to a file:


bash
kubectl get po <pod-name> -o yaml > pod.yaml


Replace <pod-name> with the actual name of your pod. This command will save the pod's configuration in YAML format to a file named pod.yaml.

If you want to get the YAML configuration of all pods, you can use:


bash
kubectl get po -o yaml > pods.yaml


However, this will save all pods' configurations in a single YAML file.

To get a specific pod's configuration in a specific namespace, use:


bash
kubectl get po <pod-name> -n <namespace-name> -o yaml > pod.yaml

### In the vi editor, you can navigate to a particular word using the following methods:

1. Search for a word:
    - Type /word to search forward for the word.
    - Type ?word to search backward for the word.
    - Press n to go to the next occurrence and N to go to the previous occurrence.

For example, to search for the word "example", you would type /example and press Enter.

2. Move to a specific line:
    - Type :line_number to go to a specific line number.

For example, to go to line 100, you would type :100 and press Enter.

3. Move to the beginning or end of the file:
    - Press gg to go to the beginning of the file.
    - Press G to go to the end of the file.

4. Move word by word:
    - Press w to move forward one word.
    - Press b to move backward one word.

These navigation commands can help you efficiently move around in the vi editor and find specific words or locations in your file.


### Troubleshoot the following

```
kubectl apply -f pods.yaml 
Error from server (Conflict): error when applying patch:
{"metadata":{"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"creationTimestamp\":\"2025-10-20T06:27:37Z\",\"labels\":{\"app\":\"web-app\"},\"name\":\"webserver\",\"namespace\":\"default\",\"resourceVersion\":\"1142\",\"uid\":\"ec102bfd-7a9a-4d54-a9b2-14f99cf11aaf\"},\"spec\":{\"containers\":[{\"image\":\"httpd:latests\",\"imagePullPolicy\":\"IfNotPresent\",\"name\":\"httpd-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]},{\"command\":[\"sh\",\"-c\",\"while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done\"],\"image\":\"ubuntu:latest\",\"imagePullPolicy\":\"Always\",\"name\":\"sidecar-container\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/log/httpd\",\"name\":\"shared-logs\"},{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-gdds9\",\"readOnly\":true}]}],\"dnsPolicy\":\"ClusterFirst\",\"enableServiceLinks\":true,\"nodeName\":\"kodekloud-control-plane\",\"preemptionPolicy\":\"PreemptLowerPriority\",\"priority\":0,\"restartPolicy\":\"Always\",\"schedulerName\":\"default-scheduler\",\"securityContext\":{},\"serviceAccount\":\"default\",\"serviceAccountName\":\"default\",\"terminationGracePeriodSeconds\":30,\"tolerations\":[{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/not-ready\",\"operator\":\"Exists\",\"tolerationSeconds\":300},{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/unreachable\",\"operator\":\"Exists\",\"tolerationSeconds\":300}],\"volumes\":[{\"emptyDir\":{},\"name\":\"shared-logs\"},{\"name\":\"kube-api-access-gdds9\",\"projected\":{\"defaultMode\":420,\"sources\":[{\"serviceAccountToken\":{\"expirationSeconds\":3607,\"path\":\"token\"}},{\"configMap\":{\"items\":[{\"key\":\"ca.crt\",\"path\":\"ca.crt\"}],\"name\":\"kube-root-ca.crt\"}},{\"downwardAPI\":{\"items\":[{\"fieldRef\":{\"apiVersion\":\"v1\",\"fieldPath\":\"metadata.namespace\"},\"path\":\"namespace\"}]}}]}}]},\"status\":{\"conditions\":[{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"Initialized\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"Ready\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"message\":\"containers with unready status: [httpd-container]\",\"reason\":\"ContainersNotReady\",\"status\":\"False\",\"type\":\"ContainersReady\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2025-10-20T06:27:37Z\",\"status\":\"True\",\"type\":\"PodScheduled\"}],\"containerStatuses\":[{\"image\":\"httpd:latest\",\"imageID\":\"\",\"lastState\":{},\"name\":\"httpd-container\",\"ready\":false,\"restartCount\":0,\"started\":false,\"state\":{\"waiting\":{\"message\":\"Back-off pulling image \\\"httpd:latests\\\"\",\"reason\":\"ImagePullBackOff\"}}},{\"containerID\":\"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2\",\"image\":\"docker.io/library/ubuntu:latest\",\"imageID\":\"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252\",\"lastState\":{},\"name\":\"sidecar-container\",\"ready\":true,\"restartCount\":0,\"started\":true,\"state\":{\"running\":{\"startedAt\":\"2025-10-20T06:27:41Z\"}}}],\"hostIP\":\"172.17.0.2\",\"phase\":\"Pending\",\"podIP\":\"10.244.0.5\",\"podIPs\":[{\"ip\":\"10.244.0.5\"}],\"qosClass\":\"BestEffort\",\"startTime\":\"2025-10-20T06:27:37Z\"}}\n"},"resourceVersion":"1142"},"status":{"containerStatuses":[{"image":"httpd:latest","imageID":"","lastState":{},"name":"httpd-container","ready":false,"restartCount":0,"started":false,"state":{"waiting":{"message":"Back-off pulling image \"httpd:latests\"","reason":"ImagePullBackOff"}}},{"containerID":"containerd://e00d731245590df3630512ca36516280b80575bd995567362b432e0b37e4f7d2","image":"docker.io/library/ubuntu:latest","imageID":"docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252","lastState":{},"name":"sidecar-container","ready":true,"restartCount":0,"started":true,"state":{"running":{"startedAt":"2025-10-20T06:27:41Z"}}}]}}
to:
Resource: "/v1, Resource=pods", GroupVersionKind: "/v1, Kind=Pod"
Name: "webserver", Namespace: "default"
for: "pods.yaml": error when patching "pods.yaml": Operation cannot be fulfilled on pods "webserver": the object has been modified; please apply your changes to the latest version and try again
thor@jumphost ~$
```

The above error message indicates that the pod "webserver" has been modified since you last retrieved its configuration, and Kubernetes is refusing to apply your changes. This is due to the resourceVersion mismatch.

To resolve this issue, you have a few options:

Option 1: Delete and recreate the pod

You can delete the pod and then apply the YAML file again:


bash
kubectl delete pod webserver
kubectl apply -f pods.yaml


*Option 2: Use kubectl replace instead of apply*

You can use kubectl replace to force the update:


bash
kubectl replace --force -f pods.yaml


Note that using --force will delete and recreate the pod.

Option 3: Edit the pod configuration manually

If you only need to make a small change, you can edit the pod configuration manually using kubectl edit:


bash
kubectl edit pod webserver


This will open the pod's configuration in a text editor, where you can make the necessary changes and save the file.

In your case, since you've already fixed the image name in your YAML file, deleting and recreating the pod using Option 1 should work fine.

### Error 
```
kubectl describe po
Name:             webserver
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Mon, 20 Oct 2025 06:36:36 +0000
Labels:           app=web-app
Annotations:      <none>
Status:           Pending
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  httpd-container:
    Container ID:   
    Image:          httpd:latests
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
  sidecar-container:
    Container ID:  containerd://b24de38edc1a421940f81cbbf2b8967cef662dc6d41a01fa01d9914cdc10377f
    Image:         ubuntu:latest
    Image ID:      docker.io/library/ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      while true; do cat /var/log/httpd/access.log /var/log/httpd/error.log; sleep 30; done
    State:          Running
      Started:      Mon, 20 Oct 2025 06:36:37 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/log/httpd from shared-logs (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gdds9 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  shared-logs:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-gdds9:
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
  Type     Reason   Age                From     Message
  ----     ------   ----               ----     -------
  Normal   Pulling  25s                kubelet  Pulling image "ubuntu:latest"
  Normal   Pulled   25s                kubelet  Successfully pulled image "ubuntu:latest" in 145.948049ms (145.967289ms including waiting)
  Normal   Created  25s                kubelet  Created container sidecar-container
  Normal   Started  25s                kubelet  Started container sidecar-container
  Normal   BackOff  23s (x2 over 24s)  kubelet  Back-off pulling image "httpd:latests"
  Warning  Failed   23s (x2 over 24s)  kubelet  Error: ImagePullBackOff
  Normal   Pulling  7s (x2 over 26s)   kubelet  Pulling image "httpd:latests"
  Warning  Failed   7s (x2 over 25s)   kubelet  Failed to pull image "httpd:latests": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/httpd:latests": failed to resolve reference "docker.io/library/httpd:latests": docker.io/library/httpd:latests: not found
  Warning  Failed   7s (x2 over 25s)   kubelet  Error: ErrImagePull
thor@jumphost ~$
```
The issue is still with the image name for the httpd-container. It's set to httpd:latests, but it should be httpd:latest.

You can see the error message in the kubectl describe po output:


Failed to pull image "httpd:latests": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/httpd:latests": failed to resolve reference "docker.io/library/httpd:latests": docker.io/library/httpd:latests: not found


To fix this, update the image name in your YAML file to httpd:latest and then delete and recreate the pod:


bash
kubectl delete pod webserver
kubectl apply -f pods.yaml


Make sure the pods.yaml file has the correct image name:


apiVersion: v1
kind: Pod
metadata:
  name: webserver
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    # ... rest of the configuration ...


After recreating the pod, the httpd-container should be able to pull the image and start running.


