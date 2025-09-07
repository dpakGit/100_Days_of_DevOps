### Task.md

create a deployment with name "nginx" and image "nginx:latest"

````
thor@jumphost ~$ kubectl create deploy nginx --image=nginx:latest
deployment.apps/nginx created

thor@jumphost ~$ kubectl get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           13s

thor@jumphost ~$ kubectl get po
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7bf8c77b5b-dn92d   1/1     Running   0          22s

thor@jumphost ~$ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
nginx-7bf8c77b5b   1         1         1       49s

thor@jumphost ~$ ls

thor@jumphost ~$ kubectl get deploy -o yaml > deploy-nginx.yaml

thor@jumphost ~$ ls
deploy-nginx.yaml
```

### Minimal YAML for a Deployment

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

Notes
- Simplified structure: Removed status, annotations, and default values.
- Functionally equivalent: Should create a basic nginx deployment.

Do you need help with:
- Applying this YAML or checking deployment status?
- Scaling or updating the deployment?
- Something else related to Kubernetes?
