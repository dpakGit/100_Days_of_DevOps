## Day 7: Linux SSH Authentication

### Task :

**The system admins team of xFusionCorp Industries has set up some scripts on jump host that run on regular intervals and perform operations on all app servers in Stratos Datacenter. To make these scripts work properly we need to make sure the thor user on jump host has password-less SSH access to all app servers through their respective sudo users (i.e tony for app server 1). Based on the requirements, perform the following:**

**Set up a password-less authentication from user thor on jump host to all app servers through their respective sudo users.** 

-------------------------------------------------

### Here's a more elaborate and easy-to-understand version of the task with a real-life example:

"Configure password-less SSH authentication from the 'thor' user account on the jump host server to all application servers, allowing the 'thor' user to seamlessly access each app server through their designated sudo users (e.g., 'tony' for App Server 1, 'steve' for App Server 2, etc.) without being prompted for a password, thereby streamlining administrative tasks and improving efficiency in managing multiple servers."

In this example, the jump host serves as a central access point for administrators, and the 'thor' user can use SSH keys to authenticate with each app server without entering a password. This setup is commonly used in production environments where administrators need to manage multiple servers efficiently and securely.

For instance, in a real-world scenario:

- A DevOps team uses a jump host to access multiple production app servers.
- The team lead, 'thor', needs to run scripts and commands on each app server without having to enter passwords repeatedly.
- By setting up password-less authentication, 'thor' can access each app server through their respective sudo users, saving time and improving      productivity.


-------------------------------------------------
**Solution:**

To set up password-less SSH access from the thor user on the jump host to all app servers through their respective sudo users, you'll need to generate SSH keys and copy the public key to the authorized_keys file on each app server. Here's a step-by-step guide:

Step 1: Generate SSH keys on the jump host

- Machine: Jump Host
- User: thor
- Command: Run the following command as the thor user on the jump host:

```
ssh-keygen -t rsa
```

This command generates a pair of SSH keys (public and private) in the ~/.ssh directory. You'll be prompted to enter a file name and a passphrase. You can press Enter to accept the default file name and leave the passphrase empty.

- Output: The command will generate two files: id_rsa (private key) and id_rsa.pub (public key) in the ~/.ssh directory.

Step 2: Copy the public key to each app server

Method :1

- Machine: Jump Host
- User: thor
- Command:

```
cat ~/.ssh/id_rsa.pub
```

This command displays the contents of the public key file. Copy the output.

- Machine: App Server 1 (e.g., app-server-1)
- User: tony
- Command:

