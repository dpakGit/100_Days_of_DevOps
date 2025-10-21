### Task : Resolve VolumeMounts Issue in Kubernetes
We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:



The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem.


Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. After this, you should be able to access the website using Website button on the top bar.


Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

### What I Did
```
following is the new task - We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:





The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem.



Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. After this, you should be able to access the website using Website button on the top bar. -



thor@jumphost ~$ ls

index.php  pod.yaml

thor@jumphost ~$ cat pod.yaml 

apiVersion: v1

kind: Pod

metadata:

  annotations:

    kubectl.kubernetes.io/last-applied-configuration: |

      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"app":"php-app"},"name":"nginx-phpfpm","namespace":"default"},"spec":{"containers":[{"image":"php:7.2-fpm-alpine","name":"php-fpm-container","volumeMounts":[{"mountPath":"/usr/share/nginx/html","name":"shared-files"}]},{"image":"nginx:latest","name":"nginx-container","volumeMounts":[{"mountPath":"/var/www/html","name":"shared-files"},{"mountPath":"/etc/nginx/nginx.conf","name":"nginx-config-volume","subPath":"nginx.conf"}]}],"volumes":[{"emptyDir":{},"name":"shared-files"},{"configMap":{"name":"nginx-config"},"name":"nginx-config-volume"}]}}

  creationTimestamp: "2025-10-21T06:03:51Z"

  labels:

    app: php-app

  name: nginx-phpfpm

  namespace: default

  resourceVersion: "888"

  uid: 6a4805bd-7f80-4f0a-bed9-785554160862

spec:

  containers:

  - image: php:7.2-fpm-alpine

    imagePullPolicy: IfNotPresent

    name: php-fpm-container

    resources: {}

    terminationMessagePath: /dev/termination-log

    terminationMessagePolicy: File

    volumeMounts:

    - mountPath: /usr/share/nginx/html

      name: shared-files

    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount

      name: kube-api-access-jj2fh

      readOnly: true

  - image: nginx:latest

    imagePullPolicy: Always

    name: nginx-container

    resources: {}

    terminationMessagePath: /dev/termination-log

    terminationMessagePolicy: File

    volumeMounts:

    - mountPath: /var/www/html

      name: shared-files

    - mountPath: /etc/nginx/nginx.conf

      name: nginx-config-volume

      subPath: nginx.conf

    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount

      name: kube-api-access-jj2fh

      readOnly: true

  dnsPolicy: ClusterFirst

  enableServiceLinks: true

  nodeName: kodekloud-control-plane

  preemptionPolicy: PreemptLowerPriority

  priority: 0

  restartPolicy: Always

  schedulerName: default-scheduler

  securityContext: {}

  serviceAccount: default

  serviceAccountName: default

  terminationGracePeriodSeconds: 30

  tolerations:

  - effect: NoExecute

    key: node.kubernetes.io/not-ready

    operator: Exists

    tolerationSeconds: 300

  - effect: NoExecute

    key: node.kubernetes.io/unreachable

    operator: Exists

    tolerationSeconds: 300

  volumes:

  - emptyDir: {}

    name: shared-files

  - configMap:

      defaultMode: 420

      name: nginx-config

    name: nginx-config-volume

  - name: kube-api-access-jj2fh

    projected:

      defaultMode: 420

      sources:

      - serviceAccountToken:

          expirationSeconds: 3607

          path: token

      - configMap:

          items:

          - key: ca.crt

            path: ca.crt

          name: kube-root-ca.crt

      - downwardAPI:

          items:

          - fieldRef:

              apiVersion: v1

              fieldPath: metadata.namespace

            path: namespace

status:

  conditions:

  - lastProbeTime: null

    lastTransitionTime: "2025-10-21T06:03:51Z"

    status: "True"

    type: Initialized

  - lastProbeTime: null

    lastTransitionTime: "2025-10-21T06:04:01Z"

    status: "True"

    type: Ready

  - lastProbeTime: null

    lastTransitionTime: "2025-10-21T06:04:01Z"

    status: "True"

    type: ContainersReady

  - lastProbeTime: null

    lastTransitionTime: "2025-10-21T06:03:51Z"

    status: "True"

    type: PodScheduled

  containerStatuses:

  - containerID: containerd://1cb78e57581466d3f22ca9bd92d669ee3399116a5b2806ab96fc42e493c1f05e

    image: docker.io/library/nginx:latest

    imageID: docker.io/library/nginx@sha256:adf382fc753c14b1d584b45fb4ecf2c469dcd5b25a25a299540b9db418049b12

    lastState: {}

    name: nginx-container

    ready: true

    restartCount: 0

    started: true

    state:

      running:

        startedAt: "2025-10-21T06:04:01Z"

  - containerID: containerd://70e124549dd72c1034d8faf93d6d94f6316b9baffecfd60ea6eb5ac78b4058c6

    image: docker.io/library/php:7.2-fpm-alpine

    imageID: docker.io/library/php@sha256:2e2d92415f3fc552e9a62548d1235f852c864fcdc94bcf2905805d92baefc87f

    lastState: {}

    name: php-fpm-container

    ready: true

    restartCount: 0

    started: true

    state:

      running:

        startedAt: "2025-10-21T06:03:55Z"

  hostIP: 172.17.0.2

  phase: Running

  podIP: 10.244.0.5

  podIPs:

  - ip: 10.244.0.5

  qosClass: BestEffort

  startTime: "2025-10-21T06:03:51Z"

thor@jumphost ~$ kubectl get cm

NAME               DATA   AGE

kube-root-ca.crt   1      12m

nginx-config       1      7m28s

thor@jumphost ~$ kubectl get cm nginx-config -o yaml > nginx-config.yaml

thor@jumphost ~$ ls

index.php  nginx-config.yaml  pod.yaml

thor@jumphost ~$ cat nginx-config.yaml 

apiVersion: v1

data:

  nginx.conf: |

    events {

    }

    http {

      server {

        listen 8099 default_server;

        listen [::]:8099 default_server;



        # Set nginx to serve files from the shared volume!

        root /var/www/html;

        index  index.html index.htm index.php;

        server_name _;

        location / {

          try_files $uri $uri/ =404;

        }

        location ~ \.php$ {

          include fastcgi_params;

          fastcgi_param REQUEST_METHOD $request_method;

          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

          fastcgi_pass 127.0.0.1:9000;

        }

      }

    }

kind: ConfigMap

metadata:

  annotations:

    kubectl.kubernetes.io/last-applied-configuration: |

      {"apiVersion":"v1","data":{"nginx.conf":"events {\n}\nhttp {\n  server {\n    listen 8099 default_server;\n    listen [::]:8099 default_server;\n\n    # Set nginx to serve files from the shared volume!\n    root /var/www/html;\n    index  index.html index.htm index.php;\n    server_name _;\n    location / {\n      try_files $uri $uri/ =404;\n    }\n    location ~ \\.php$ {\n      include fastcgi_params;\n      fastcgi_param REQUEST_METHOD $request_method;\n      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;\n      fastcgi_pass 127.0.0.1:9000;\n    }\n  }\n}\n"},"kind":"ConfigMap","metadata":{"annotations":{},"name":"nginx-config","namespace":"default"}}

  creationTimestamp: "2025-10-21T06:03:51Z"

  name: nginx-config

  namespace: default

  resourceVersion: "858"

  uid: 1e7ca297-1ef5-410b-aca7-123acc37711c

thor@jumphost ~$ kubectl describe po 

Name:             nginx-phpfpm

Namespace:        default

Priority:         0

Service Account:  default

Node:             kodekloud-control-plane/172.17.0.2

Start Time:       Tue, 21 Oct 2025 06:03:51 +0000

Labels:           app=php-app

Annotations:      <none>

Status:           Running

IP:               10.244.0.5

IPs:

  IP:  10.244.0.5

Containers:

  php-fpm-container:

    Container ID:   containerd://70e124549dd72c1034d8faf93d6d94f6316b9baffecfd60ea6eb5ac78b4058c6

    Image:          php:7.2-fpm-alpine

    Image ID:       docker.io/library/php@sha256:2e2d92415f3fc552e9a62548d1235f852c864fcdc94bcf2905805d92baefc87f

    Port:           <none>

    Host Port:      <none>

    State:          Running

      Started:      Tue, 21 Oct 2025 06:03:55 +0000

    Ready:          True

    Restart Count:  0

    Environment:    <none>

    Mounts:

      /usr/share/nginx/html from shared-files (rw)

      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jj2fh (ro)

  nginx-container:

    Container ID:   containerd://1cb78e57581466d3f22ca9bd92d669ee3399116a5b2806ab96fc42e493c1f05e

    Image:          nginx:latest

    Image ID:       docker.io/library/nginx@sha256:adf382fc753c14b1d584b45fb4ecf2c469dcd5b25a25a299540b9db418049b12

    Port:           <none>

    Host Port:      <none>

    State:          Running

      Started:      Tue, 21 Oct 2025 06:04:01 +0000

    Ready:          True

    Restart Count:  0

    Environment:    <none>

    Mounts:

      /etc/nginx/nginx.conf from nginx-config-volume (rw,path="nginx.conf")

      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jj2fh (ro)

      /var/www/html from shared-files (rw)

Conditions:

  Type              Status

  Initialized       True 

  Ready             True 

  ContainersReady   True 

  PodScheduled      True 

Volumes:

  shared-files:

    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)

    Medium:     

    SizeLimit:  <unset>

  nginx-config-volume:

    Type:      ConfigMap (a volume populated by a ConfigMap)

    Name:      nginx-config

    Optional:  false

  kube-api-access-jj2fh:

    Type:                    Projected (a volume that contains injected data from multiple sources)

    TokenExpirationSeconds:  3607

    ConfigMapName:           kube-root-ca.crt

    ConfigMapOptional:       <nil>

    DownwardAPI:             true

QoS Class:                   BestEffort

Node-Selectors:              <none>

Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s

                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s

Events:

  Type    Reason     Age    From               Message

  ----    ------     ----   ----               -------

  Normal  Scheduled  8m37s  default-scheduler  Successfully assigned default/nginx-phpfpm to kodekloud-control-plane

  Normal  Pulling    8m36s  kubelet            Pulling image "php:7.2-fpm-alpine"

  Normal  Pulled     8m33s  kubelet            Successfully pulled image "php:7.2-fpm-alpine" in 2.583810411s (2.583833561s including waiting)

  Normal  Created    8m33s  kubelet            Created container php-fpm-container

  Normal  Started    8m33s  kubelet            Started container php-fpm-container

  Normal  Pulling    8m33s  kubelet            Pulling image "nginx:latest"

  Normal  Pulled     8m27s  kubelet            Successfully pulled image "nginx:latest" in 5.591300049s (5.591318895s including waiting)

  Normal  Created    8m27s  kubelet            Created container nginx-container

  Normal  Started    8m27s  kubelet            Started container nginx-container

thor@jumphost ~$ 

This final, comprehensive output provides all the necessary configuration details! We have pinpointed the exact inconsistency that is causing the application to fail.

🎯 Final Problem Identified
The core problem is a Volume Mount Inconsistency coupled with a ConfigMap Misconfiguration.

Component	Container	Path Used	Actual Issue
PHP-FPM Mount	php-fpm-container	/usr/share/nginx/html	PHP-FPM expects files here.
Nginx Mount	nginx-container	/var/www/html	Nginx volume is mounted here. (Inconsistent)
Nginx Config Root	nginx-container (ConfigMap)	root /var/www/html;	Nginx is told to look here.
The shared volume is mounted at two different paths in the two containers (/usr/share/nginx/html vs. /var/www/html). The Nginx ConfigMap points to one of the inconsistent paths (/var/www/html).

When you try to copy a file into the container, the kubectl cp command fails because the target directory doesn't align with the underlying shared volume structure.

The Definitive Solution
The safest and most permanent fix is to standardize the mount paths and fix the Nginx config root.

Since you now have the pod.yaml file, we will fix the mount path discrepancy in the YAML file and then reapply it.

Step 1: Fix the Pod Definition (Mount Path Inconsistency)
We need to edit the pod.yaml file to ensure both containers mount the shared volume at the same, consistent path. We will standardize on /var/www/html, as this is the path the Nginx config is currently using.

Edit the local pod.yaml file:

Bash
vi pod.yaml
(Or use kubectl edit po nginx-phpfpm if the Pod was still running, but since it was deleted and recreated using a file, we edit the file.)

Locate the php-fpm-container definition and change its mountPath:

Find this section:

YAML
    - image: php:7.2-fpm-alpine
      # ...
      volumeMounts:
      - mountPath: /usr/share/nginx/html  # <-- CHANGE THIS LINE
        name: shared-files
      # ...
Change it to:

YAML
      volumeMounts:
      - mountPath: /var/www/html          # <-- FIXED PATH
        name: shared-files
(Ensure you save and close the editor.)

Step 2: Apply the Corrected Pod Definition
Now re-apply the corrected YAML file to delete the existing, faulty Pod and recreate it with consistent volume mounts.

Re-apply the fixed Pod YAML:

Bash
kubectl apply -f pod.yaml
Wait for the new Pod to run:

Bash
kubectl get pods
# Wait until 'nginx-phpfpm' is Running.
Step 3: Copy the Application File
Now that both containers have the shared volume mounted at the consistent path /var/www/html, we can confidently copy the file there.

Copy the file to the shared mount point:

Bash
kubectl cp /home/thor/index.php nginx-phpfpm:/var/www/html/index.php -c nginx-container
Step 4: Verification
Test Accessibility: Access the website using the Website button. The Nginx config (root /var/www/html;) now matches the Pod mount (/var/www/html), and the PHP-FPM container is also using this path, resolving all issues.

```


