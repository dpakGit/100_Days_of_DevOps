### Task: Day 1: Linux User Setup with Non-Interactive Shell

#### To accommodate the backup agent tool's specifications, the system admin team at xFusionCorp Industries requires the creation of a user with a non-interactive shell. Here's your task:

### Create a user named kirsty with a non-interactive shell on App Server 3.

Sol:
Breaddown of the above task:

Explanation of the Lines
The given lines describe a scenario where:

Context
- xFusionCorp Industries: A fictional company with a system admin team.
- Backup agent tool: A tool used for backups, likely requiring a specific setup for operation.

Requirement
- The system admin team needs to create a user with a non-interactive shell.
- Purpose: To accommodate the specifications of the backup agent tool.

Task
- The task given to you was to create a user named kirsty with a non-interactive shell on App Server 3 in this fictional scenario.

Implications
- Non-interactive shell: Means the user kirsty can't log in interactively to the server. This is often used for service accounts or for security reasons when interactive login isn't needed.

Steps:
1. Connect to App Server 3: SSH into App Server 3 using ssh username@172.16.238.12, where username is a valid user on App Server 3.

IP Address Context
172.16.238.12 is the IP address of App Server 3, not of a user.
Explanation
- Server IP: Used to connect to App Server 3 via SSH or other network means.
- User context: Users don't have IP addresses in this context; they have usernames, passwords, and permissions on the server.
  

2. *Create user kirsty*:

    - Check existing users:
    ```
     cut -d: -f1 /etc/passwd
    ```
    - Create user kirsty with non-interactive shell:

   ```
    sudo useradd -s /sbin/nologin kirsty 
   ```

Explanation
- useradd: Command to create a new user.
- -s /sbin/nologin: Sets the user's shell to /sbin/nologin, a non-interactive shell preventing login.

    
- Verify user creation: cut -d: -f1 /etc/passwd

4. Exit SSH session: Use exit to return to the original user.

Notes
- To SSH into App Server 3, you need a valid username, IP address (172.16.238.12), and credentials.
- Commands are for a Linux environment.

Do you need help with refining these steps further, or something else regarding user creation on App Server 3?


## Q and A with Meta AI:

#### Creating a User with a Non-Interactive Shell
To create a user named kirsty with a non-interactive shell on App Server 3, you can use the following command:


bash
sudo useradd -s /sbin/nologin kirsty


Explanation
- useradd: Command to create a new user.
- -s /sbin/nologin: Specifies the shell for the user as /sbin/nologin, which is a non-interactive shell. This means the user kirsty cannot log in interactively to the server.

Context
This is typically used for service accounts or users that need to exist for system purposes but shouldn't allow interactive login.


#### Linux commands for viewing Users in Linux
To view users in Linux, you can use the following commands:

1. *View users in /etc/passwd*

bash
cat /etc/passwd


This file contains information about users on the system.

2. *List users with getent*

bash
getent passwd


This command retrieves user information from the system's user database.

3. List only usernames

bash
cut -d: -f1 /etc/passwd


This command extracts just the usernames from /etc/passwd.


#### Changing or Prompting or asking for a User's Password in Linux

To prompt for a user's password in the terminal, you typically use the passwd command to change a user's password.

Command

bash
sudo passwd username


Replace username with the actual username.

What Happens
1. Password prompt: The command will prompt you to enter a new password for the specified user.
2. Re-enter password: You'll be asked to re-enter the password for confirmation.

Notes
- You need to have appropriate permissions (typically root or sudo) to change another user's password.
- To change your own password, you can use passwd without sudo or specifying a username.


#### Linuc command for viewing IP Addresses

To view IP addresses on a Linux system, you can use several commands depending on what you're looking for:

1. View IP addresses of all interfaces

bash
ip addr show


or the shorter version:


bash
ip a


2. View IP address of a specific interface

bash
ip addr show eth0


Replace eth0 with the interface name you're interested in.

3. View routing table

bash
ip route

#### Steps to Create User 'banner' with password

1. Connect to App Server 3: Assuming you have access.
2. Create user 'banner' with password 'BigGr33n':


bash
sudo useradd banner
echo 'banner:BigGr33n' | sudo chpasswd


Explanation
- useradd banner: Creates the user banner.
- chpasswd: Sets the password for user banner to BigGr33n.

#### Steps for Connecting to App Server 3

To connect to App Server 3 with IP 172.16.238.12, you typically use a secure method like SSH (Secure Shell).

Method: SSH Connection

bash
ssh username@172.16.238.12


- Replace username with a valid username on App Server 3 that has SSH access.

Requirements
1. SSH access: Ensure SSH is enabled on App Server 3.
2. Credentials: You need valid credentials (username/password or SSH key) for App Server 3.

Notes
- If connecting from a different network, ensure there's network connectivity to 172.16.238.12.
- 172.16.238.12 is a private IP, so connection might be limited to within the same network or via VPN if applicable.

- I got the following error:
  
- ssh banner@172.16.238.12
The authenticity of host '172.16.238.12 (172.16.238.12)' can't be established.
ED25519 key fingerprint is SHA256:t8rop7+/lSZCWCfNSscpLT2TbNx6WvgpDVeyYjjEglE.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
Host key verification failed.

Solution:

#### SSH Host Key Verification Failed
You're seeing a message about the host key of 172.16.238.12 not being established or known.

Explanation
- Host key verification: SSH checks the host's key to verify you're connecting to the intended server, preventing man-in-the-middle attacks.
- Message meaning: You've connected to a server whose host key isn't in your known_hosts file.

How to Proceed
1. If you trust the server: Type yes to continue connecting and add the host key to known_hosts.
2. Verify fingerprint (optional but recommended): If you have access to App Server 3's console or an admin has provided the expected fingerprint, compare it with SHA256:t8rop7+/lSZCWCfNSscpLT2TbNx6WvgpDVeyYjjEglE to ensure authenticity.

Next Steps
If you want to connect:

bash
Type 'yes' when prompted: Are you sure you want to continue connecting (yes/no/[fingerprint])?


Then you'll be prompted for banner user's password (BigGr33n as per earlier details).

#### Verifying SSH Fingerprint
To verify the SSH fingerprint of App Server 3 (172.16.238.12), you'd typically compare the given fingerprint (SHA256:t8rop7+/lSZCWCfNSscpLT2TbNx6WvgpDVeyYjjEglE) with the actual fingerprint of the server.

Ways to Get Actual Fingerprint from App Server 3
1. From App Server 3 console (if you have access):

bash
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub

This shows the fingerprint of the ED25519 host key.

Why Verify
- Security: Verifying ensures you're connecting to the genuine server, mitigating man-in-the-middle attacks.

Action
If you've verified or trust the fingerprint is correct for App Server 3:
- Type yes when prompted Are you sure you want to continue connecting (yes/no/[fingerprint])?

#### Returning to Original User from App Sever 3

If you've switched to a different user (like banner) via SSH or su command, and want to return to your original user:

If via SSH
- You'd typically disconnect from the SSH session (exit or Ctrl+D).


bash
exit


*If via su command*
- Use exit to return to the previous user.


bash
exit


Context
Since you SSHed as banner@172.16.238.12, typing exit will close the SSH connection to App Server 3.
