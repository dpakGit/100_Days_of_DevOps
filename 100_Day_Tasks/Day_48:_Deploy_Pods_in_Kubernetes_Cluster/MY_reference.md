#### Here's a YAML file that defines a pod according to the specified requirements:


apiVersion: v1
kind: Pod
metadata:
  name: pod-httpd
  labels:
    app: httpd_app
spec:
  containers:
  - name: httpd-container
    image: httpd:latest


You can create this pod using the following command:


bash
kubectl apply -f pod.yaml


#### However, if you prefer to create the pod directly without a YAML file, you can use the following command:


bash
kubectl run pod-httpd --image=httpd:latest --labels=app=httpd_app


#### Note that the container name will be pod-httpd in this case, which is the same as the pod name. If you want to specify a different container name, you can use a YAML file.

-You can't specify a custom container name when creating a pod using the kubectl run imperative command.

 To verify that the pod has been created successfully, you can use the following command:


bash
kubectl get pods -l app=httpd_app


This will display the pod's status and other details.

#### If you want to specify the container name as httpd-container while creating the pod directly without a YAML file, it's not possible with the kubectl run command. In that case, using a YAML file is the better option.

Here's how you can verify the container name:


bash
kubectl describe pod pod-httpd


This will display detailed information about the pod, including the container name.

To check if the pod is running:


bash
kubectl get pods pod-httpd


If the pod is running, you should see a status of "Running". If it's not running, you can check the pod's logs for errors:


bash
kubectl logs pod-httpd


#### Unfortunately, the kubectl run command doesn't directly support specifying a container name when creating a pod. However, you can create a pod with a specific container name using a YAML file.

But if you still want to use the imperative command, you can create a deployment instead of a pod, and specify the container name:


bash
kubectl create deployment pod-httpd --image=httpd:latest --labels=app=httpd_app


However, this will create a deployment instead of a standalone pod.

If you want to create a pod with a specific container name using imperative command is not directly possible.

But if you want to use kubectl run command to create a pod and want the container name to be httpd-container then you have to create it using YAML.



#### The command kubectl get pods -l app=httpd_app is used to retrieve a list of pods in a Kubernetes cluster that match a specific label.

Here's a breakdown of the command:

- kubectl get pods: This part of the command retrieves a list of pods in the cluster.
- -l: This flag specifies that you want to filter the results based on a label.
- app=httpd_app: This is the label selector. It specifies that you want to retrieve pods that have a label with the key app and the value httpd_app.

When you run this command, Kubernetes will return a list of pods that have the label app: httpd_app. This can be useful for managing and monitoring pods that are related to a specific application or service.

For example, if you have multiple pods running different applications, you can use labels to identify and manage them. Let's say you have pods for a web server, a database, and a messaging service. You can label them accordingly:

- Web server pod: app: httpd_app
- Database pod: app: db_app
- Messaging service pod: app: messaging_app

Then, you can use the kubectl get pods -l command to retrieve pods for a specific application. For example, to get the pods for the web server, you would run:


bash
kubectl get pods -l app=httpd_app


This command will return a list of pods that have the label app: httpd_app, which in this case would be the web server pod.

You can also use other label selectors, such as:

- -l app: Retrieves pods that have a label with the key app, regardless of the value.
- -l '!app': Retrieves pods that do not have a label with the key app.
- -l app in (httpd_app, db_app): Retrieves pods that have a label with the key app and a value of either httpd_app or db_app.

Label selectors provide a flexible way to manage and query resources in a Kubernetes cluster.



- If you want to view more information about the pod, but still less than what kubectl describe shows, you can use:


bash
kubectl get pod pod-httpd -o yaml

