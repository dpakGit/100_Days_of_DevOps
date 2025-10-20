### Task : Schedule Cronjobs in Kubernetes

The Nautilus DevOps team is setting up recurring tasks on different schedules. Currently, they're developing scripts to be executed periodically. To kickstart the process, they're creating cron jobs in the Kubernetes cluster with placeholder commands. Follow the instructions below:

Create a cronjob named datacenter.

Set Its schedule to something like */12 * * * *. You can set any schedule for now.

Name the container cron-datacenter.

Utilize the nginx image with latest tag (specify as nginx:latest).

Execute the dummy command echo Welcome to xfusioncorp!.

Ensure the restart policy is OnFailure.

Note: The kubectl utility on jump_host is configured to work with the kubernetes cluster.

### What I Did

Here's a YAML file that defines the CronJob as per the requirements:

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: datacenter
spec:
  schedule: "*/12 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: cron-datacenter
            image: nginx:latest
            command: ["echo", "Welcome to xfusioncorp!"]
          restartPolicy: OnFailure
```

You can save this YAML file (e.g., datacenter-cronjob.yaml) and apply it to your Kubernetes cluster using the following command:


bash
kubectl apply -f datacenter-cronjob.yaml


This will create the CronJob with the specified configuration. You can verify the CronJob using the following command:


bash

kubectl get cronjob


You can also check the jobs created by the CronJob using:


bash

kubectl get jobs


And check the pods created by the jobs using:


bash

kubectl get pods


The CronJob will execute the specified command (echo Welcome to xfusioncorp!) every 12 minutes, as specified in the schedule.
