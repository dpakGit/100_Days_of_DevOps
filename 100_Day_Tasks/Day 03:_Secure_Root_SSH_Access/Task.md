### Task : Day 3: Secure Root SSH Access

#### Following security audits, the xFusionCorp Industries security team has rolled out new protocols, including the restriction of direct root SSH login.

#### Your task is to disable direct SSH root login on all app servers within the Stratos Datacenter.

#### Solution:

**What i Did**
```
 1.ssh steve@172.16.238.11 

[steve@stapp02 ~]$ 

 1. sudo vi /etc/ssh/sshd_config # by using vi editor and going inside the file i made the changes or you can follow the bello command
    
 2.sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config # Changing the permission from the command line itself

 3.sudo systemctl restart sshd # This is a must command otherwise the changes will not be implemented

 4.sudo grep PermitRootLogin /etc/ssh/sshd_config # To Check/Verify wheteher the Permission has changed or not

 5.history | cut -c 8-
```
I did the same thing for the first three users tony, steve and banner then the task was marked completed .


**Meta AI Solutions**

#### 1. Verifying and Disabling Root Login on App Server 1
To ensure 'root' login is disabled on the Server:

Steps:
1. SSH into App Server 1: ssh username@<App_Server_1_IP>
2. Check SSH config:

bash
sudo grep PermitRootLogin /etc/ssh/sshd_config

- If the output is PermitRootLogin yes, then root login is still enabled.

3. Edit SSH config if necessary:

bash
sudo nano/vi /etc/ssh/sshd_config

    - Change PermitRootLogin yes to PermitRootLogin no.
    - Save and exit the editor.

4. Restart SSH service:

bash
sudo systemctl restart sshd

5. Verify again:

bash
sudo grep PermitRootLogin /etc/ssh/sshd_config

    - Output should be PermitRootLogin no.

Notes
- Ensure you have sudo privileges on the Server.
- Test by attempting to SSH as root to verify login is disabled.
```
Testing SSH as Root to Verify Login is Disabled
To test if root login is disabled via SSH:

Command:

bash
ssh root@<server_IP>

- Replace <server_IP> with the actual IP address of the server (e.g., 172.16.238.14).

Expected Outcome:
- If root login is disabled, you should see a message like:

Permission denied, please try again.

or

Access denied

- If you successfully log in, then root login is still enabled, and you need to revisit the PermitRootLogin no configuration.

Notes
- Ensure you're testing from a different user session to avoid locking yourself out if you're making changes remotely.
- This test verifies the effectiveness of the PermitRootLogin no configuration.

Do you need help with SSH testing, server access, or something else regarding this verification?
```


#### Changing PermitRootLogin to "no" without Nano or Vi directly from the terminal
To change PermitRootLogin yes to PermitRootLogin no without using nano or vi, you can use the sed command:

Command:

bash
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

- -i option edits the file in-place.
- s/old/new/ substitutes "old" with "new" (in this case, PermitRootLogin yes with PermitRootLogin no).

Followed by:

bash
sudo systemctl restart sshd

- Restarts the SSH service to apply the changes.

Notes
- Ensure you have sudo privileges.
- This method is useful for automating changes or when you prefer command-line only interactions.

#### 2. Disabling Direct Root SSH Login on App Servers
To disable direct SSH root login on all app servers in Stratos Datacenter:

Steps for Each App Server:
1. Connect to the app server: SSH into the app server using ssh username@<app_server_IP>.
2. Edit SSH configuration:

bash
sudo nano /etc/ssh/sshd_config

    - Find the line PermitRootLogin yes and change it to:

bash
PermitRootLogin no

    - Save and exit the editor (in nano, press Ctrl+X, then Y, then Enter).
3. Restart SSH service:

bash
sudo systemctl restart sshd

4. Exit SSH session: Use exit to return to the original user.

Notes
- This needs to be done on each app server in Stratos Datacenter.
- Ensure you have a valid username with sudo privileges to make these changes.
- Verify after making changes that root login is disabled by attempting to SSH as root.

#### 3. Disabling Direct Root SSH Login on Multiple App Servers

To disable direct root SSH login on multiple app servers efficiently:

Method 1: Manual SSH for Each Server
Repeat the steps for each app server:
1. SSH into each app server: ssh username@<app_server_IP>
2. Edit SSH config: sudo nano /etc/ssh/sshd_config, change PermitRootLogin yes to PermitRootLogin no.
3. Restart SSH service: sudo systemctl restart sshd
4. Exit: exit

Method 2: Using a Script or Ansible
For multiple servers, automation tools like Ansible or a simple script can save time.

