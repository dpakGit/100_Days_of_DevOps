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


**My_reference**

 YAML configuration to deploy the PHP website on the Kubernetes cluster:
pod.yaml
```
# 1) Create ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: php-config
data:
  php.ini: |
    variables_order = "EGPCS"

---
# 4) Create Secret
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  # Using dummy base64 values for demonstration
  MYSQL_ROOT_PASSWORD: cGFzc3dvcmQ= # password
  MYSQL_DATABASE: ZGJfc2VydmVy     # db_server
  MYSQL_USER: cGhwLXVzZXI=        # php-user (changed for better practice)
  MYSQL_PASSWORD: cGFzc3dvcmQ=     # password

---
# 2, 3, 5) Create Deployment with two containers
apiVersion: apps/v1
kind: Deployment
metadata:
  name: lamp-wp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: lamp-wp
  template:
    metadata:
      labels:
        app: lamp-wp
    spec:
      volumes:
      - name: php-config
        configMap:
          name: php-config
      containers:
      # First container: httpd-php-container
      - name: httpd-php-container
        image: webdevops/php-apache:alpine-3-php7
        volumeMounts:
        # Mount ConfigMap
        - name: php-config
          mountPath: /opt/docker/etc/php/php.ini
          subPath: php.ini
        env:
        # Use literal value for MYSQL_HOST to connect to co-located container
        - name: MYSQL_HOST
          value: "127.0.0.1" 
        # Get other variables from Secret (Using env field)
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_PASSWORD
      
      # Second container: mysql-container
      - name: mysql-container
        image: mysql:5.6
        env:
        # MySQL container only needs root password and user/db for initial setup
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_PASSWORD
        ports:
        - containerPort: 3306

---
# 6) Create NodePort Service for Web
apiVersion: v1
kind: Service
metadata:
  name: lamp-service
spec:
  selector:
    app: lamp-wp
  type: NodePort
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 30008

---
# 7) Create Service for MySQL (Although not strictly necessary for a co-located container, it's required by the prompt)
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: lamp-wp
  ports:
  - name: mysql
    port: 3306
    targetPort: 3306
    protocol: TCP
```

- Modify the local /tmp/index.php file to use environment variables as shown in the original solution's PHP code snippet:

- Here is the modified index.php file that correctly fetches the MySQL connection details from the environment variables set in the Kubernetes Pod:
  
```
<?php
// Replace hardcoded dummy values with environment variables set in the Kubernetes Deployment
$dbname = getenv('MYSQL_DATABASE');
$dbuser = getenv('MYSQL_USER');
$dbpass = getenv('MYSQL_PASSWORD');
$dbhost = getenv('MYSQL_HOST'); // This will be '127.0.0.1' for co-located containers

// Attempt to connect to the database
// The mysqli_connect function signature is: hostname, username, password, database_name
$connect = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

// Check connection
if (mysqli_connect_errno()) {
    // If connection fails, die and show the error
    die("Connection failed: " . mysqli_connect_error());
}

// If connection is successful, display the required message
echo "Connected successfully";

// Note: The original file had a test query and an incorrect error check structure.
// This simplified version only checks the connection and outputs the required success message.

// Close connection (optional, as PHP closes it automatically at script end)
mysqli_close($connect);
?>
```

➡️ Next Steps on the Jump Host
Save the corrected PHP code to the file /tmp/index.php on the jump host.

Copy the file into the running Pod:

```
# Copy the file into the Apache document root (/app) of the httpd container
kubectl cp /tmp/index.php ${POD_NAME}:/app/index.php -c httpd-php-container
```
Note: Before running this command, ensure you have modified the /tmp/index.php file on the jump host to use the getenv() function for MySQL credentials, as discussed previously, otherwise the application won't connect to the database.


🔎 Verification

After running the commands above, you should be able to verify the website is working correctly by accessing the NodePort service.

```
# Get the IP of a worker node (assuming one node for simplicity)
kubectl get nodes
```

- Access the website (assuming port 30008 was set in the NodePort service)
echo "Access the website at: http://${NODE_IP}:30008/index.php"
