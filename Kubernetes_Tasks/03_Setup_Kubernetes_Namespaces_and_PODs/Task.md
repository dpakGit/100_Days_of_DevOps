### Task:

### What I did

```
thor@jumphost ~$ kubectl create ns dev
namespace/dev created

thor@jumphost ~$ kubectl get ns

NAME                 STATUS   AGE
default              Active   9m20s
dev                  Active   9s
kube-node-lease      Active   9m20s
kube-public          Active   9m21s
kube-system          Active   9m21s
local-path-storage   Active   9m12s

thor@jumphost ~$ kubectl get all

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   9m28s

thor@jumphost ~$ kubectl run dev-nginx-pod --image=nginx:latest -n dev

pod/dev-nginx-pod created

thor@jumphost ~$ # or we can use the command kubectl run dev-nginx-pod --image=nginx:latest --namespace=dev

thor@jumphost ~$ kubectl get po

No resources found in default namespace.

thor@jumphost ~$ kubectl get po -n dev
NAME            READY   STATUS    RESTARTS   AGE
dev-nginx-pod   1/1     Running   0          70s

thor@jumphost ~$ kubectl get po -n dev -o yaml > dev-nginx-pod.yaml

thor@jumphost ~$ ls

dev-nginx-pod.yaml
```




### Simple YAML for the Pod
Here's a simplified version of the YAML for the pod dev-nginx-pod in namespace dev:

```
apiVersion: v1
kind: Pod
metadata:
  name: dev-nginx-pod
  namespace: dev
  labels:
    run: dev-nginx-pod
spec:
  containers:
  - name: dev-nginx-pod
    image: nginx:latest
```
