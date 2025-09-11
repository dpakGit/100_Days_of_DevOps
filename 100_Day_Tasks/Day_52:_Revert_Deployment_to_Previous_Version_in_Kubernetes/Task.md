### Task Day 52: Revert Deployment to Previous Version in Kubernetes

Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.

There exists a deployment named nginx-deployment; initiate a rollback to the previous revision.

Note: The kubectl utility on jump_host is configured to interact with the Kubernetes cluster.


### What I Did
```
thor@jumphost ~$ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-5d44db985c-68xjs   1/1     Running   0          38s
pod/nginx-deployment-5d44db985c-mksxn   1/1     Running   0          33s
pod/nginx-deployment-5d44db985c-r2hmp   1/1     Running   0          31s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        17m
service/nginx-service   NodePort    10.96.116.43   <none>        80:30008/TCP   48s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           48s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-5d44db985c   3         3         3       38s
replicaset.apps/nginx-deployment-989f57c54    0         0         0       48s

thor@jumphost ~$ kubectl get deploy
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           80s

thor@jumphost ~$ kubectl get deploy nginx-deployment -o wide # This command will display the current Image and its version
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES              SELECTOR
nginx-deployment   3/3     3            3           98s   nginx-container   nginx:alpine-perl   app=nginx-app

thor@jumphost ~$ kubectl rollout history deploy nginx-deployment 
deployment.apps/nginx-deployment 
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl set image deployment nginx-deployment nginx-container=nginx:alpine-perl --kubeconfig=/root/.kube/config --record=true


thor@jumphost ~$ kubectl rollout undo deploy nginx-deployment 
deployment.apps/nginx-deployment rolled back

thor@jumphost ~$ kubectl rollout status deploy nginx-deployment 
deployment "nginx-deployment" successfully rolled out

thor@jumphost ~$ kubectl rollout history deploy nginx-deployment 
deployment.apps/nginx-deployment 
REVISION  CHANGE-CAUSE
2         kubectl set image deployment nginx-deployment nginx-container=nginx:alpine-perl --kubeconfig=/root/.kube/config --record=true
3         <none>

thor@jumphost ~$ kubectl annotate deploy nginx-deployment  kubernetes.io/change-cause="update image - to the previous version-rollback" 
deployment.apps/nginx-deployment annotated

thor@jumphost ~$ kubectl rollout history deploy nginx-deployment 
REVISION  CHANGE-CAUSE
2         kubectl set image deployment nginx-deployment nginx-container=nginx:alpine-perl --kubeconfig=/root/.kube/config --record=true
3         update image - to the previous version-rollback



thor@jumphost ~$ kubectl get deploy nginx-deployment -o wide
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3     3            3           24m   nginx-container   nginx:1.16   app=nginx-app
```

Note : The command "kubectl get deploy nginx-deployment -o wide" will display the current version of the image on which the 
       deployment is running compared to the command kubectl rollout history deploy nginx-deployment 


```
thor@jumphost ~$ history |cut -c 8-
kubectl get all
kubectl get deploy
kubectl get deploy nginx-deployment -o wide
kubectl rollout history deploy nginx-deployment 
kubectl rollout undo deploy nginx-deployment 
kubectl rollout status deploy nginx-deployment 
kubectl rollout history deploy nginx-deployment 
kubectl annotate deploy nginx-deployment  kubernetes.io/change-cause="update image - to the previous version-rollback" 
kubectl rollout history deploy nginx-deployment 
kubectl get deploy nginx-deployment -o wide
```
