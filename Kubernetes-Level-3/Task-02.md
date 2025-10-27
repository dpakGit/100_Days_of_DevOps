### Task : Deploy Lamp Stack on Kubernetes Cluster



### What I did

```
thor@jumphost ~$ vi pod.yaml
thor@jumphost ~$ kubectl apply -f pod.yaml 
configmap/php-config created
secret/mysql-secret created
deployment.apps/lamp-wp created
service/lamp-service created
service/mysql-service created
thor@jumphost ~$ cd /tmp/
thor@jumphost /tmp$ ls
demofile2.json
index.php
systemd-private-45596dd59f42489dae3a2ae1d30ec2b9-dbus-broker.service-JgVI9k
systemd-private-45596dd59f42489dae3a2ae1d30ec2b9-systemd-logind.service-Icdb4r
thor@jumphost /tmp$ vi index.php 
thor@jumphost /tmp$ cat index.php 
<?php
$dbname = 'dbname';
$dbuser = 'dbuser';
$dbpass = 'dbpass';
$dbhost = 'dbhost';

$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

if ($result->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
  echo "Connected successfully";thor@jumphost /tmp$ 
thor@jumphost /tmp$ Above is the content of the default index.php file
bash: Above: command not found
thor@jumphost /tmp$ vi index.php 
thor@jumphost /tmp$ sudo vi index.php 

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor: 
thor@jumphost /tmp$ POD_NAME=$(kubectl get pods -l app=lamp-wp -o jsonpath='{.items[0].metadata.name}')
thor@jumphost /tmp$ kubectl get po
NAME                       READY   STATUS    RESTARTS   AGE
lamp-wp-674c4b4cc9-qjj78   2/2     Running   0          10m
thor@jumphost /tmp$ kubectl cp /tmp/index.php lamp-wp-674c4b4cc9-qjj78:/app/index.php -c httpd-php-container
```

<img width="1920" height="1080" alt="Screenshot (489)" src="https://github.com/user-attachments/assets/d662f2e7-5f4a-4c18-ba83-214e8a1d3bfa" />