```
mkdir -p ~/.ssh
echo "paste_public_key_here" >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

Replace paste_public_key_here with the actual public key contents copied from the jump host. These commands create the ~/.ssh directory if it doesn't exist, append the public key to the authorized_keys file, and set the correct permissions.

Repeat this process for each app server, using the respective sudo user credentials.

Method 🔢
**Alternatively**, you can use the ssh-copy-id command on the jump host to copy the public key to each app server:

- Machine: Jump Host
- User: thor
- Command:

```
ssh-copy-id tony@app-server-1 # Use the public IP in place of "app-server-1"
ssh-copy-id steve@app-server-2
ssh-copy-id banner@app-server-3
```

This command will prompt you for the password of the respective sudo user on each app server.

Output of the above command:

```
 ssh-copy-id tony@172.16.238.10 
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
tony@172.16.238.10's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'tony@172.16.238.10'"
and check to make sure that only the key(s) you wanted were added.
```
Step 3: Verify password-less SSH access

- Machine: Jump Host
- User: thor
- Command:

```
ssh tony@app-server-1 # Use the public IP in place of "app-server-1"
ssh steve@app-server-2
ssh banner@app-server-3
```

If everything is set up correctly, you should be able to log in to each app server without entering a password.

By following these steps, you should have set up password-less SSH access from the thor user on the jump host to all app servers through their respective sudo users.

Tips:

- Make sure the ~/.ssh directory and authorized_keys file have the correct permissions (e.g., chmod 700 ~/.ssh and chmod 600 ~/.ssh/authorized_keys).
- If you're using a non-standard SSH port, specify it in the ssh-copy-id command or the ssh command.
- You can also use ssh-agent and ssh-add to manage your SSH keys and enable password-less authentication.

By following these steps, you should have set up password-less SSH access from the thor user on the jump host to all app servers through their respective sudo users.

-------------------------------------------------
**Note:**
When you use the ssh-copy-id command, you don't need to manually paste the public key into the authorized_keys file. The ssh-copy-id command will automatically copy the public key to the authorized_keys file on the remote server.

Here's what happens when you run ssh-copy-id banner@app-server-3:

1. The ssh-copy-id command reads the contents of your local ~/.ssh/id_rsa.pub file (or the default public key file).
2. It then establishes an SSH connection to app-server-3 as the banner user.
3. Once connected, it appends the public key to the ~/.ssh/authorized_keys file on app-server-3, creating the ~/.ssh directory and authorized_keys file if they don't already exist.
4. The ssh-copy-id command also sets the correct permissions for the ~/.ssh directory and authorized_keys file.

So, in this case, you don't need to manually add or paste the public key anywhere. The ssh-copy-id command takes care of it for you.

Just run the command:

```
ssh-copy-id banner@app-server-3
```

And you'll be prompted for the password of the banner user on app-server-3. Once you enter the password, the public key will be copied to the authorized_keys file, and you'll be able to use password-less SSH login.

-------------------------------------------------
**Note:**

When you use the ssh-copy-id command, it will automatically set the correct permissions for the ~/.ssh directory and authorized_keys file on the remote server.

So, in this case, you don't need to manually run the chmod commands to set the permissions. The ssh-copy-id command will take care of it for you.

The ssh-copy-id command will set the permissions as follows:

- ~/.ssh directory: 700 (drwx------)

- ~/.ssh/authorized_keys file: 600 (-rw-------)

These permissions are required for SSH to work correctly and securely.

So, you can simply run the ssh-copy-id command:

```
ssh-copy-id banner@app-server-3
```

And it will take care of copying the public key and setting the correct permissions for you.

 -------------------------------------------------
 
### Verifying the Permission

If you want to verify the permissions, you can log in to app-server-3 as the banner user and run:

```
ls -ld ~/.ssh
ls -l ~/.ssh/authorized_keys
```

This will show you the permissions of the ~/.ssh directory and authorized_keys file, which should be 700 and 600 respectively.

Output:
The output you're seeing is in a different format than the numeric permissions (600 and 700).

The ls -ld and ls -l commands display permissions in a symbolic format, which is:

- d for directory
- r for read permission
- w for write permission
- x for execute permission
- - for no permission

The permissions are displayed in the following order:

- Owner permissions (first 3 characters)
- Group permissions (next 3 characters)
- Other permissions (last 3 characters)

In your case:

- drwx------ means:
    - d indicates it's a directory
    - rwx indicates the owner has read, write, and execute permissions (700)
    - --- indicates the group and others have no permissions
- -rw------- means:
    - - indicates it's a file
    - rw- indicates the owner has read and write permissions (600)
    - --- indicates the group and others have no permissions

So, the permissions are indeed 700 for the directory and 600 for the file, but they're being displayed in a symbolic format instead of numeric.

Numeric Output :

If you want to see the numeric permissions, you can use the stat command:

```
bash
stat -c "%a" ~/.ssh
stat -c "%a" ~/.ssh/authorized_keys
```
This will display the permissions in numeric format (e.g., 700 and 600).

-------------------------------------------------
**Note:**

#### Having passwordless access to a server or system doesn't necessarily mean having admin access.

Passwordless access typically means that a user can access a system or server without entering a password, usually through key-based authentication (like SSH keys). This can be convenient for automation, scripting, or frequent access.

Admin access, on the other hand, refers to having elevated privileges to perform administrative tasks, such as:

- Modifying system configurations
- Installing software
- Managing user accounts
- Accessing sensitive data

Having passwordless access might grant a user access to a system, but the level of access and privileges would depend on the user's account permissions and configuration.

To illustrate the difference:

- A user with passwordless access to a server might only have read-only access to certain files or directories.
- Another user with passwordless access might have sudo privileges, allowing them to perform administrative tasks.

In summary, passwordless access is about authentication, while admin access is about authorization and privileges.

In your case, if the thor user has passwordless access to the app servers through their respective sudo users, it's likely that the thor user will have the same level of access and privileges as the sudo users on those servers. However, without more information about the specific configuration and permissions, it's difficult to say for certain whether this equates to admin access.

-------------------------------------------------
#### Troubleshoot
The error message Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password) indicates that the SSH connection attempt is failing due to authentication issues.

Here are a few potential causes:

1. Public key not added correctly: Make sure the public key is added to the authorized_keys file on the remote server (app-server-1 in this case) and that the file has the correct permissions.
2. Private key not found: Ensure that the private key (id_rsa) is present in the ~/.ssh directory on the jump host and that the file has the correct permissions.
3. Incorrect username or hostname: Verify that the username (tony) and hostname (172.16.238.10) are correct.
4. Password authentication disabled: If password authentication is disabled on the remote server, you'll need to use key-based authentication.

To troubleshoot, you can try the following:

1. Verbose SSH output: Run the SSH command with the -v option to get more verbose output:

```
ssh -v tony@172.16.238.10
```

This can help you identify the issue.

2. Check authorized_keys file: Verify that the public key is correctly added to the authorized_keys file on the remote server. You can do this by logging in to the remote server using password authentication and checking the file.

3. Check private key permissions: Ensure that the private key (id_rsa) has the correct permissions (600) on the jump host.

If you're still having issues, feel free to provide more details, and I'll do my best to help you troubleshoot!


1. Verify the public key: Make sure the public key that's been added to the authorized_keys file matches the private key being used on the jump host.
2. Check for extra whitespace: Ensure there are no extra whitespace characters in the authorized_keys file, especially at the end of the line containing the public key.
3. Try SSH with verbose output: Run the SSH command with the -v option to get more verbose output, which might help identify the issue:

```
ssh -v banner@app-server-3
```

If you're still having issues, feel free to provide more details, and I'll do my best to help you troubleshoot!

-------------------------------------------------
#### Troubleshoot (IMP)

ERROR: ssh-copy-id tony@172.16.238.10 

/usr/bin/ssh-copy-id: ERROR: No identities found

Solution:

The error message "No identities found" typically indicates that ssh-copy-id is unable to find any SSH identities (public keys) to copy to the remote server.

This can happen if:

1. You haven't generated SSH keys on the local machine (jump host).
2. The SSH keys are not in the default location (~/.ssh/id_rsa and ~/.ssh/id_rsa.pub).

To resolve this issue:

1. Generate SSH keys: If you haven't already, generate SSH keys on the jump host using the command:

```
ssh-keygen -t rsa
```

Press Enter to accept the default file name and location.

2. Specify the identity file: If your SSH keys are in a non-default location or have a different name, you can specify the identity file using the -i option:

```
ssh-copy-id -i ~/.ssh/your_key.pub tony@172.16.238.10
```
Replace ~/.ssh/your_key.pub with the actual path to your public key file.

After generating SSH keys or specifying the identity file, try running the ssh-copy-id command again:

```
ssh-copy-id tony@172.16.238.10
```

This should copy the public key to the remote server, allowing you to set up password-less SSH authentication.
