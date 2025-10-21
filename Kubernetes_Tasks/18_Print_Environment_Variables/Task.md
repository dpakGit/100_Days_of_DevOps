### Task : Print Environment Variables

The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it.

Create a pod named print-envars-greeting.

Configure spec as, the container name should be print-env-container and use bash image.

Create three environment variables:

a. GREETING and its value should be Welcome to

b. COMPANY and its value should be Stratos

c. GROUP and its value should be Datacenter

Use command ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"'] (please use this exact command), also set its restartPolicy policy to Never to avoid crash loop back.

You can check the output using kubectl logs -f print-envars-greeting command.

### What I  Did


### Here is the YAML configuration for the pod:

```
apiVersion: v1
kind: Pod
metadata:
  name: print-envars-greeting
spec:
  containers:
  - name: print-env-container
    image: bash
    env:
    - name: GREETING
      value: "Welcome to"
    - name: COMPANY
      value: "Stratos"
    - name: GROUP
      value: "Datacenter"
    command: ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"']
  restartPolicy: Never
```

Let's create the pod:


bash
kubectl apply -f pod.yaml


After the pod is created, you can check the logs using:


bash
kubectl logs -f print-envars-greeting


This will output:


Welcome to Stratos Datacenter


Since the restart policy is set to Never, the pod will terminate after executing the command, and you'll see the output in the logs.

Verification Steps:

1. Create the pod using kubectl apply -f pod.yaml
2. Check the pod status using kubectl get pod print-envars-greeting
3. Check the logs using kubectl logs -f print-envars-greeting
4. Verify the output is Welcome to Stratos Datacenter

