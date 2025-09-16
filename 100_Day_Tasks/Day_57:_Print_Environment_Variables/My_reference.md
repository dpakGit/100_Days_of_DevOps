### Task Overview

The Nautilus DevOps team wants to test a sample deployment on a Kubernetes cluster. They need to create a pod that will print a greeting message to the console. The greeting message will include the company name and group name.

What needs to be done

To accomplish this task, we need to create a pod with the following specifications:

1. Pod name: The pod should be named print-envars-greeting.
2. Container name: The container inside the pod should be named print-env-container.
3. Image: The container should use the bash image.
4. Environment variables: We need to set three environment variables:
    - GREETING with the value Welcome to
    - COMPANY with the value Nautilus
    - GROUP with the value Group
5. Command: The container should run a command that prints the greeting message to the console. The command should use the environment variables we set earlier. The exact command is echo "$(GREETING) $(COMPANY) $(GROUP)".
6. Restart policy: We need to set the restart policy to Never, which means that if the container crashes or exits, it will not be restarted.

Expected output

Once the pod is created and running, we can check the output using the kubectl logs -f print-envars-greeting command. This command will display the output of the pod, which should be the greeting message: Welcome to Nautilus Group.

By completing this task, we will have successfully created a pod that prints a greeting message to the console using environment variables.

### Here's the YAML file, steps, and commands to accomplish the task:

YAML file (pod.yaml)
```
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
spec:
  containers:
  - name: print-env-container
    image: bash
    command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']
    env:
    - name: GREETING
      value: "Welcome to"
    - name: COMPANY
      value: "Nautilus"
    - name: GROUP
      value: "Group"
  restartPolicy: Never
```

Steps and commands

1. Create the YAML file: Create a file named pod.yaml with the above YAML content.
2. Apply the YAML file: Run the command kubectl apply -f pod.yaml to create the pod.
3. Check the pod status: Run the command kubectl get pod print-envars-greeting to check the status of the pod.
4. Check the pod logs: Run the command kubectl logs -f print-envars-greeting to check the output of the pod.

Explanation of each section

- *apiVersion and kind*: These fields specify the API version and kind of Kubernetes object being defined. In this case, we're defining a Pod object with the v1 API version.
- *metadata*: This field specifies metadata about the pod, such as its name.
- *spec*: This field specifies the specification of the pod, including its containers and restart policy.
- *containers*: This field specifies the containers that run in the pod. In this case, we have a single container named print-env-container.
- *image*: This field specifies the Docker image used by the container. In this case, we're using the bash image.
- *command*: This field specifies the command to run in the container. In this case, we're running a shell command that echoes the greeting message.
- *env*: This field specifies environment variables that are set in the container. In this case, we're setting three environment variables: GREETING, COMPANY, and GROUP.
- *restartPolicy*: This field specifies the restart policy for the pod. In this case, we're setting it to Never, which means that if the container crashes or exits, it will not be restarted.

Use case

This YAML file and the corresponding commands can be used to create a pod that runs a simple shell command that prints a greeting message to the console. The environment variables are used to customize the greeting message.

This use case can be applied in various scenarios, such as:

- Testing Kubernetes deployments
- Running batch jobs that require environment variables
- Creating pods that perform simple tasks, such as printing messages or sending notifications.

By using environment variables, we can make the pod more flexible and reusable, without having to modify the underlying image or command.

### Let's break down the command:

**command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']**

Explanation

- /bin/sh: This is the shell executable that will be used to run the command. /bin/sh is a common shell executable that is available on most Unix-like systems.
- -c: This option tells the shell to read the command from the string that follows. In this case, the string is echo "$(GREETING) $(COMPANY) $(GROUP)".
- echo "$(GREETING) $(COMPANY) $(GROUP)": This is the command that will be executed by the shell. It uses the echo command to print a string to the console.

How it works

1. The shell (/bin/sh) is executed with the -c option, which tells it to read the command from the string that follows.
2. The string echo "$(GREETING) $(COMPANY) $(GROUP)" is passed to the shell, which interprets it as a command.
3. The shell expands the environment variables $(GREETING), $(COMPANY), and $(GROUP) with their corresponding values.
4. The echo command is executed with the expanded string, printing the greeting message to the console.

Environment variable expansion

The $() syntax is used to expand environment variables in the command. When the shell encounters a $() expression, it replaces it with the value of the corresponding environment variable.

For example, if the environment variables are set as follows:

- GREETING=Welcome to
- COMPANY=Nautilus
- GROUP=Group

The expanded string would be: Welcome to Nautilus Group

This is the string that would be printed to the console by the echo command.


### The -c flag is a common option used with shells, including /bin/sh and bash.

*What does -c do?*

The -c flag tells the shell to read the command from the string that follows. This allows you to pass a command as a string to the shell, rather than having to specify a file or interactive input.

Example

When you run /bin/sh -c 'echo Hello World', here's what happens:

1. The shell (/bin/sh) is executed with the -c option.
2. The string echo Hello World is passed to the shell as a command.
3. The shell reads the command from the string and executes it.
4. The echo command prints Hello World to the console.

Use cases

The -c flag is useful in a variety of situations, such as:

- Running a one-time command in a script or program.
- Executing a command in a container or pod, where you don't want to create a separate script file.
- Passing a command as a string to a shell, rather than having to specify a file or interactive input.

In the context of the original YAML file, the -c flag allows us to specify a command as a string that will be executed by the shell in the container. This makes it easy to run a simple command that prints a greeting message to the console.


### 
kubectl get po print-envars-greeting 
NAME                    READY   STATUS      RESTARTS   AGE
print-envars-greeting   0/1     Completed   0          47s

