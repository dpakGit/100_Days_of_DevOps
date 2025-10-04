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
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
thor@jumphost ~$ ssh tony@stdb01
The authenticity of host 'stdb01 (172.16.239.10)' can't be established.
ED25519 key fingerprint is SHA256:E4sOrr32a86HQ934AmX9LigAY4UrO1OTmSAC04HMmaU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes^C
thor@jumphost ~$ ssh tony@stdb01.stratos.xfusioncorp.com
The authenticity of host 'stdb01.stratos.xfusioncorp.com (172.16.239.10)' can't be established.
ED25519 key fingerprint is SHA256:E4sOrr32a86HQ934AmX9LigAY4UrO1OTmSAC04HMmaU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stdb01.stratos.xfusioncorp.com' (ED25519) to the list of known hosts.
tony@stdb01.stratos.xfusioncorp.com's password: 
thor@jumphost ~$ ssh peter@stdb01
peter@stdb01's password: 
Last login: Sat Oct  4 03:48:27 2025 from 172.16.239.2
[peter@stdb01 ~]$ ls
[peter@stdb01 ~]$ ssh clint@stbkp01
The authenticity of host 'stbkp01 (172.17.0.4)' can't be established.
ED25519 key fingerprint is SHA256:zaRxR12+eBKM8nETBuRfxKBhU94gzoEPFyKeBiGWkjg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stbkp01' (ED25519) to the list of known hosts.
clint@stbkp01's password: 
[clint@stbkp01 ~]$ cd /home/clint/db_backups
[clint@stbkp01 db_backups]$ ls
[clint@stbkp01 db_backups]$ exit
logout
Connection to stbkp01 closed.
[peter@stdb01 ~]$ exit
logout
Connection to stdb01 closed.
thor@jumphost ~$ ssh peter@stdb01
peter@stdb01's password: 
Last failed login: Sat Oct  4 03:57:42 UTC 2025 from 172.16.239.3 on ssh:notty
There were 12 failed login attempts since the last successful login.
Last login: Sat Oct  4 03:49:21 2025 from 172.16.239.2
[peter@stdb01 ~]$ ssh clint@stbkp01
clint@stbkp01's password: 

[peter@stdb01 ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/peter/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/peter/.ssh/id_rsa
Your public key has been saved in /home/peter/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:lIr/UaZhVfclmtXOCp8IE741UHoX7Mj7UIYnXeWc2ME peter@stdb01.stratos.xfusioncorp.com
The key's randomart image is:
+---[RSA 3072]----+
|           .o.*o+|
|         .oo =+E*|
|        o.o++*.*+|
|     . o .+.O.* o|
|    . . S o= @ o |
|     . . =. + +  |
|      . o    o   |
|       . .    .  |
|        .        |
+----[SHA256]-----+
[peter@stdb01 ~]$ ssh-copy-id clint@stbkp01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/peter/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
clint@stbkp01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'clint@stbkp01'"
and check to make sure that only the key(s) you wanted were added.

[peter@stdb01 ~]$ ssh clint@stbkp01
Last failed login: Sat Oct  4 04:10:00 UTC 2025 from 172.17.0.5 on ssh:notty
There were 2 failed login attempts since the last successful login.
Last login: Sat Oct  4 03:50:32 2025 from 172.17.0.5
[clint@stbkp01 ~]$ # popup for Password did not appear, It means it worked
[clint@stbkp01 ~]$ cd /home/clint/db_backups
[clint@stbkp01 db_backups]$ ls
[clint@stbkp01 db_backups]$ ls
db_2025-10-04.sql
[clint@stbkp01 db_backups]$ 3 Ater Build as i ran the ls command the backupfile appeared
-bash: 3: command not found
[clint@stbkp01 db_backups]$ #  Ater Build as i ran the ls command the backupfile appeared
[clint@stbkp01 db_backups]$ rm *
[clint@stbkp01 db_backups]$ ls
[clint@stbkp01 db_backups]$ ls
db_2025-10-04.sql
[clint@stbkp01 db_backups]$ 
```
