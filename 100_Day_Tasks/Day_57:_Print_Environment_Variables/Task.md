### Task : Day 57: Print Environment Variables

The Nautilus DevOps team is working on to setup some pre-requisites for an application that will send the greetings to different users. There is a sample deployment, that needs to be tested. Below is a scenario which needs to be configured on Kubernetes cluster. Please find below more details about it.


Create a pod named print-envars-greeting.

Configure spec as, the container name should be print-env-container and use bash image.

Create three environment variables:

a. GREETING and its value should be Welcome to

b. COMPANY and its value should be Nautilus

c. GROUP and its value should be Group

Use command ["/bin/sh", "-c", 'echo "$(GREETING) $(COMPANY) $(GROUP)"'] (please use this exact command), also set its restartPolicy policy to Never to avoid crash loop back.

You can check the output using kubectl logs -f print-envars-greeting command.


### What I did

```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
thor@jumphost ~$ vi pod.yaml
thor@jumphost ~$ kubectl apply -f pod.yaml 
pod/print-envars-greeting created
thor@jumphost ~$ kubectl get po print-envars-greeting 
NAME                    READY   STATUS      RESTARTS   AGE
print-envars-greeting   0/1     Completed   0          40s
thor@jumphost ~$ kubectl get po print-envars-greeting 
NAME                    READY   STATUS      RESTARTS   AGE
print-envars-greeting   0/1     Completed   0          47s
thor@jumphost ~$ kubectl logs -f print-envars-greeting
Welcome to Nautilus Group
```

### # pod.yaml
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

```
history | cut -c 8-
pwd
ls
vi pod.yaml
kubectl apply -f pod.yaml 
kubectl get po print-envars-greeting 
kubectl logs -f print-envars-greeting
```
history | cut -c 8-
thor@jumphost ~$ 