Example Script (assuming you have SSH access and sudo privileges):

bash
#!/bin/bash
**# List of app server IPs**
servers=("192.168.1.1" "192.168.1.2" "192.168.1.3")

for server in "${servers[@]}"; do
  ssh -t username@$server "sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && sudo systemctl restart sshd"
done

- Replace username with your actual username.
- Replace servers array with the IPs of your app servers.

Using Ansible (if configured):

---
- name: Disable root SSH login
  hosts: app_servers
  become: yes
  tasks:
    - name: Update sshd_config
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin yes'
        line: 'PermitRootLogin no'
        state: present
      notify: Restart sshd

  handlers:
    - name: Restart sshd
      service:
        name: sshd
        state: restarted

- Ensure your Ansible inventory (hosts file) has the group app_servers defined with your app server IPs.

Notes
- SSH access and sudo privileges are required.
- Test the changes on one server before applying to multiple servers.

#### 4. Handling Different Usernames on Multiple App Servers or if Usenames are different;

If usernames are different across app servers, the approach needs adjustment:

Method 1: Manual SSH with Different Usernames
For manual method, you'll need to know the username for each app server:
1. SSH into each app server: ssh username1@<app_server1_IP>
2. Edit SSH config: sudo nano /etc/ssh/sshd_config, change PermitRootLogin yes to PermitRootLogin no.
3. Restart SSH service: sudo systemctl restart sshd
4. Exit: exit

Repeat for each server with its respective username.

Method 2: Scripting with Different Usernames
Modify the script to include usernames for each server:

bash
#!/bin/bash
**#List of app server IPs and corresponding usernames**
servers=("username1@192.168.1.1" "username2@192.168.1.2" "username3@192.168.1.3")

for server in "${servers[@]}"; do
  ssh -t $server "sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && sudo systemctl restart sshd"
done

- Replace usernameX with the actual username for each app server.

Method 3: Ansible with Different Usernames
In Ansible, you can specify different usernames for each host in your inventory file:

[app_servers]
app_server1 ansible_host=192.168.1.1 ansible_user=username1
app_server2 ansible_host=192.168.1.2 ansible_user=username2
app_server3 ansible_host=192.168.1.3 ansible_user=username3

Then use the same Ansible playbook as before.

Notes
- Credentials (passwords or SSH keys) should be set up for each username.
- Test connectivity and privileges before running the playbook or script.

#### Where to run the above Script in Method 2
To run the script in Method 2, you'll need to use a terminal or command line interface on a machine that has SSH access to the app servers:

Steps:
1. Open a terminal on your local machine or a server that has SSH access to the app servers.
2. Create a new script file:

bash
nano disable_root_ssh.sh

3. Paste the script into this file:

bash
#!/bin/bash
**List of app server IPs and corresponding usernames**
servers=("username1@192.168.1.1" "username2@192.168.1.2" "username3@192.168.1.3")

for server in "${servers[@]}"; do
  ssh -t $server "sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && sudo systemctl restart sshd"
done

4. Save and exit the editor (in nano, press Ctrl+X, then Y, then Enter).
5. Make the script executable:

bash
chmod +x disable_root_ssh.sh

6. Run the script:

bash
./disable_root_ssh.sh


Notes
- Ensure you have SSH access to the app servers from the machine where you're running the script.
- Test the script on a single server before running it on multiple servers.
- You may be prompted for sudo passwords for each server if SSH keys are not set up.

#### 5. Running the Script in Method 2 ? ? Where to run the script in method 2
To run the script in Method 2, you'll need to use a terminal or command line interface on a machine that has SSH access to the app servers:

Steps:
1. Open a terminal on your local machine or a server that has SSH access to the app servers.
2. Create a new script file:

bash
nano disable_root_ssh.sh

3. Paste the script into this file:

bash
#!/bin/bash
# List of app server IPs and corresponding usernames
servers=("username1@192.168.1.1" "username2@192.168.1.2" "username3@192.168.1.3")

for server in "${servers[@]}"; do
  ssh -t $server "sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && sudo systemctl restart sshd"
done

4. Save and exit the editor (in nano, press Ctrl+X, then Y, then Enter).
5. Make the script executable:

bash
chmod +x disable_root_ssh.sh

6. Run the script:

bash
./disable_root_ssh.sh


Notes
- Ensure you have SSH access to the app servers from the machine where you're running the script.
- Test the script on a single server before running it on multiple servers.
- You may be prompted for sudo passwords for each server if SSH keys are not set up.

Do you need help with script execution, SSH setup, or something else regarding running scripts?
