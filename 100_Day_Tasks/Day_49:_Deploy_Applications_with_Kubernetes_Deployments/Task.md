### Task

The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details:

Create a deployment named httpd to deploy the application httpd using the image httpd:latest (ensure to specify the tag)


### What i did

```
thor@jumphost ~$ ls

thor@jumphost ~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   20m

thor@jumphost ~$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   21m

thor@jumphost ~$ kubectl create deploy httpd --image=httpd:latest
deployment.apps/httpd created

thor@jumphost ~$ kubectl get all

NAME                         READY   STATUS    RESTARTS   AGE
pod/httpd-69545969bd-t4vhm   1/1     Running   0          10s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   22m

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/httpd   1/1     1            1           10s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/httpd-69545969bd   1         1         1       10s

thor@jumphost ~$ kubectl get po
NAME                     READY   STATUS    RESTARTS   AGE
httpd-69545969bd-t4vhm   1/1     Running   0          41s

thor@jumphost ~$ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
httpd-69545969bd   1         1         1       50s

thor@jumphost ~$ kubectl get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
httpd   1/1     1            1           68s
```

```
ls
kubectl get all
kubectl get svc
kubectl create deploy httpd --image=httpd:latest
kubectl get all
kubectl get po
kubectl get rs
kubectl get deploy
```
