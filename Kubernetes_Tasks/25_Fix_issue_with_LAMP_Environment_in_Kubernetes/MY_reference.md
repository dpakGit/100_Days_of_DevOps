https://shubhamksawant.medium.com/fix-issue-with-lamp-environment-in-kubernetes-eff57b0b14c1

One of the DevOps team member was trying to install a WordPress website on a LAMP stack which is essentially deployed on Kubernetes cluster. It was working well and we could see the installation page a few hours ago. However something is messed up with the stack now due to a website went down. Please look into the issue and fix it:



FYI, deployment name is lamp-wp and its using a service named lamp-service. The Apache is using http default port and nodeport is 30008. From the application logs it has been identified that application is facing some issues while connecting to the database in addition to other issues. Additionally, there are some environment variables associated with the pods like MYSQL_ROOT_PASSWORD, MYSQL_DATABASE,  MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST.


Also do not try to delete/modify any other existing components like deployment name, service name, types, labels etc.  cat index.php 
<?php
$dbname = $_ENV['MYSQL_DATABASE'];
$dbuser = $_ENV['MYSQL_USER'];
$dbpass = $_ENV[''MYSQL_PASSWORD""];
$dbhost = $_ENV['MYSQL-HOST'];


$connect = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");

$test_query = "SHOW TABLES FROM $dbname";
$result = mysqli_query($test_query);

if ($result->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
/app #



### Based on the provided information, it seems like the issue is with the database connection. Let's identify the potential problems:

1. Environment Variables: The environment variables MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, and MYSQL_HOST are set for the pod. However, in the index.php file, there's a typo in the line $dbpass = $_ENV[''MYSQL_PASSWORD""];. It should be $dbpass = $_ENV['MYSQL_PASSWORD'];.

2. Database Host: The environment variable MYSQL_HOST is used in the index.php file as $_ENV['MYSQL-HOST'], but it should be $_ENV['MYSQL_HOST']. The hyphen (-) is not an underscore (_).

3. Database Connection: The mysqli_connect function is used to connect to the database, but the database name is not selected. You can use the mysqli_select_db function to select the database.

Here's the corrected index.php file:


<?php
$dbname = $_ENV['MYSQL_DATABASE'];
$dbuser = $_ENV['MYSQL_USER'];
$dbpass = $_ENV['MYSQL_PASSWORD'];
$dbhost = $_ENV['MYSQL_HOST'];

$connect = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname) or die("Unable to Connect to '$dbhost'");

if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

echo "Connected successfully";
?>


To fix the issue, you can update the index.php file with the corrected code and redeploy the application. If you're unable to redeploy, you can try to update the environment variables or the database connection string directly in the pod. However, this is not recommended as the changes will be lost when the pod is recreated.

To verify the database connection, you can use the kubectl exec command to access the pod and test the connection:


bash
kubectl exec -it <pod-name> -c httpd-php-container -- mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD


Replace <pod-name> with the actual name of the pod.

If you're still facing issues, check the pod logs for any error messages:


bash
kubectl logs <pod-name> -c httpd-php-container


This should help you identify and fix the database connection issue.


### Also To fix the issue with the WordPress website on the LAMP stack deployed on a Kubernetes cluster, let's focus on the database connection issues. Based on the provided context and search results, here are the steps to resolve the issue:

Step 1: Verify Environment Variables

Ensure the environment variables MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, and MYSQL_HOST are correctly set for the pod. You can check the environment variables using:

bash
kubectl exec -it <pod-name> -c httpd-php-container -- env | grep -i mysql

Step 2: Check Database Connection

Verify the database connection by checking the logs:

bash
kubectl logs -f <pod-name> -c httpd-php-container

Step 3: Fix Typos in index.php

There might be typos in the index.php file. Ensure the environment variable names match the ones set in the Kubernetes configuration. Update the index.php file with the correct code:

$dbname = $_ENV['MYSQL_DATABASE'];
$dbuser = $_ENV['MYSQL_USER'];
$dbpass = $_ENV['MYSQL_PASSWORD'];
$dbhost = $_ENV['MYSQL_HOST'];

Step 4: Restart PHP Service

After making corrections in index.php, restart the PHP service:

bash
kubectl exec -it <pod-name> -c httpd-php-container -- service php-fpm restart

Step 5: Verify Service and Port Configurations

Ensure the lamp-service is exposing the correct ports. If necessary, update the service configuration:

bash
kubectl get svc lamp-service -o yaml > lamp-svc.yml

Update the lamp-svc.yml file with the correct port configurations and apply the changes:

bash
kubectl apply -f lamp-svc.yml

By following these steps, you should be able to resolve the database connection issues and get the WordPress website up and running again ¹.
