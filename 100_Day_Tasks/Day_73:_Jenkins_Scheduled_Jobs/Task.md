### Task : Day 73: Jenkins Scheduled Jobs

The devops team of xFusionCorp Industries is working on to setup centralised logging management system to maintain and analyse server logs easily. Since it will take some time to implement, they wanted to gather some server logs on a regular basis. At least one of the app servers is having issues with the Apache server. The team needs Apache logs so that they can identify and troubleshoot the issues easily if they arise. So they decided to create a Jenkins job to collect logs from the server. Please create/configure a Jenkins job as per details mentioned below:



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321

1. Create a Jenkins jobs named copy-logs.

2. Configure it to periodically build every 2 minutes to copy the Apache logs (both access_log and error_logs) from App Server 1 (from default logs location) to location /usr/src/security on Storage Server.

Note:

1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case please make sure to refresh the UI page.

2. Please make sure to define you cron expression like this */10 * * * * (this is just an example to run job every 10 minutes).

3. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.


### What I Did


```
thor@jumphost ~$ ssh tony@stapp01

# Check the files are present or not

[tony@stapp01 ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; pr>
     Active: active (running) since Thu 2025-10-02 07:53:09 UTC; 3min 2s>
       Docs: man:httpd.service(8)
   Main PID: 2031 (httpd)

[tony@stapp01 ~]$ # Check the files are present or not

[tony@stapp01 ~]$ cd /var/log
[tony@stapp01 log]$ ls
README    btmp             dnf.log      hawkey.log  lastlog  tallylog
anaconda  dnf.librepo.log  dnf.rpm.log  httpd       private  wtmp

[tony@stapp01 log]$ cd httpd
[tony@stapp01 httpd]$ ls
access_log  error_log
[tony@stapp01 httpd]$ ls
access_log  error_log

[tony@stapp01 httpd]$ # ssh into STORAGE SERVER
[tony@stapp01 httpd]$ ssh natasha@ststor01

[tony@stapp01 httpd]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tony/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/tony/.ssh/id_rsa
Your public key has been saved in /home/tony/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:bk7LnBFyaeYQJAxv9KHsxK2+7CQTK6Tx4U8mztRwBJQ tony@stapp01.stratos.xfusioncorp.com
The key's randomart image is:
+---[RSA 3072]----+
| .++o o          |
|  E*.* .         |
|    O +          |
|   = . . .       |
|..+ + o S        |
|o+ O   O .       |
|o O *   *        |
| = X . * +       |
|  o.=   *        |
+----[SHA256]-----+
[tony@stapp01 httpd]$ ls
access_log  error_log
[tony@stapp01 httpd]$ ls -alh
total 12K
drwx------ 1 tony tony 4.0K Oct  2 07:53 .
drwxr-xr-x 1 root root 4.0K Jul 27  2024 ..
-rw-r--r-- 1 tony tony    0 Oct  2 07:53 access_log
-rw-r--r-- 1 tony tony  723 Oct  2 07:53 error_log
[tony@stapp01 httpd]$ cd .ssh/
-bash: cd: .ssh/: No such file or directory
[tony@stapp01 httpd]$ cd /.ssh
-bash: cd: /.ssh: No such file or directory
[tony@stapp01 httpd]$ pwd
/var/log/httpd
[tony@stapp01 httpd]$ cd /home/tony/.ssh/
[tony@stapp01 .ssh]$ ls
id_rsa  id_rsa.pub  known_hosts
[tony@stapp01 .ssh]$ ssh-copy-id
Usage: /usr/bin/ssh-copy-id [-h|-?|-f|-n|-s] [-i [identity_file]] [-p port] [-F alternative ssh_config file] [[-o <ssh -o options>] ...] [user@]hostname
        -f: force mode -- copy keys without trying to check if they are already installed
        -n: dry run    -- no keys are actually copied
        -s: use sftp   -- use sftp instead of executing remote-commands. Can be useful if the remote only allows sftp
        -h|-?: print this help
[tony@stapp01 .ssh]$ ssh-copy-id natasha@ststor01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/tony/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
natasha@ststor01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'natasha@ststor01'"
and check to make sure that only the key(s) you wanted were added.

[tony@stapp01 .ssh]$ ssh  natasha@ststor01
[natasha@ststor01 ~]$ ls /usr/src/devops
[natasha@ststor01 ~]$ cd /usr/src/devops
[natasha@ststor01 devops]$ ls
[natasha@ststor01 devops]$ ls
access_log  error_log
[natasha@ststor01 devops]$ ls
access_log  error_log
[natasha@ststor01 devops]$ rm *
[natasha@ststor01 devops]$ ls
[natasha@ststor01 devops]$ ls
access_log  error_log
[natasha@ststor01 devops]$ 
```
