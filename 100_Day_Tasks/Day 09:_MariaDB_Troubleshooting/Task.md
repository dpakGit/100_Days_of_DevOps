## Day 9: MariaDB Troubleshooting

#### There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that mariadb service is down on the database server.

Look into the issue and fix the same.

**The Problem:**

The Nautilus application is unable to connect to the database because the mariadb service is down on the database server. This is a critical issue that needs to be resolved as soon as possible.

**Note: Troubleshoot - 2 below is our use case**

**What I did and the output of the commands**

------------------------------------------------------
thor@jumphost ~$ ssh peter@172.16.239.10


sudo systemctl status mariadb

sudo systemctl start mariadb

Job for mariadb.service failed because the control process exited with error code.

sudo chown -R mysql:mysql /var/lib/mysql


Output: After using chown i got the following output

chown: cannot access '/var/lib/mysql': No such file or directory

ls -ld /var/lib/mysql

ls: cannot access '/var/lib/mysql': No such file or directory

ls /var/lib/

Output:

alternatives  games  mysqld   rpm        selinux  tpm2-tss
dnf           misc   private  rpm-state  systemd

Output: No mysql directory in the output

sudo mkdir /var/lib/mysql

sudo chown -R mysql:mysql /var/lib/mysql

sudo ls -ld /var/lib/mysql

Output:

drwxr-xr-x 2 mysql mysql 4096 Aug  1 06:35 /var/lib/mysql

sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

 sudo systemctl start mariadb
 
 sudo systemctl status mariadb

Output:

● mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Fri 2025-08-01 06:36:42 UTC; 7s ago
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
    Process: 2560 ExecStartPre=/usr/libexec/mariadb-check-socket (code=exited, status=0/SUCCESS)
    Process: 2594 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
    Process: 2741 ExecStartPost=/usr/libexec/mariadb-check-upgrade (code=exited, status=0/SUCCESS)
   Main PID: 2689 (mariadbd)
     Status: "Taking your SQL requests now..."
      Tasks: 33 (limit: 411434)
     Memory: 63.2M
     CGroup: /docker/78043334bf98aef55af1b2f39ce92732ca43888482a20983225d152a1589d8de/system.slice/mariadb.service

 
 sudo systemctl enable mariadb

 sudo systemctl status mariadb

 **Verifying the service is running and enabled:**
 
 sudo systemctl status mariadb and sudo systemctl is-enabled mariadb


 Output:
 
● mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Fri 2025-08-01 06:36:42 UTC; 55s ago
     
-------------------------------------------------------------------


**Meta AI**

## Troubleshooting MariaDB service downtime: 

## What are the steps to start, enable, and ensure the MariaDB service runs automatically on system startup?

-------------------------------------------
```
sudo systemctl start mariadb
Job for mariadb.service failed because the control process exited with error code.
See "systemctl status mariadb.service" and "journalctl -xeu mariadb.service" for details.
```
The error message indicates that the mariadb service failed to start. Let's check the logs for more information.

Check the mariadb logs:

Run the following command to view the mariadb logs:

bash
sudo journalctl -xeu mariadb.service

OR

systemctl status mariadb.service

This will show you the latest logs for the mariadb service, including any error messages that might indicate why the service failed to start.


-----------------------------------------

## Linux commands that can help you find the location or path of MariaDB or any other file/directory:

1. *which command:* which mariadb
This command will show you the path to the executable file of MariaDB, if it's installed and in your system's PATH.

2. *whereis command:* whereis mariadb
This command will show you the paths to the binary, source, and manual page locations of MariaDB.

3. *find command:* sudo find / -name mariadb
This command will search for files/directories with the name "mariadb" starting from the root directory (/).

4. *locate command:* locate mariadb
This command will search for files/directories with the name "mariadb" using the locate database. Note that the locate database may not be up-to-date, so you may need to run sudo updatedb before using the locate command.

5. *ps and ls -l /proc commands:* If MariaDB is running, you can use ps aux | grep mariadb to find the process ID, and then ls -l /proc/<PID>/exe to find the path to the executable.

These commands can help you find the location or path of MariaDB or any other file/directory on your Linux system.





## Troubleshoot - 1.

To fix the issue with the mariadb service being down on the database server, follow these steps:

Step 1: Check the mariadb service status

bash
sudo systemctl status mariadb

This command will show the current status of the mariadb service, including any error messages.

Step 2: Start the mariadb service

bash
sudo systemctl start mariadb

This command will attempt to start the mariadb service.

Step 3: Enable the mariadb service to start automatically on boot

bash
sudo systemctl enable mariadb

This command will ensure that the mariadb service starts automatically on boot, preventing similar issues in the future.

Step 4: Verify the mariadb service status

bash
sudo systemctl status mariadb

This command will confirm that the mariadb service is running and active.