This output indicates that the pod print-envars-greeting has completed its execution and is no longer running.

Breakdown of the output

- NAME: The name of the pod, which is print-envars-greeting.
- READY: The number of containers in the pod that are ready to receive traffic. In this case, 0/1 indicates that none of the containers are ready, which is expected since the pod has completed its execution.
- STATUS: The current status of the pod, which is Completed. This indicates that the pod has finished running its command and has exited successfully.
- RESTARTS: The number of times the pod has been restarted. In this case, 0 indicates that the pod has not been restarted.
- AGE: The age of the pod, which is 47s in this case, indicating that the pod was created 47 seconds ago.

What happened

Based on the output, it appears that the pod print-envars-greeting ran its command successfully and exited. The command was likely the echo statement that printed the greeting message to the console.

Since the pod has completed its execution, you can check the logs to see the output of the command using the command kubectl logs print-envars-greeting. This should display the greeting message that was printed to the console.

### Q. Why in this case the yaml file is written such that the pod will be exited once it ran successfully ?

The YAML file is written such that the pod will exit once it runs successfully because of the following reasons:

1. Container's purpose: The container's purpose is to run a simple command that prints a greeting message to the console. Once the command is executed, there's no need for the container to keep running.
2. Restart policy: The restartPolicy is set to Never, which means that if the container exits, it will not be restarted. This is suitable for a pod that runs a one-time task or command.
3. Pod's design: The pod is designed to be a short-lived entity that performs a specific task. Once the task is completed, the pod is no longer needed.

By designing the pod to exit after running successfully, the YAML file ensures that:

- Resources are not wasted on keeping a pod running unnecessarily.
- The pod can be easily managed and cleaned up by Kubernetes.
- The pod's logs can be preserved for debugging and monitoring purposes.

This design pattern is commonly used for pods that run batch jobs, one-time tasks, or commands that don't require a long-running process.


### Q: Once this pod is exited how can we make it run again ?

A: Since the pod has exited, you can't simply "restart" it. Instead, you have a few options to run the pod again:

1. Delete and re-create the pod: You can delete the pod using kubectl delete pod print-envars-greeting and then re-create it using kubectl apply -f pod.yaml. This will create a new pod with the same configuration.
2. Use a Job: If you want to run a pod repeatedly, you can use a Kubernetes Job instead of a Pod. A Job will run a pod to completion and can be configured to run multiple times. You can create a Job YAML file and apply it using kubectl apply -f job.yaml.
3. Use a CronJob: If you want to run a pod on a schedule, you can use a Kubernetes CronJob. A CronJob will run a Job at a specified interval, allowing you to schedule the pod to run repeatedly.

To use a Job or CronJob, you'll need to create a new YAML file with the corresponding configuration. Here's an example of a Job YAML file:

apiVersion: batch/v1
kind: Job
metadata:
  name: print-envars-greeting
spec:
  template:
    spec:
      containers:
      - name: print-env-container
        image: bash
        command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']
        env:
        - name: GREETING
          value: "Welcome to"
        - name: COMPANY
          value: "Nautilus"
        - name: GROUP
          value: "Group"
      restartPolicy: Never
  backoffLimit: 4

You can apply this YAML file using kubectl apply -f job.yaml and then check the status of the Job using kubectl get job.

### Also give me a yaml that will use a job to run repeatedly and when we run the log command it will display the number of time it is ran ?

A: Here's an example YAML file that uses a CronJob to run a Job repeatedly:

apiVersion: batch/v1
kind: CronJob
metadata:
  name: print-envars-greeting
spec:
  schedule:
    - cron: */1 * * * *  # Run every minute
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: print-env-container
            image: bash
            command: ["/bin/sh", "-c", 'echo "Run count: $(RUN_COUNT)"']
            env:
            - name: RUN_COUNT
              valueFrom:
                configMapKeyRef:
                  name: run-count
                  key: count
          restartPolicy: OnFailure
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1

However, to display the number of times the job is run, we'll need to use a ConfigMap to store the count and update it each time the job runs. But since ConfigMaps are not designed to be updated by Pods, we'll use a different approach.

Let's use a file in a Persistent Volume (PV) to store the count. Here's an updated YAML file:

apiVersion: batch/v1
kind: CronJob
metadata:
  name: print-envars-greeting
spec:
  schedule:
    - cron: */1 * * * *  # Run every minute
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: print-env-container
            image: bash
            command: ["/bin/sh", "-c", 'count=$(cat /count.txt); echo "Run count: $count"; echo $((count + 1)) > /count.txt']
            volumeMounts:
            - name: count-pv
              mountPath: /count.txt
              subPath: count.txt
          volumes:
          - name: count-pv
            persistentVolumeClaim:
              claimName: count-pvc
          restartPolicy: OnFailure
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1

You'll also need to create a Persistent Volume Claim (PVC) YAML file:

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: count-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Mi

And initialize the count file:

apiVersion: v1
kind: Pod
metadata:
  name: init-count
spec:
  containers:
  - name: init-count-container
    image: bash
    command: ["/bin/sh", "-c", 'echo 1 > /count.txt']
    volumeMounts:
    - name: count-pv
      mountPath: /count.txt
      subPath: count.txt
  volumes:
  - name: count-pv
    persistentVolumeClaim:
      claimName: count-pvc
  restartPolicy: Never

Apply all these YAML files and you'll see the CronJob running every minute and displaying the run count.

To check the logs, use:

bash
kubectl logs job.batch/print-envars-greeting-<job_name>

Replace <job_name> with the actual job name.

Note that the job name will be different each time the CronJob runs. You can use kubectl get jobs to get the job name.

