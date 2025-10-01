https://www.youtube.com/watch?v=Abxm13_i8A4

https://www.youtube.com/watch?v=_coKow-BTbI

----------------------------------------

### Steps Explanation

### Creating Remote Host Credentials on Jenkins Server 

<img width="1920" height="1080" alt="Screenshot (301)" src="https://github.com/user-attachments/assets/5ae9eebc-3d78-4102-94c1-326c48727580" />
<br><br>
<img width="1920" height="1080" alt="Screenshot (302)" src="https://github.com/user-attachments/assets/f3b13181-1b22-432b-aa61-3b7c1b0f3f46" />
<br><br>
#### The configuration you're referring to is for adding Credentials in Jenkins. Specifically, you're adding a new set of credentials with the following details:

- Kind: Username with password
- Scope: Global (Jenkins, nodes, items, all child items, etc)
- Username: natasha
- Password: [hidden]
- ID: Storage_Server
- Description: Create REST API Jenkins 2.492.1

This configuration allows you to store a username and password as a credential in Jenkins, which can then be used in jobs or other configurations that require authentication. The credential can be referenced by its ID (Storage_Server) in Jenkins jobs or scripts.

#### Let's break down the credential configuration:

Whose credential is it?

The credential belongs to a user or a system that requires authentication to access a specific resource. In this case, the credential is for a username natasha with a password.

Use case:

The credential can be used in various Jenkins jobs or configurations that require authentication to access a resource, such as:

- Accessing a version control system (e.g., Git) that requires authentication
- Connecting to a remote server or storage system that requires authentication
- Authenticating with an API or a service that requires credentials

Example:

Suppose you have a Jenkins job that needs to access a storage server to upload or download files. The storage server requires authentication with a username and password. By adding the credential Storage_Server with the username natasha and password, you can use this credential in your Jenkins job to authenticate with the storage server.

What if we don't do this?

If you don't add the credential, you'll need to hardcode the username and password in your Jenkins job or script, which is not recommended for security reasons. This approach has several drawbacks:

- Security risk: Hardcoding credentials can expose them to unauthorized access.
- Maintenance issue: If the password changes, you'll need to update the hardcoded credential in multiple places.

By storing the credential in Jenkins, you can:

- Use the credential in multiple jobs or configurations without hardcoding it.
- Easily update the credential if the password changes.
- Improve security by storing sensitive information securely.

In the example above, if you don't add the Storage_Server credential, your Jenkins job might fail to authenticate with the storage server, resulting in errors or failures. By adding the credential, you can ensure that your job can access the storage server securely and reliably.

### Yes, that's a great way to describe it. Creating Remote Host Credentials on Jenkins Server accurately captures the purpose of adding credentials in Jenkins.

In this context, you're creating credentials that allow Jenkins to authenticate with a remote host (e.g., a storage server, a database server, or another system) to perform specific tasks or jobs.

By creating these credentials, you're enabling Jenkins to securely access the remote host and perform actions on your behalf, without exposing sensitive information like passwords.

### Creating or Attaching Credentials in Jenkins is a good way to describe it. This phrase covers both scenarios:

- Creating new credentials in Jenkins for a remote host or system.
- Attaching or using existing credentials in Jenkins for a specific job or configuration.

Either way, the goal is to provide Jenkins with the necessary authentication details to access the remote host or system securely.


<br><br>

<img width="1920" height="1080" alt="Screenshot (311)" src="https://github.com/user-attachments/assets/2ac799c3-03a5-4713-9bcd-32adbc290883" />
<br><br>
<img width="1920" height="1080" alt="Screenshot (310)" src="https://github.com/user-attachments/assets/ed2eb396-9347-4bcd-ac4a-9df46024c841" />
<br><br>


### The part you're referring to is:

SSH remote hosts
- SSH sites: SSH sites that projects will want to connect
- Hostname: 172.16.238.15
- SSH host to connect:
- Port: 22
- Credentials: natasha
- Add Pty:
- serverAliveInterval:
- timeout:
- Check connection: Can't connect to server
- Add

This section is used to configure SSH connections in Jenkins. Here's a breakdown:

- Hostname: The IP address or hostname of the remote server you want to connect to (in this case, 172.16.238.15).
- Port: The port number to use for the SSH connection (default is 22).
- Credentials: The credentials to use for authenticating with the remote server (in this case, natasha).

Use case:

This configuration is useful when you have a Jenkins job that needs to:

- Run scripts or commands on a remote server via SSH.
- Transfer files to or from a remote server using SFTP (Secure File Transfer Protocol).
- Use SSH to connect to a remote server for deployment, monitoring, or other tasks.

By configuring the SSH connection in Jenkins, you can:

- Use SSH-based plugins or scripts in your Jenkins jobs.
- Authenticate with the remote server securely using credentials.
- Run commands or transfer files to or from the remote server.

Example:

Suppose you have a Jenkins job that needs to deploy a web application to a remote server. You can configure the SSH connection in Jenkins to connect to the remote server, and then use a plugin like Publish Over SSH to transfer the application files to the server.

By setting up the SSH connection, you can automate tasks that require remote access, making your Jenkins jobs more efficient and streamlined.


### You're configuring the connection to a remote host on the Jenkins server, and specifying the credentials that were created earlier (natasha).

