### Task : Init Containers in Kubernetes

There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.

Create a Deployment named as ic-deploy-xfusion.

Configure spec as replicas should be 1, labels app should be ic-xfusion, template's metadata lables app should be the same ic-xfusion.

The initContainers should be named as ic-msg-xfusion, use image debian with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/media'. The volume mount should be named as ic-volume-xfusion and mount path should be /ic.

Main container should be named as ic-main-xfusion, use image debian with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/media; sleep 5; done'. The volume mount should be named as ic-volume-xfusion and mount path should be /ic.

Volume to be named as ic-volume-xfusion and it should be an emptyDir type.


### What I dId

Here's the YAML configuration for the Deployment:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-xfusion
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-xfusion
  template:
    metadata:
      labels:
        app: ic-xfusion
    spec:
      containers:
      - name: ic-main-xfusion
        image: debian:latest
        command: ['/bin/bash', '-c']
        args: ['while true; do cat /ic/media; sleep 5; done']
        volumeMounts:
        - name: ic-volume-xfusion
          mountPath: /ic
      initContainers:
      - name: ic-msg-xfusion
        image: debian:latest
        command: ['/bin/bash', '-c']
        args: ['echo Init Done - Welcome to xFusionCorp Industries > /ic/media']
        volumeMounts:
        - name: ic-volume-xfusion
          mountPath: /ic
      volumes:
      - name: ic-volume-xfusion
        emptyDir: {}
```

This YAML configuration defines a Deployment named ic-deploy-xfusion with one replica. The ic-xfusion label is used for both the Deployment's selector and the Pod's metadata labels.

The ic-msg-xfusion initContainer uses the debian:latest image and runs a command to write a message to the /ic/media file. The ic-main-xfusion container uses the same image and runs a command to continuously read and print the contents of the /ic/media file.

Both containers mount a volume named ic-volume-xfusion at the /ic path. This volume is an emptyDir type, which means it will be deleted when the Pod is deleted. The initContainer writes to this volume, and the main container reads from it.
