### Task : Day 71: Configure Jenkins Job for Package Installation

Some new requirements have come up to install and configure some packages on the Nautilus infrastructure under Stratos Datacenter. The Nautilus DevOps team installed and configured a new Jenkins server so they wanted to create a Jenkins job to automate this task. Find below more details and complete the task accordingly:

1. Access the Jenkins UI by clicking on the Jenkins button in the top bar. Log in using the credentials: username admin and password Adm!n321.

2. Create a new Jenkins job named install-packages and configure it with the following specifications:

Add a string parameter named PACKAGE.
Configure the job to install a package specified in the $PACKAGE parameter on the storage server within the Stratos Datacenter.

Note:

1. Ensure to install any required plugins and restart the Jenkins service if necessary. Opt for Restart Jenkins when installation is complete and no jobs are running on the plugin installation/update page. Refresh the UI page if needed after restarting the service.

2. Verify that the Jenkins job runs successfully on repeated executions to ensure reliability.

3. Capture screenshots of your configuration for documentation and review purposes. Alternatively, use screen recording software like loom.com for comprehensive documentation and sharing.



https://www.youtube.com/watch?v=Abxm13_i8A4

https://www.youtube.com/watch?v=_coKow-BTbI

### What I Did

#### Installing Packages on Remote Machines using Jenkins

Table of Contents

- Prerequisites

- Step-1-install-ssh-plugins

- Step-2-create-remote-host-credentials

- Step-3-configure-ssh-remote-host-connection

- Step-4-create-a-jenkins-job

- Step-5-add-a-string-parameter

- Step-6-connect-to-remote-host-and-run-shell-command

- Step-7-verify-nginx-installation

- Step-8-build-and-test-the-job

Prerequisites

- Jenkins installed and running
- SSH access to remote machine

Step 1: Install SSH Plugins (Prerequisite)

1. Go to Dashboard > Manage Jenkins > Plugins > Available Plugins
2. Search for "SSH" and select the following plugins:
    - SSH
    - SSH Credentials
    - SSH Build Agents
    - SSH Agents # This plugin allow you to provide SSH credentials to build via a ssh-agent in Jenkins


  <img width="1920" height="1080" alt="Screenshot (299)" src="https://github.com/user-attachments/assets/3e3ed5bb-f831-4f6e-b22c-702223b91b53" />


Step 2: Create Remote Host Credentials on Jenkins Server

1. Go to Manage Jenkins > Credentials > System > Global credentials
2. Click Add Credentials
3. Select Username with password as the credential type
4. Fill in the details:
    - Username: Enter the username for your storage server (e.g., natasha)
    - Password: Enter the password for the username
    - ID: Give a unique ID to the credential (optional but recommended)

5. Click OK to save the credential

<img width="1920" height="1080" alt="Screenshot (301)" src="https://github.com/user-attachments/assets/4abd9f34-be5f-4ea5-bdb0-89e2e740aad2" />

<br><br>

<img width="1920" height="1080" alt="Screenshot (302)" src="https://github.com/user-attachments/assets/434472b6-b898-49f1-a9b8-5c0603dcd5bd" />

Step 3: Configure SSH Remote Host Connection and Checking the Connection

1. Manage Jenkins > System
2. Scroll down to "SSH remote hosts"
3. Click on Add
    - Host Name: ststor01.stratos.xfusioncorp.com
    - Port: 22
    - Credentials: Select the credential name from the dropdown arrow (e.g., natasha)

   <img width="1920" height="1080" alt="Screenshot (311)" src="https://github.com/user-attachments/assets/cfee0b18-6d02-4369-8e6e-0b3165f3239c" />

  
4. Scroll down and click on the "Check Connection" button to confirm connection is established



<img width="1920" height="1080" alt="Screenshot (310)" src="https://github.com/user-attachments/assets/eb67d9a1-3f1b-4f50-9bd9-caeb3c26a917" />

Confirm with the message - "Successful connection"

5. Click on "Save"

Step 4: Create a Jenkins Job

1. Go to your Jenkins dashboard and click on New Item
2. Choose Freestyle project and name your job (e.g., "install-packages")
3. Click OK to create the job

Step 5: Add a String Parameter

1. Go to the Job > Configure
2. Check the "This Project is Parameterized" box
3. Select "String Parameter"
    - Name: PACKAGE
    - Default value: Default
4. Save

Step 6: Connect to Remote Host and Run Shell Command

1. Go to the Job > Configure > Build Steps
2. Select "Execute shell script on remote host using ssh" option

3.- SSH site: "natasha@ststor01.stratos.xfusioncorp.com:22"

- Command: echo 'Bl@KW' | sudo -S yum install -y $PACKAGE

5. Save

<img width="1920" height="1080" alt="Screenshot (312)" src="https://github.com/user-attachments/assets/5167dc0b-1286-405a-a060-83fae350dbe9" />

Step 7: Verify Nginx Installation

1. Go to the jumphost terminal
2. SSH to the storage server (ssh natasha@172.16.238.15)
3. Run the command: systemctl status nginx (this will give an error as nginx is still not installed)

<img width="1920" height="1080" alt="Screenshot (317)" src="https://github.com/user-attachments/assets/108419b0-062b-4661-9c5c-5070e3d3b997" />

Step 8: Build and Test the Job

1. Go back to the Jenkins Job and click on "Build with Parameters"
2. Remove the default package name and input nginx
<img width="1920" height="1080" alt="Screenshot (309)" src="https://github.com/user-attachments/assets/59dd702c-7332-4c3e-a1d1-a6cc0c4eda5f" />
-
- In place of package_name write nginx 
-
3. Click on Build
4. Once the build is successful, check the logs for confirmation   

<img width="1920" height="1080" alt="Screenshot (316)" src="https://github.com/user-attachments/assets/2070ce1c-8a6e-4a60-8704-bba04b43761d" />

<img width="1920" height="1080" alt="Screenshot (315)" src="https://github.com/user-attachments/assets/a727db72-0f78-460e-a95a-a3544a811224" />

5. Go back to the jumphost terminal and run: systemctl status nginx (this will show nginx is installed)
6. Run: systemctl start nginx and systemctl status nginx (this will show nginx is "active")
<img width="1920" height="1080" alt="Screenshot (319)" src="https://github.com/user-attachments/assets/4ade698d-03fc-4343-aa33-41cc79f1e094" />


<img width="1920" height="1080" alt="Screenshot (330)" src="https://github.com/user-attachments/assets/e146b1c4-1456-4983-9f0b-46e0e914b659" />

7. Similarly build once more with "httpd" as the package


<img width="1920" height="1080" alt="Screenshot (328)" src="https://github.com/user-attachments/assets/c5d317c0-8d06-4a55-a7f5-a4a567198b45" />

<img width="1920" height="1080" alt="Screenshot (321)" src="https://github.com/user-attachments/assets/7717e3e4-fb90-4169-b36e-8f63a07b4fb3" />
Following Image shows that httpd is installed
<img width="1920" height="1080" alt="Screenshot (322)" src="https://github.com/user-attachments/assets/9ce917c2-0866-4cd1-adf4-91c62fc9d829" />

