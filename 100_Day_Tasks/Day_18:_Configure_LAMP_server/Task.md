### Task:

xFusionCorp Industries is planning to host a WordPress website on their infra in Stratos Datacenter. They have already done infrastructure configuration—for example, on the storage server they already have a shared directory /vaw/www/html that is mounted on each app host under /var/www/html directory. Please perform the following steps to accomplish the task:



a. Install httpd, php and its dependencies on all app hosts.


b. Apache should serve on port 8089 within the apps.


c. Install/Configure MariaDB server on DB Server.


d. Create a database named kodekloud_db5 and create a database user named kodekloud_roy identified as password BruCStnMT5. Further make sure this newly created user is able to perform all operation on the database you created.


e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. You should see a message like App is able to connect to the database using user kodekloud_roy

------------------------------------------------------------
https://tundedamian.medium.com/day-18-of-100-days-of-devops-deploying-a-scalable-wordpress-stack-across-multiple-hosts-3282bd0744cd

-------------------------------------------

### What I Did

Run the following commands on each App server:

sudo yum install httpd php php-mysqlnd php-fpm  -y

sudo sed -i 's/Listen 80/Listen 8089/g' /etc/httpd/conf/httpd.conf

sudo systemctl start httpd

sudo systemctl enable httpd


thor@jumphost ~$ ssh peter@172.16.239.10

[peter@stdb01 ~]$ rpm -qa | grep mariadb

[peter@stdb01 ~]$ sudo systemctl status mariadb

Unit mariadb.service could not be found.

[peter@stdb01 ~]$ sudo yum install mariadb-server -y

sudo systemctl start mariadb

sudo systemctl enable mariadb

[peter@stdb01 ~]$ rpm -qa | grep mariadb

mariadb-connector-c-config-3.2.6-1.el9.noarch
mariadb-common-10.5.27-1.el9.x86_64
mariadb-connector-c-3.2.6-1.el9.x86_64
mariadb-errmsg-10.5.27-1.el9.x86_64
mariadb-10.5.27-1.el9.x86_64
mariadb-backup-10.5.27-1.el9.x86_64
mariadb-gssapi-server-10.5.27-1.el9.x86_64
mariadb-server-10.5.27-1.el9.x86_64
mariadb-server-utils-10.5.27-1.el9.x86_64


[peter@stdb01 ~]$ sudo systemctl status mariadb

● mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Sat 2025-08-16 06:10:08 UTC; 30s ago

[peter@stdb01 ~]$ # Run MariaDB secure installation if needed

sudo mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
haven't set the root password yet, you should just press enter here.

Enter current password for root (enter for none): 
OK, successfully used password, moving on...

Setting the root password or using the unix_socket ensures that nobody
can log into the MariaDB root user without the proper authorisation.

You already have your root account protected, so you can safely answer 'n'.

Switch to unix_socket authentication [Y/n] n
 ... skipping.

You already have your root account protected, so you can safely answer 'n'.

Change the root password? [Y/n] y
New password: 
Re-enter new password: 
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] n
 ... skipping.

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] n
 ... skipping.

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
[peter@stdb01 ~]$ sudo mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 8
Server version: 10.5.27-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> # Create database and user, grant privileges
MariaDB [(none)]> CREATE DATABASE kodekloud_db5;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> 
MariaDB [(none)]> # Create database and user, grant privileges
MariaDB [(none)]> CREATE DATABASE kodekloud_db5;
ERROR 1007 (HY000): Can't create database 'kodekloud_db5'; database exists
MariaDB [(none)]> CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
ERROR 1396 (HY000): Operation CREATE USER failed for 'kodekloud_roy'@'%'
MariaDB [(none)]> GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> # Create database and user, grant privileges
MariaDB [(none)]> CREATE DATABASE kodekloud_db5;
ERROR 1007 (HY000): Can't create database 'kodekloud_db5'; database exists
MariaDB [(none)]> CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
ERROR 1396 (HY000): Operation CREATE USER failed for 'kodekloud_roy'@'%'
MariaDB [(none)]> GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.000 sec)

MariaDB [(none)]> CREATE DATABASE kodekloud_db5;
ERROR 1007 (HY000): Can't create database 'kodekloud_db5'; database exists
MariaDB [(none)]> CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
ERROR 1396 (HY000): Operation CREATE USER failed for 'kodekloud_roy'@'%'
MariaDB [(none)]> GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> 
MariaDB [(none)]> CREATE DATABASE kodekloud_db5 ;
ERROR 1007 (HY000): Can't create database 'kodekloud_db5'; database exists
MariaDB [(none)]> exit
Bye
[peter@stdb01 ~]$ exit
logout
Connection to 172.16.239.10 closed.
thor@jumphost ~$ 
