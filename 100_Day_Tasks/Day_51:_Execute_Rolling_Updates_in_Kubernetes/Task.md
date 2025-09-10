### Task

Explain the following task,
give me the steps and commands to complete the task and where to apply which command,
clearly explain what each step and command do :-

An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.19 with the latest updates.

Execute a rolling update for this application, integrating the nginx:1.19 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.


### What I Did

````

# Step 1: Verify the Current Deployment with the following commands:
# Note : to perform the rolling update we need the deployment name and the container name, as this things are needed in the rolling update command. 

-> thor@jumphost ~$ kubectl get all
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

# The following commands output will give the deplyment name, container name and the current image on which the deployment is created.

thor@jumphost ~$ kubectl get deploy nginx-deployment -o wide 

NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3        3            3        28m   nginx-container   nginx:1.16   app=nginx-app

# container name is  nginx-container

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


# Command to see the YAML file of the deployment .The following command will display the deployment's configuration in YAML format

thor@jumphost ~$ kubectl get deployment nginx-deployment -o yaml


# Step 2: Perform the Rolling Update

thor@jumphost ~$ kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 

deployment.apps/nginx-deployment image updated

# Step 3: Verify the Update

# After performing the update, let's verify that the deployment has been updated successfully.

thor@jumphost ~$ kubectl get deployment nginx-deployment -o wide
NAME               READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS        IMAGES       SELECTOR
nginx-deployment   3/3     3            3           41m   nginx-container   nginx:1.19   app=nginx-app
thor@jumphost ~$ kubectl describe deployment nginx-deployment 

 
thor@jumphost ~$ kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].image}'
nginx:1.19


# Step 4: Check the Pod Status
# Let's ensure that all pods are running and healthy after the update.

kubectl get pods

# Step 5: Verify the Rolling Update/Monitor the rollout status
# To verify that the rolling update was successful, you can check the deployment's rollout status.

thor@jumphost ~$ kubectl rollout status deployment nginx-deployment
deployment "nginx-deployment" successfully rolled out
```

```
thor@jumphost ~$ history | cut -c 8-
kubectl get all
kubectl get deploy nginx-deployment
kubectl get deploy nginx-deployment -o wide
kubectl describe deploy nginx-deployment 
# command to see the YAML file of the deployment
kubectl get deployment nginx-deployment -o yaml # This command will display the deployment's configuration in YAML format
kubectl get deploy nginx-deployment -o wide
kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 --record
# To verify if the image update was successfully implemented
kubectl describe deployment nginx-deployment 
kubectl describe deployment nginx-deployment -o wide
# To monitor the rollout status
kubectl rollout status deployment nginx-deployment
kubectl get deployment nginx-deployment -o jsonpath='{.spec.template.spec.containers[*].image}'

```