In other words, you're:

1. Using the credentials (natasha) that were previously configured in Jenkins.
2. Configuring the connection details (hostname, port, etc.) to establish a connection to the remote host.

So, you're not configuring the remote host credentials again, but rather using the existing credentials to establish a connection to the remote host.


### You're:

1. Using the user credentials (natasha) that were previously configured in Jenkins.
2. Configuring the connection details (hostname, port, etc.) for the remote host.
3. Establishing a connection to the remote host using the specified credentials.

And as part of this process, you're also testing the connection (via the "Check connection" button) to ensure that the credentials and connection details are correct and working as expected.

So, it's a combination of using existing credentials, configuring connection details, and testing/establishing the connection to the remote host.


### The "Check connection" button is used to test the connection to the remote host using the specified details (hostname, port, credentials, etc.).

It doesn't establish a persistent connection, but rather verifies that the connection can be made successfully.

If the test is successful, you'll know that the credentials and connection details are correct, and you can proceed with using them in your Jenkins jobs or configurations.

### Execute shell script on remote host using ssh is a build step in Jenkins that allows you to:

- Run a shell script or command on a remote host using SSH.
- Execute the script or command as part of your Jenkins job.

Use case:

This build step is useful when you need to:

- Deploy software or configurations to a remote server.
- Run maintenance tasks or scripts on a remote server.
- Execute commands that require access to a remote server's resources.

In your example, the build step is using SSH to:

- Connect to a remote host (SSH site needs to be specified).
- Run a command to install a package using yum (with the package name passed as a parameter $PACKAGE).

The echo 'Bl@KW' | sudo -S yum install -y $PACKAGE command:

- Uses sudo to run the yum install command with elevated privileges.
- Passes the password Bl@KW to sudo using echo and piping it to sudo -S.

By using this build step, you can automate tasks that require remote access to a server, making your Jenkins job more powerful and flexible.


### With the SSH site value being natasha@ststor01:22, here's what it means:

- natasha: The username to use for the SSH connection.
- ststor01: The hostname or IP address of the remote server.
- 22: The port number to use for the SSH connection (default is 22).

So, the build step Execute shell script on remote host using ssh will:

- Connect to the remote server ststor01 on port 22 using the username natasha.
- Authenticate using the credentials previously configured for natasha.
- Run the command echo 'Bl@KW' | sudo -S yum install -y $PACKAGE on the remote server.

This allows the Jenkins job to remotely execute the command to install a package on the ststor01 server.


### Let's combine the two configurations:

1. SSH remote hosts configuration:
    - Hostname: ststor01 (implied from natasha@ststor01:22)
    - Port: 22
    - Credentials: natasha
2. Execute shell script on remote host using ssh build step:
    - SSH site: natasha@ststor01:22
    - Command: echo 'Bl@KW' | sudo -S yum install -y $PACKAGE

Explanation:

You're configuring Jenkins to:

1. Use the credentials natasha to connect to the remote host ststor01 on port 22 via SSH.
2. Run a shell script/command on the remote host ststor01 as part of a Jenkins job.
3. The command installs a package using yum with the package name passed as a parameter $PACKAGE.
4. The sudo command is used to run the yum install command with elevated privileges, and the password Bl@KW is passed to sudo using echo and piping it to sudo -S.

By combining these configurations, you're enabling Jenkins to remotely execute a command on the ststor01 server to install a package, using the natasha credentials for authentication.

### "Connecting to remote host and running a shell command" is a clear and descriptive name for the step.

It accurately conveys the two main actions:

1. Connecting to the remote host via SSH.
2. Running a shell command on the remote host.

This name is concise yet informative, making it easy to understand the purpose of the step. 👍

### The part you're referring to is:

"Configuring SSH Remote Host Connection"

This step involves setting up a connection to a remote host using SSH, which allows Jenkins to:

- Run shell scripts or commands on the remote host.
- Automate tasks that require access to remote servers.

Elaborate Description:

In this step, you're configuring Jenkins to connect to a remote host with the IP address 172.16.238.15 on port 22 using the credentials natasha. This setup enables Jenkins to establish a secure SSH connection to the remote host, allowing you to run shell scripts or commands as part of your Jenkins jobs.

Use Case:

By configuring this SSH connection, you can automate tasks such as:

- Deploying software or configurations to the remote host.
- Running maintenance tasks or scripts on the remote host.
- Executing commands that require access to remote host resources.

This setup is essential for automating tasks that involve remote servers, making it a crucial step in your Jenkins workflow.

Step Name Suggestions:

- "Configure SSH Remote Host Connection"
- "Setup SSH Connection to Remote Host"
- "Configure Remote Host Access via SSH"

Which one do you think fits best?

The Linux command to see the packages installed on a machine depends on the package manager being used. Here are some common commands:

- For RPM-based systems (e.g., RHEL, CentOS, Fedora):
    - rpm -qa : Lists all installed packages.
    - yum list installed : Lists all installed packages using YUM.
    - dnf list installed : Lists all installed packages using DNF (on newer systems).
- For Debian-based systems (e.g., Ubuntu, Debian):
    - dpkg --list : Lists all installed packages.
    - apt list --installed : Lists all installed packages using APT.

These commands will display a list of installed packages on your Linux system.


