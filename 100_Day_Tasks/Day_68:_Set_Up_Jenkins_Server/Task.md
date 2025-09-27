### Task : Day 68: Set Up Jenkins Server

The DevOps team at xFusionCorp Industries is initiating the setup of CI/CD pipelines and has decided to utilize Jenkins as their server. Execute the task according to the provided requirements:



1. Install Jenkins on the jenkins server using the yum utility only, and start its service.

If you face a timeout issue while starting the Jenkins service, refer to this.
2. Jenkin's admin user name should be theadmin, password should be Adm!n321, full name should be Anita and email should be anita@jenkins.stratos.xfusioncorp.com.


Note:

1. To access the jenkins server, connect from the jump host using the root user with the password S3curePass.

2. After Jenkins server installation, click the Jenkins button on the top bar to access the Jenkins UI and follow on-screen instructions to create an admin user.

### Let's break down the task:

Task Overview

The task involves setting up Jenkins as a CI/CD server for xFusionCorp Industries. The requirements include installing Jenkins, starting its service, and configuring an admin user.

Given Information

1. Jenkins server installation method: yum utility

2. Jenkins admin user details:
    - Username: theadmin
    - Password: Adm!n321
    - Full name: Anita
    - Email: anita@jenkins.stratos.xfusioncorp.com
3. Access to the Jenkins server:
    - Connect from the jump host using the root user
    - Password for the root user: S3curePass

What is Asked

1. Install Jenkins on the Jenkins server using yum and start its service.
2. Configure the Jenkins admin user with the specified details (username, password, full name, and email).

Key Points to Note

1. The Jenkins server needs to be accessed from a jump host using the root user credentials.
2. After installing Jenkins, the admin user needs to be created through the Jenkins UI.

By following these steps, you should be able to complete the task and set up Jenkins with the required configuration.

### What I Did
```
[root@jenkins ~]# history | cut -c 8-
cat /etc/os-release # Command to determine the Linux distribution and version

# Since our system is running CentOS Stream 9, you will use yum (or dnf, which is the next-generation version of yum that is used by default on CentOS 8 and later) as your package manager.

sudo yum update
sudo yum install java-17-openjdk -y
java -version
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo yum install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum update
sudo yum install jenkins -y
 sudo systemctl start jenkins
 sudo systemctl enable jenkins
 sudo systemctl status jenkins
# Copy the Administrator password/ initialAdminPassword
cat /var/lib/jenkins/secrets/initialAdminPassword
```

history | cut -c 8-
