### Task : Day 4: Script Execution Permissions

#### In a bid to automate backup processes, the xFusionCorp Industries sysadmin team has developed a new bash script named xfusioncorp.sh. While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 1 within the Stratos Datacenter.

#### Your task is to grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 2. Additionally, ensure that all users have the capability to execute it.

Solution:
#### Let's break it down:

Task: Make the /tmp/xfusioncorp.sh script executable on App Server 1.

What needs to be done:

1. Grant executable permissions: Use the chmod command to add execute permissions to the script.
2. Make it executable for all users: Ensure the permissions are set so that all users (owner, group, and others) can execute the script.

Simple steps:

1. Log in to App Server 1.
2. Run the command: sudo chmod a+x /tmp/xfusioncorp.sh

This command adds execute permissions (+x) for all users (a) to the script.

Verify: Run ls -l /tmp/xfusioncorp.sh to check the permissions. You should see x in the permissions string.


**What I did:**

```
1. Become a root user : sudo -s #Note always do things by becoming a root user
2. Connect to App Server 2: SSH into App Server 2 using ssh username@<IP_of_App_Server_2>
   
    ssh steve@172.16.238.11 # Ths is the command

[steve@stapp02 ~]$ # Now we are inside App Server 2

3. Become a root user here also : sudo -s
4. Run the following command, this will grant executable permissions to the script, allowing all users to execute it.

 bash
 chmod a+x /tmp/xfusioncorp.sh

or


bash
sudo chmod a+rx /tmp/xfusioncorp.sh # This command adds read (r) and execute (x) permissions for all users.

5. Verification:
To check if the sudo chmod a+x /tmp/xfusioncorp.sh command worked, you can use the ls -l command to verify the file's permissions:

    ls -l /tmp/xfusioncorp.sh

6. To test the script's executability directly, you can try running it:
 Try running with bash: Instead of running the script directly, try  -
    bash /tmp/xfusioncorp.sh

This gave the output "Welcome to Kodekloud"
```

**Meta AI Solution:**

#### Granting Executable Permissions to xfusioncorp.sh
To grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 1 and ensure all users can execute it, use the following Linux command:

bash
**chmod a+x /tmp/xfusioncorp.sh**

Here's what this command does:

- chmod: Changes the permissions of the file
- a: Represents all users (owner, group, and others)
- +x: Adds executable permission
- /tmp/xfusioncorp.sh: The file you're modifying

After running this command, all users will be able to execute the /tmp/xfusioncorp.sh script.

#### Meta AI: To check if the sudo chmod a+x /tmp/xfusioncorp.sh command worked, you can use the ls -l command to verify the file's permissions:
  
  
  **ls -l /tmp/xfusioncorp.sh**

Look for the permissions section in the output (the first column). If the command worked, you should see x (execute permission) in the permissions for the owner, group, and others (represented as rwx or at least an x in the relevant positions).

For example:
-rwxr-xr-x  1 user  group   123 Jan  1 12:00 /tmp/xfusioncorp.sh

The presence of x in the permissions indicates that the execute permission has been added.

Alternatively, you can also use the stat command:
**stat -c "%A" /tmp/xfusioncorp.sh**

This will display the permissions in a human-readable format.

If you want to test the script's executability directly, you can try running it:
**/tmp/xfusioncorp.sh**

If it runs without permission errors, the chmod command likely worked as expected.

OR

 To grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 1 and ensure all users can execute it, you can use the following command:


bash
**sudo chmod a+x /tmp/xfusioncorp.sh**


This command adds execute permissions (+x) for all users (a stands for all, which includes the owner, group, and others).

After running this command, verify the permissions with:


bash
**ls -l /tmp/xfusioncorp.sh**


You should see x in the permissions for owner, group, and others, indicating that the script is executable by all.


 When you run sudo chmod a+x /tmp/xfusioncorp.sh, the executable permission (x) is given to the file itself, not to a specific user.

The a in a+x stands for "all", meaning the permission change applies to:

- u (owner/user)
- g (group)
- o (others)

So, by adding x permission to a (all), you're making the file executable for everyone (owner, group members, and others).

The file's permissions determine who can execute it, not the user's permissions. Does that clarify things?

 What to do when I want to give permission only to owner or group or other

 To give execute permission to specific entities, you can use the following chmod commands:

- Owner (u): sudo chmod u+x /tmp/xfusioncorp.sh (adds execute permission for the owner)
- Group (g): sudo chmod g+x /tmp/xfusioncorp.sh (adds execute permission for the group)
- Others (o): sudo chmod o+x /tmp/xfusioncorp.sh (adds execute permission for others)

You can also combine these:
- Owner and Group: sudo chmod ug+x /tmp/xfusioncorp.sh
- Owner and Others: sudo chmod uo+x /tmp/xfusioncorp.sh
- Group and Others: sudo chmod go+x /tmp/xfusioncorp.sh

Remember, a stands for all, so a+x applies to owner, group, and others.

**You can also remove permissions** using - instead of +, like sudo chmod o-x /tmp/xfusioncorp.sh to remove execute permission from others.

####  If the output is still saying the script is not executable, let's try to troubleshoot:

1. Verify the command: Double-check that you ran the exact command: **sudo chmod a+x /tmp/xfusioncorp.sh**
2. Check permissions: Run ls -l /tmp/xfusioncorp.sh to confirm the permissions. You should see x in the permissions string (e.g., -rwxr-xr-x).
3. Check SELinux or AppArmor: If your system uses SELinux or AppArmor, it might be restricting execution. You can try disabling or configuring these security tools.
4. **Try running with bash:** Instead of running the script directly, try bash /tmp/xfusioncorp.sh. If it runs fine, the issue might be with the shebang line (#!/bin/bash) or file permissions.


The output ---x--x--x 1 root root 40 Jul 25 12:38 /tmp/xfusioncorp.sh indicates that:

- The file /tmp/xfusioncorp.sh has execute permissions (x) for the owner, group, and others.
- However, it lacks read (r) and write (w) permissions.

Given your original goal, the ---x--x--x permissions might cause issues if the script needs to be read or executed properly.

If you want to ensure the script is **both readable and executable** by all, you can modify the permissions using:


bash
**sudo chmod a+rx /tmp/xfusioncorp.sh**


This command adds read (r) and execute (x) permissions for all users.
