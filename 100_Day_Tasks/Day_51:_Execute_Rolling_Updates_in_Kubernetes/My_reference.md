### Task: Perform a Rolling Update on a Kubernetes Deployment

The task involves updating a Kubernetes deployment named nginx-deployment to use a new image nginx:1.19. We'll perform a rolling update to ensure that the application remains available during the update process.

Step-by-Step Instructions:

Step 1: Verify the Current Deployment
Before performing the update, let's verify the current deployment and its image version.

Command:

bash
kubectl get deployment nginx-deployment -o wide

Explanation:

- kubectl get deployment: Retrieves information about the deployment.
- nginx-deployment: Specifies the name of the deployment.
- -o wide: Displays additional information, including the image version.

Where to apply: Run this command on the jump_host where kubectl is configured to operate with the Kubernetes cluster.

Step 2: Perform the Rolling Update
Now, let's update the deployment to use the new image nginx:1.19.

Command:

bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.19

Explanation:

- kubectl set image: Updates the image of a deployment.
- deployment/nginx-deployment: Specifies the deployment to update.
- nginx=nginx:1.19: Specifies the container name (nginx) and the new image (nginx:1.19).

Where to apply: Run this command on the jump_host.

Step 3: Verify the Update
After performing the update, let's verify that the deployment has been updated successfully.

Command:

bash
kubectl get deployment nginx-deployment -o wide

Explanation: This command is the same as in Step 1. We're verifying that the image version has been updated to nginx:1.19.

Where to apply: Run this command on the jump_host.

Step 4: Check the Pod Status
Let's ensure that all pods are running and healthy after the update.

Command:

bash
kubectl get pods

Explanation:

- kubectl get pods: Retrieves information about the pods.

Where to apply: Run this command on the jump_host.

Step 5: Verify the Rolling Update
To verify that the rolling update was successful, you can check the deployment's rollout status.

Command:

bash
kubectl rollout status deployment/nginx-deployment

Explanation:

- kubectl rollout status: Displays the rollout status of a deployment.

### Both commands are equivalent:

- kubectl set image deployment/nginx-deployment nginx=nginx:1.19

- kubectl set image deploy nginx-deployment nginx=nginx:1.19


### What is the part "nginx=nginx:1.19" in the command

```
kubectl set image deploy nginx-deployment nginx=nginx:1.19
```

- The part nginx=nginx:1.19 is specifying the container name and the new image to use.

Here's a breakdown:

- nginx: This is the name of the container in the pod that you want to update. In this case, the container name is nginx.
- =nginx:1.19: This specifies the new image to use for the nginx container. The format is image-name:tag, where:
    - nginx is the image name.
    - 1.19 is the tag or version of the image.

So, nginx=nginx:1.19 means "update the container named nginx to use the nginx image with the tag 1.19".

If your container name is different, you would replace nginx with the actual container name. For example, if your container name is web-server, the command would be:


bash
kubectl set image deploy nginx-deployment web-server=nginx:1.19


### To find the container name in a deployment, you can use the following command:


bash
kubectl describe deployment <deployment-name>


Replace <deployment-name> with the name of your deployment.

In the output, look for the Containers section. The container name will be listed there.

Alternatively, you can use:


bash
kubectl get deployment <deployment-name> -o jsonpath='{.spec.template.spec.containers[*].name}'


This command will directly output the container name(s) in the deployment.

If your deployment has multiple containers, this command will list all container names.

You can also check the pod's specification, as the container names are defined there:


bash
kubectl get pod <pod-name> -o jsonpath='{.spec.containers[*].name}'


Replace <pod-name> with the name of one of the pods in your deployment.

By checking the deployment or pod specification, you can determine the container name(s) and use it in the kubectl set image command.

### kubectl commands and output

bash
kubectl get deploy nginx-deployment


will display some basic information about the deployment, including the container image.

However, it might not directly show the container name. To see more detailed information, including the container name, you can use:


bash
kubectl get deploy nginx-deployment -o wide


The -o wide flag will display additional information, such as the container image and potentially the container name, depending on the deployment configuration.

If you need to know the exact container name, kubectl describe deployment or kubectl get deployment -o jsonpath might be more reliable options.

The command kubectl get deploy is a shortcut for kubectl get deployment, just like kubectl get po is a shortcut for kubectl get pods.


### With the output from kubectl get deploy nginx-deployment -o wide, you can see the following information:

- NAME: The name of the deployment, which is nginx-deployment.
- READY: The number of pods that are ready, which is 3/3, indicating that all 3 pods are ready.
- UP-TO-DATE: The number of pods that have been updated to the latest version, which is 3.
- AVAILABLE: The number of pods that are available, which is 3.
- AGE: The age of the deployment, which is 23m, indicating that it was created 23 minutes ago.
- CONTAINERS: The name of the container, which is nginx-container.
- IMAGES: The image used by the container, which is nginx:1.16.
- SELECTOR: The label selector used by the deployment, which is app=nginx-app.

With this information, you can see that the container name is nginx-container. If you want to update the image to nginx:1.19, you would use the following command:


bash
kubectl set image deploy nginx-deployment nginx-container=nginx:1.19


### The --record flag is used to record the command in the deployment's annotation, which can be useful for tracking changes and rollbacks.

Here's the command:


bash
kubectl set image deploy nginx-deployment nginx-container=nginx:1.19 --record


By including --record, you'll be able to see the command that was used to make the change in the deployment's history, which can be helpful for auditing and troubleshooting purposes.

You can view the rollout history using:


bash
kubectl rollout history deployment nginx-deployment


### To see the command that was used to make the change in the deployment's history, you can use:


bash
kubectl rollout history deployment nginx-deployment --revision=<revision-number>


Replace <revision-number> with the specific revision number you're interested in.

In the output, you'll see a Change-cause field that shows the command that was used to make the change.

If you want to see the entire rollout history with change causes, use:


bash
kubectl rollout history deployment nginx-deployment



### To see all the revisions of a deployment, use:


bash
kubectl rollout history deployment nginx-deployment


### To see the YAML file of the deployment, use:


bash
kubectl get deployment nginx-deployment -o yaml


This command will display the deployment's configuration in YAML format.


### Note: When using kubectl set image, you only need to specify the new image, not the old one.

The syntax nginx-container=nginx:1.19 simply tells Kubernetes to update the nginx-container container to use the nginx:1.19 image, regardless of what image it was previously using.


### To verify if the image update was successfully implemented, you can use:


bash
kubectl get deployment nginx-deployment -o wide


Check the IMAGES column to see if the image has been updated to nginx:1.19.

Additionally, you can also use:


bash
kubectl describe deployment nginx-deployment


And look for the Image field in the Containers section to confirm the update.

If you want to monitor the rollout status, use:


bash
kubectl rollout status deployment nginx-deployment


### 
