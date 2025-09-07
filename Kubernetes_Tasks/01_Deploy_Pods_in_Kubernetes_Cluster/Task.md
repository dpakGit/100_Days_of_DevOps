### Task:
The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task to create a pod according to the details below:

Create a pod named pod-nginx using the nginx image with the latest tag. Ensure to specify the tag as nginx:latest.

Set the app label to nginx_app, and name the container as nginx-container.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

-----------------------------------------------

### What I Did

```
thor@jumphost ~$ kubectl

thor@jumphost ~$ vi pod.yaml

---------------------------------
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-nginx
  labels:
    app: nginx_app
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80

----------------------------------

thor@jumphost ~$ kubectl apply -f pod.yaml 
pod/pod-nginx created

thor@jumphost ~$ kubectl get pod
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          14s

```
### - Or create pod imperatively:

bash
kubectl run pod-nginx --image=nginx:latest --labels=app=nginx_app

### Miscellaneous

### Getting YAML of the Pod
- *Use kubectl get pod with -o yaml* to get the YAML definition of the pod:

bash
kubectl get pod pod-nginx -o yaml


Notes
- This command outputs: The current state and configuration of the pod in YAML format.
- You can redirect output to a file if needed:

bash
kubectl get pod pod-nginx -o yaml > pod-nginx.yaml


Do you need help with:
- Editing or modifying the pod YAML?
- Understanding pod configuration or status?
- Something else related to Kubernetes?

 *Check if kubectl is installed*:

bash
which kubectl

### Solutions
- *Check for kubectl explicitly*:

bash
ls /usr/local/bin/kubectl

- *Check if kubectl works*:

bash
/usr/local/bin/kubectl version --client

- Check cluster connectivity and permissions:

bash
kubectl auth can-i create pods

