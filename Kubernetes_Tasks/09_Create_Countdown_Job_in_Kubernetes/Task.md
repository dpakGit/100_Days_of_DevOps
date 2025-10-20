### Task : Create Countdown Job in Kubernetes

The Nautilus DevOps team is crafting jobs in the Kubernetes cluster. While they're developing actual scripts/commands, they're currently setting up templates and testing jobs with dummy commands. Please create a job template as per details given below:


Create a job named countdown-nautilus.

The spec template should be named countdown-nautilus (under metadata), and the container should be named container-countdown-nautilus

Utilize image fedora with latest tag (ensure to specify as fedora:latest), and set the restart policy to Never.

Execute the command sleep 5

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster.


### What I did

Here's a YAML file that defines the Job as per the requirements:

```
apiVersion: batch/v1
kind: Job
metadata:
  name: countdown-nautilus
spec:
  template:
    metadata:
      name: countdown-nautilus
    spec:
      containers:
      - name: container-countdown-nautilus
        image: fedora:latest
        command: ["sleep", "5"]
      restartPolicy: Never
  backoffLimit: 4
```

You can save this YAML file (e.g., countdown-nautilus.yaml) and apply it to your Kubernetes cluster using the following command:


bash

kubectl apply -f countdown-nautilus.yaml


This will create the Job with the specified configuration. You can verify the Job and its pod using the following commands:


bash

kubectl get job

kubectl get pods


The Job will run a container that executes the sleep 5 command, pausing for 5 seconds before completing. Since the restart policy is set to Never, the Job will be marked as completed or failed based on the exit status of the container.

If you want to see the output or logs of the Job, you can use:


bash

kubectl logs job/countdown-nautilus


Or, get the pod name and check the logs:


bash

kubectl get pods

kubectl logs <pod-name>


### Note on backoffLimit

The inclusion of backoffLimit: 4 is a standard, often desirable default for a Job, although it wasn't explicitly required by the task. It instructs Kubernetes to retry the Job up to four times if it fails, which is generally good practice for non-CronJobs.

### The backoffLimit is optional but good practice for robustness

backoffLimit: 4
template:
metadata:
# Job Template Name
name: countdown-nautilus
spec:
containers:
- name: container-countdown-nautilus
image: fedora:latest
command: ["sleep", "5"]
# Restart Policy MUST be Never for standard Jobs that terminate
restartPolicy: Never
