
## The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:

 a. Install tomcat server on App Server 2.

 b. Configure it to run on port 3003.

 c. There is a ROOT.war file on Jump host at location /tmp.

 Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp02:3003


**What I Did**
--------------------------------------------
Step-1 :

ssh steve@172.16.238.11

Step-6 :

From Jump host, use scp to copy /tmp/ROOT.war to App Server 2's Tomcat webapps directory.

sudo scp /tmp/ROOT.war steve@172.16.238.11:/var/lib/tomcat/webapps/

curl http://stapp02:3003

history | cut -c 8-

**Note: Before applying this copy command on Jump-Host make sure to run the Change ownership command on App Server-2 "i:e; Step-5"**

[steve@stapp02 ~]$ history | cut -c 8-  App Server - 2

Step -2 :

sudo yum update && sudo yum install -y tomcat

Step-3 :

systemctl status tomcat

sudo systemctl start tomcat

systemctl status tomcat

ls /etc/ # to verify tomcat dir exits

ls /etc/tomcat/ # to verify server.xml file exits

Step-4 :

sudo vi /etc/tomcat/server.xml # Change port from 8080 to 3003

Output:

```
 -->
    <Connector port="3003" protocol="HTTP/1.1" # Changed port 8080 to 3003
               connectionTimeout="20000"
               redirectPort="8443"
               maxParameterCount="1000"
               />
```

sudo systemctl restart tomcat

systemctl status tomcat

ls /var/lib/tomcat/ # to verify the webapps dir exits

exit

Step-5 :

Change ownership of the directory. :If you want steve to have full control over the webapps directory on 172.16.238.11, run:

sudo chown -R steve /var/lib/tomcat/webapps/

**OR**
How run the command sudo chown -R steve /var/lib/tomcat/webapps/ on App Server 2 (stapp02) from Jump-host.

You can do it via SSH.Here's how:

- SSH into App Server 2 from Jump-host:

```
bash
ssh steve@stapp02 "sudo chown -R steve /var/lib/tomcat/webapps/"
```
What it does: This command connects to stapp02 via SSH and runs the chown command on the remote server. You'll likely be prompted for steve's password (or use SSH keys if configured).



Step-7 :

To verify if Root.war file is copied

ls /var/lib/tomcat/webapps/ 

exit


----------------------------------------------------------



#### The following link will take you to the documentation of how to perform the task :  https://tundedamian.medium.com/day-11-of-100-days-of-devops-deploying-a-java-app-on-tomcat-18d7e36eccc7




------------------------


**MetaAI Solutions:**

#### Task: Install Tomcat on App Server 2, configure it to run on port 6000, and deploy ROOT.war from Jump host.

a. Install Tomcat server on App Server 2

1. Connect to App Server 2:
    - Command: ssh <username>@stapp02
    - What it does: This connects you to App Server 2 (stapp02) via SSH as user <username>.

2. Install Tomcat:
    
bash
sudo yum update 
sudo yum install -y tomcat

    - What it does:
        - sudo yum update: Updates the package lists on your system.
        - sudo yum install tomcat: Installs Tomcat 9 on App Server 2.

b. Configure Tomcat to run on port 6000

1. Edit Tomcat's server.xml:

    - Command: sudo vi /etc/tomcat9/server.xml
    - What it does: Opens the Tomcat configuration file (server.xml) in the vi editor with superuser privileges.

2. Change the HTTP port: Look for <Connector port="8080" and change it to port 6000.

<Connector port="3003" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />


    - Find <Connector port="8080" and change it to port="3003".
    - What it does: Configures Tomcat to listen for HTTP requests on port 6000 instead of the default 8080.

3. Restart Tomcat:

    - Command: sudo systemctl restart tomcat9
    - What it does: Restarts the Tomcat service to apply the configuration changes.

c. Deploy ROOT.war from Jump host and make webpage work on base URL

1. Copy ROOT.war to App Server 2:

    - Command (from Jump host): scp /tmp/ROOT.war <username>@stapp02:/var/lib/tomcat9/webapps/
    - What it does: Securely copies ROOT.war from Jump host's /tmp to App Server 2's Tomcat webapps directory.

2. Deploy ROOT.war:
    - What it does: Tomcat automatically deploys any WAR file placed in its webapps directory. Since we named it ROOT.war, it'll be available at the base URL (http://stapp02:6000).