Step 5: Test the database connection

After starting the mariadb service, test the database connection to ensure that the Nautilus application can connect to the database successfully.

If the issue persists, you may need to investigate further by:

- Checking the mariadb logs for errors: sudo journalctl -u mariadb
- Verifying the database credentials and configuration
- Checking for any firewall or network issues that might be blocking the connection

By following these steps, you should be able to resolve the issue with the mariadb service being down and get the Nautilus application connected to the database again.


## Troubleshoot - 2.

When running the following command gives the output:

sudo chown -R mysql:mysql /var/lib/mysql

chown: cannot access '/var/lib/mysql': No such file or directory

Meta AI Solution :

The error message indicates that the /var/lib/mysql directory does not exist. This is likely because the MariaDB database has not been initialized or the directory has been deleted.

Create the directory and set the ownership:

#### To fix this issue, you can try creating the /var/lib/mysql directory and setting the ownership to mysql:mysql. Here are the steps:

1. Create the directory: Run the command
```
sudo mkdir /var/lib/mysql
```
2. Set the ownership: Run the command
```
sudo chown -R mysql:mysql /var/lib/mysql
```

**Note:**
```

The command sudo chown -R mysql:mysql /var/lib/mysql is used to change the ownership of the /var/lib/mysql directory and all its contents to the mysql user and group.

Here's a breakdown of the command:

- sudo: This is a command that allows you to run the following command with superuser (root) privileges.
- chown: This is a command that changes the ownership of a file or directory.
- -R: This option stands for "recursive" and means that the ownership change will be applied to the specified directory and all its contents, including subdirectories and files.
- mysql:mysql: This specifies the new owner and group for the directory and its contents. In this case, both the owner and group are set to mysql.
- /var/lib/mysql: This is the directory whose ownership is being changed.

Why is this necessary?

The /var/lib/mysql directory is the default location for MySQL/MariaDB data files. When you initialize the database, the directory and its contents are created with the ownership of the user who ran the initialization command. However, the MySQL/MariaDB service runs under the mysql user and group, so it needs to have ownership of the data directory to function properly.

By running the chown command, you ensure that the mysql user and group have ownership of the data directory and its contents, which allows the MySQL/MariaDB service to access and manage the data files correctly.

Example:

Before running the chown command:

bash
$ ls -ld /var/lib/mysql

This will display the ownership and permissions of the /var/lib/mysql directory.
Output: root is the owner
drwxr-xr-x  3 root root 4096 Jul 31 12:00 /var/lib/mysql

This will display the ownership and permissions of the /var/lib/mysql directory.

After running the chown command:

bash
$ ls -ld /var/lib/mysql
drwxr-xr-x  3 mysql mysql 4096 Jul 31 12:00 /var/lib/mysql

In this output:

- mysql in the third column indicates that the owner of the directory is mysql.
- mysql in the fourth column indicates that the group owner of the directory is mysql.


As you can see, the ownership of the /var/lib/mysql directory has been changed to mysql:mysql, which is the desired ownership for the MySQL/MariaDB service to function properly.
```

**Note:**
```
mysql:mysql is a syntax used in Linux to specify the owner and group of a file or directory.

Breaking it down:

- mysql (before the colon): This specifies the owner of the file or directory. In this case, the owner is the mysql user.
- mysql (after the colon): This specifies the group that owns the file or directory. In this case, the group is also mysql.

What does it mean?

When you see mysql:mysql, it means that:

1. The mysql user is the owner of the file or directory, which means they have control over it and can perform actions like reading, writing, and executing.
2. The mysql group is the group owner of the file or directory, which means that all users who are members of the mysql group will have the same permissions as the group.

Why is this important?

In the context of MySQL/MariaDB, the mysql user and group are used to run the database service. By setting the ownership of the data directory to mysql:mysql, you ensure that the database service has the necessary permissions to access and manage the data files.

Example:

If you have a file /var/lib/mysql/data.db with ownership mysql:mysql, it means that:

- The mysql user can read, write, and execute the file.
- All users who are members of the mysql group can also access the file with the same permissions as the group.

By setting the correct ownership and permissions, you can ensure that your MySQL/MariaDB database service runs smoothly and securely.
```



3. Initialize the MariaDB database:

After creating the directory and setting the ownership, you may need to initialize the MariaDB database. You can do this by running the command:

```
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```
This command will initialize the MariaDB database and create the necessary files and directories.

4. Try starting the MariaDB service again:

After initializing the database, try starting the MariaDB service again with the command:

```
sudo systemctl start mariadb
```

5. If the service starts successfully, you can check its status with:

```
sudo systemctl status mariadb
```
6. Enable the mariadb service to start automatically on boot with the following command

```
sudo systemctl enable mariadb
```

This command will ensure that the mariadb service starts automatically on boot, preventing similar issues in the future.