3. Verify:
    - Command: curl http://stapp02:6000
    - What it does: Fetches the webpage at the base URL of App Server 2 on port 6000, checking if the deployment was successful.

----------------------------

### Note: The command sudo scp /tmp/ROOT.war steve@172.16.238.11:/var/lib/tomcat/webapps/ is:

Here's a breakdown:
- sudo scp: Uses scp with superuser privileges (though scp doesn't typically need sudo unless dealing with restricted files).
- /tmp/ROOT.war: Source file on the local machine (Jump host).
- steve@172.16.238.11: Destination is server 172.16.238.11 as user steve.
- /var/lib/tomcat/webapps/: Destination path on 172.16.238.11.

Things to check:
1. Path correctness: Make sure the Tomcat webapps path on 172.16.238.11 is indeed /var/lib/tomcat/webapps/. It could be /var/lib/tomcat9/webapps/ depending on the Tomcat version.
2. User permissions: User steve on 172.16.238.11 needs write permission to the destination directory.

If everything matches up (path is correct, user has permissions, and server IP is App Server 2), the command should work.

------------------------

### Note: *Giving write permission to user steve on 172.16.238.11 for the destination directory.*
You can adjust permissions in a couple of ways depending on what's best for your setup.

### Option 1: Change ownership of the directory
If you want steve to have full control over the webapps directory:
- On 172.16.238.11, run:

bash
sudo chown -R steve /var/lib/tomcat/webapps/

- What it does: Makes steve the owner of the webapps directory and its contents.

*Option 2: Add write permissions for steve if he's part of a group*
If steve is part of a group that has access to the directory (like tomcat group):
- On 172.16.238.11, run:

bash
sudo chmod -R g+w /var/lib/tomcat/webapps/

- What it does: Adds write permission for the group on the webapps directory.

Option 3: Use ACLs for more granular control
If you need more fine-grained control without changing ownership:
- Install ACL tools if needed (sudo apt install acl on Debian/Ubuntu).
- On 172.16.238.11, run:

bash
sudo setfacl -m u:steve:w /var/lib/tomcat/webapps/

- What it does: Gives steve write permission via ACL.

### *You need to run the command sudo chown -R steve /var/lib/tomcat/webapps/ on the server 172.16.238.11.*
Here's how:
1. Connect to 172.16.238.11: ssh steve@172.16.238.11 or as another user with sudo privileges like ssh <sudo-user>@172.16.238.11.
2. Run the command: Once connected to 172.16.238.11, run:

bash
sudo chown -R steve /var/lib/tomcat/webapps/


Notes
- Make sure you're connected to the correct server (172.16.238.11) before running the command.
- The command changes ownership of /var/lib/tomcat/webapps/ to steve.
- You need sudo privileges on 172.16.238.11 to run this command.


-------------------------------------------

**Note:**

Explanation of the lines:
1. Tomcat automatically deploys any WAR file placed in its webapps directory.
    - When you put a .war file in Tomcat's webapps folder, Tomcat detects it and automatically unpacks and deploys the web application.
    - This means you don't need to do anything extra to deploy the app besides copying the WAR file to the right place.

2. Since we named it ROOT.war, it'll be available at the base URL (http://stapp02:6000).
    - In Tomcat, if you name a WAR file ROOT.war, it becomes the "root" application of the server.
    - This means when you access the base URL of the Tomcat server (like http://stapp02:6000), you'll see the application deployed in ROOT.war.
    - If you used a different name (like myapp.war), you'd access it via http://stapp02:6000/myapp.

Example
- We copied ROOT.war to webapps.
- Now, going to http://stapp02:6000 in a browser or via curl shows the application from ROOT.war.

--------------------------------------------

### Tomcat service status output indicates Tomcat isn't running.

Here's what the output tells us:
- Active: inactive (dead): The Tomcat service is not running on stapp02.
- Loaded: loaded (/usr/lib/systemd/system/tomcat.service; disabled; preset: disabled): The service file exists but is disabled (meaning it won't start on boot).

What to do
- Start Tomcat: Try starting Tomcat with:

bash
sudo systemctl start tomcat

- Check status again: After starting, check status again:

bash
systemctl status tomcat

- If it doesn't start, check logs in /var/log/tomcat for errors.

Do you need help troubleshooting if Tomcat won't start, or want to check the logs for issues?
