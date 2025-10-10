### Task : Jenkins Deployment Job
The Nautilus development team had a meeting with the DevOps team where they discussed automating the deployment of one of their apps using Jenkins (the one in Stratos Datacenter). They want to auto deploy the new changes in case any developer pushes to the repository. As per the requirements mentioned below configure the required Jenkins job.



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and Adm!n321 password.


Similarly, you can access the Gitea UI using Gitea button, username and password for Git is sarah and Sarah_pass123 respectively. Under user sarah you will find a repository named web that is already cloned on the Storage server under sarah's home. sarah is a developer who is working on this repository.


1. Install httpd (whatever version is available in the yum repo by default) and configure it to serve on port 8080 on All app servers. You can make it part of your Jenkins job or you can do this step manually on all app servers.


2. Create a Jenkins job named nautilus-app-deployment and configure it in a way so that if anyone pushes any new change to the origin repository in master branch, the job should auto build and deploy the latest code on the Storage server under /var/www/html directory. Since /var/www/html on Storage server is shared among all apps.
Before deployment, ensure that the ownership of the /var/www/html directory is set to user sarah, so that Jenkins can successfully deploy files to that directory.


3. SSH into Storage Server using sarah user credentials mentioned above. Under sarah user's home you will find a cloned Git repository named web. Under this repository there is an index.html file, update its content to Welcome to the xFusionCorp Industries, then push the changes to the origin into master branch. This push must trigger your Jenkins job and the latest changes must be deployed on the servers, also make sure it deploys the entire repository content not only index.html file.


Click on the App button on the top bar to access the app, you should be able to see the latest changes you deployed. Please make sure the required content is loading on the main URL https://<LBR-URL> i.e there should not be any sub-directory like https://<LBR-URL>/web etc.


Note:
1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also some times Jenkins UI gets stuck when Jenkins service restarts in the back end so in such case please make sure to refresh the UI page.


2. Make sure Jenkins job passes even on repetitive runs as validation may try to build the job multiple times.


3. Deployment related tasks should be done by sudo user on the destination server to avoid any permission issues so make sure to configure your Jenkins job accordingly.


4. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

### What I did

```
Last login: Thu Oct  9 13:11:42 UTC 2025 on pts/0
thor@jumphost ~$ ssh natasha@ststor01
The authenticity of host 'ststor01 (172.16.238.15)' can't be established.
ED25519 key fingerprint is SHA256:OL3bhtDsjCjkP43vIf22GlHwHOaAEtjpCLF96Q+Gk1o.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ststor01' (ED25519) to the list of known hosts.
natasha@ststor01's password: 
[natasha@ststor01 ~]$ ls -a
.  ..  .bash_logout  .bash_profile  .bashrc
[natasha@ststor01 ~]$ mkdir .ssh
[natasha@ststor01 ~]$ ls -a
.  ..  .bash_logout  .bash_profile  .bashrc  .ssh
[natasha@ststor01 ~]$ cat >> ~/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhmwUUb9O1G0LzD8qhJINYmOqMATG/6009PjdfV9uB9 jenkins@jenkins.stratos.xfusioncorp.com^C
[natasha@ststor01 ~]$ cd /var/www/
[natasha@ststor01 www]$ ls -l
total 4
drwxr-xr-x 3 root root 4096 Aug 18 09:57 html
[natasha@ststor01 www]$ chown -R natasha html/
chown: changing ownership of 'html/index.html': Operation not permitted
chown: changing ownership of 'html/.git/info/exclude': Operation not permitted
chown: changing ownership of 'html/.git/info': Operation not permitted
chown: changing ownership of 'html/.git/objects/info': Operation not permitted
chown: changing ownership of 'html/.git/objects/ba/4c5142cc3836ccd2c913c6c45b1326aaa32a85': Operation not permitted
chown: changing ownership of 'html/.git/objects/ba': Operation not permitted
chown: changing ownership of 'html/.git/objects/pack': Operation not permitted
chown: changing ownership of 'html/.git/objects/1f/55d92e667c4c60cb001a3c6e053da12be35a92': Operation not permitted
chown: changing ownership of 'html/.git/objects/1f': Operation not permitted
chown: changing ownership of 'html/.git/objects/06/04ea607e676f6870109ea62f9b792b0b490c66': Operation not permitted
chown: changing ownership of 'html/.git/objects/06': Operation not permitted
chown: changing ownership of 'html/.git/objects': Operation not permitted
chown: changing ownership of 'html/.git/index': Operation not permitted
chown: changing ownership of 'html/.git/refs/heads/master': Operation not permitted
chown: changing ownership of 'html/.git/refs/heads': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes/origin/master': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes/origin': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes': Operation not permitted
chown: changing ownership of 'html/.git/refs/tags': Operation not permitted
chown: changing ownership of 'html/.git/refs': Operation not permitted
chown: changing ownership of 'html/.git/HEAD': Operation not permitted
chown: changing ownership of 'html/.git/COMMIT_EDITMSG': Operation not permitted
chown: changing ownership of 'html/.git/config': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-push.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-merge-commit.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/applypatch-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-receive.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/post-update.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/push-to-checkout.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/prepare-commit-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-commit.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/sendemail-validate.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-applypatch.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-rebase.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/fsmonitor-watchman.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/update.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/commit-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks': Operation not permitted
chown: changing ownership of 'html/.git/branches': Operation not permitted
chown: changing ownership of 'html/.git/description': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/heads/master': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/heads': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes/origin/master': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes/origin': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs': Operation not permitted
chown: changing ownership of 'html/.git/logs/HEAD': Operation not permitted
chown: changing ownership of 'html/.git/logs': Operation not permitted
chown: changing ownership of 'html/.git': Operation not permitted
chown: changing ownership of 'html/': Operation not permitted
[natasha@ststor01 www]$ ls -l
total 4
drwxr-xr-x 3 root root 4096 Aug 18 09:57 html
[natasha@ststor01 www]$ chown -R natasha html/
chown: changing ownership of 'html/index.html': Operation not permitted
chown: changing ownership of 'html/.git/info/exclude': Operation not permitted
chown: changing ownership of 'html/.git/info': Operation not permitted
chown: changing ownership of 'html/.git/objects/info': Operation not permitted
chown: changing ownership of 'html/.git/objects/ba/4c5142cc3836ccd2c913c6c45b1326aaa32a85': Operation not permitted
chown: changing ownership of 'html/.git/objects/ba': Operation not permitted
chown: changing ownership of 'html/.git/objects/pack': Operation not permitted
chown: changing ownership of 'html/.git/objects/1f/55d92e667c4c60cb001a3c6e053da12be35a92': Operation not permitted
chown: changing ownership of 'html/.git/objects/1f': Operation not permitted
chown: changing ownership of 'html/.git/objects/06/04ea607e676f6870109ea62f9b792b0b490c66': Operation not permitted
chown: changing ownership of 'html/.git/objects/06': Operation not permitted
chown: changing ownership of 'html/.git/objects': Operation not permitted
chown: changing ownership of 'html/.git/index': Operation not permitted
chown: changing ownership of 'html/.git/refs/heads/master': Operation not permitted
chown: changing ownership of 'html/.git/refs/heads': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes/origin/master': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes/origin': Operation not permitted
chown: changing ownership of 'html/.git/refs/remotes': Operation not permitted
chown: changing ownership of 'html/.git/refs/tags': Operation not permitted
chown: changing ownership of 'html/.git/refs': Operation not permitted
chown: changing ownership of 'html/.git/HEAD': Operation not permitted
chown: changing ownership of 'html/.git/COMMIT_EDITMSG': Operation not permitted
chown: changing ownership of 'html/.git/config': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-push.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-merge-commit.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/applypatch-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-receive.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/post-update.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/push-to-checkout.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/prepare-commit-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-commit.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/sendemail-validate.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-applypatch.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/pre-rebase.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/fsmonitor-watchman.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/update.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks/commit-msg.sample': Operation not permitted
chown: changing ownership of 'html/.git/hooks': Operation not permitted
chown: changing ownership of 'html/.git/branches': Operation not permitted
chown: changing ownership of 'html/.git/description': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/heads/master': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/heads': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes/origin/master': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes/origin': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs/remotes': Operation not permitted
chown: changing ownership of 'html/.git/logs/refs': Operation not permitted
chown: changing ownership of 'html/.git/logs/HEAD': Operation not permitted
chown: changing ownership of 'html/.git/logs': Operation not permitted
chown: changing ownership of 'html/.git': Operation not permitted
chown: changing ownership of 'html/': Operation not permitted
[natasha@ststor01 www]$ sudo chown -R natasha:natasha html/

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for natasha: 
[natasha@ststor01 www]$ exit
logout
Connection to ststor01 closed.
thor@jumphost ~$ ssh sarah@ststor01
sarah@ststor01's password: 
[sarah@ststor01 ~]$ pwd
/home/sarah
[sarah@ststor01 ~]$ ls
web
[sarah@ststor01 ~]$ cd web/
[sarah@ststor01 web]$ ls
index.html
[sarah@ststor01 web]$ cat index.html 
Welcome
[sarah@ststor01 web]$ cat > index.html 
Welcome to the xFusionCorp Industries^C
[sarah@ststor01 web]$ git commit -m "updated index.html page"
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   index.html

no changes added to commit (use "git add" and/or "git commit -a")
[sarah@ststor01 web]$ git branch
* master
[sarah@ststor01 web]$ git push origin main
error: src refspec main does not match any
error: failed to push some refs to 'http://git.stratos.xfusioncorp.com/sarah/web.git'
[sarah@ststor01 web]$ git push origin master
Everything up-to-date
[sarah@ststor01 web]$ vi index.html dex
2 files to edit
[sarah@ststor01 web]$ ls
index.html
[sarah@ststor01 web]$ vi index.html 
[sarah@ststor01 web]$ git commit -am "updated index.html"
[master 06d5be0] updated index.html
 1 file changed, 1 insertion(+), 1 deletion(-)
[sarah@ststor01 web]$ git push origin master
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Writing objects: 100% (3/3), 288 bytes | 288.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
remote: . Processing 1 references
remote: Processed 1 references in total
To http://git.stratos.xfusioncorp.com/sarah/web.git
   0604ea6..06d5be0  master -> master
[sarah@ststor01 web]$ 
```

```
Last login: Thu Oct  9 13:12:12 UTC 2025 on pts/8
thor@jumphost ~$ ssh jenkins@jenkins
The authenticity of host 'jenkins (172.16.238.19)' can't be established.
ED25519 key fingerprint is SHA256:fNMbxJFq3lhcbFxqeFFwhbRufI+eQJH/AkuzdjCe3p4.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'jenkins' (ED25519) to the list of known hosts.
jenkins@jenkins's password: 
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

jenkins@jenkins:~$ ssh-keygen
Generating public/private ed25519 key pair.
Enter file in which to save the key (/var/lib/jenkins/.ssh/id_ed25519): 
Created directory '/var/lib/jenkins/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /var/lib/jenkins/.ssh/id_ed25519
Your public key has been saved in /var/lib/jenkins/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:gooBYKS3DktlWpaUvZkmXjQ2rKIdxZYEvRwzgDyzPyQ jenkins@jenkins.stratos.xfusioncorp.com
The key's randomart image is:
+--[ED25519 256]--+
|++oB=.           |
|=+..@B           |
|o =X+=*          |
|.EB=oB           |
|++B.= . S        |
|o*.=   .         |
|o o .            |
|                 |
|                 |
+----[SHA256]-----+
jenkins@jenkins:~$ cd .ssh/
jenkins@jenkins:~/.ssh$ ls
id_ed25519  id_ed25519.pub
jenkins@jenkins:~/.ssh$ cat id_ed25519.pub 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhmwUUb9O1G0LzD8qhJINYmOqMATG/6009PjdfV9uB9 jenkins@jenkins.stratos.xfusioncorp.com
jenkins@jenkins:~/.ssh$ ssh natasha@ststor01
The authenticity of host 'ststor01 (172.16.238.15)' can't be established.
ED25519 key fingerprint is SHA256:OL3bhtDsjCjkP43vIf22GlHwHOaAEtjpCLF96Q+Gk1o.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ststor01' (ED25519) to the list of known hosts.
Last login: Thu Oct  9 13:17:56 2025 from 172.16.238.3
[natasha@ststor01 ~]$ 
```

```
[root@stapp01 tony]# history
    1  yum install httpd -y
    2  sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf
    3  sudo systemctl restart httpd
```

```
Last login: Fri Oct 10 03:26:50 UTC 2025 on pts/6
Traceback (most recent call last):
  File "/usr/local/bin/asciinema", line 8, in <module>
    sys.exit(main())
             ^^^^^^
thor@jumphost ~$ ssh natasha@ststor01
The authenticity of host 'ststor01 (172.16.238.15)' can't be established.
ED25519 key fingerprint is SHA256:VKSM7OzedCHU7/53MwkolspkywpAN3Z8l75nXgH1Kec.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ststor01' (ED25519) to the list of known hosts.
natasha@ststor01's password: 
[natasha@ststor01 ~]$ sudo -s

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for natasha: 
[root@ststor01 natasha]# ls -a
.  ..  .bash_logout  .bash_profile  .bashrc
[root@ststor01 natasha]# mkdir .ssh
[root@ststor01 natasha]# ls -a
.  ..  .bash_logout  .bash_profile  .bashrc  .ssh
[root@ststor01 natasha]# cat > .ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClWH5iMm6yQ33+pSLZPqaOgAI2ydsHvRQ6iKh+xH+llq8Cc62+VrfLg32oiqtB+nlMCTb17BsBVH9fHtdmXFu1J8LA44bJkNHIdbSTBwDm6H60kHAFKcGVzn66NRv3ghNtL9+eXhlkEdGrNr4l4RVdFb1+8bVZ3TXuOBR5oee92JBx+O+QTZK8N8LUJq3ZsczoV0LZGUfLh+P5Un+Ix4gCFPpQrpVzScT2r5dA/sScd6aWgZnDroi2Da12kqcoY9dHPOuL+CvduA6yyqwNnhpPuZ6sJzRaJ1PjbhrHTNKPGA5SxML/Tk9MP90kxfSwZsTSIYFAS4dGRQhsHbkB1JmIq9OYc0DPc/lUMmq9PIIPgJDrwIdI0BZ4jfq98P67zzW4EOUiwqNveSP8z6rbVak3W/AYHgWujgQMjIsUerUbSaGrXJ0qYZ0VUkAhyL1w6c69heIh2EhHPLQ+yd/aCLqwJWbzI3YZ8ehJ3KdnITH38Oc3iSiBKjXltYY+VdEs4Ks= jenkins@jenkins.stratos.xfusioncorp.com
^C
[root@ststor01 natasha]# cd /var/www/
[root@ststor01 www]# ls -l
total 4
drwxr-xr-x 3 natasha natasha 4096 Aug 18 09:57 html
[root@ststor01 www]# exit
exit
[natasha@ststor01 ~]$ exit
logout
Connection to ststor01 closed.
thor@jumphost ~$ ssh sarah@ststor01
sarah@ststor01's password: 
[sarah@ststor01 ~]$ ls
web
[sarah@ststor01 ~]$ pwd
/home/sarah
[sarah@ststor01 ~]$ cd web/
[sarah@ststor01 web]$ ls
index.html
[sarah@ststor01 web]$ cat index.html 
Welcome
[sarah@ststor01 web]$ cat > index.html 
Welcome to the xFusionCorp Industries^C
[sarah@ststor01 web]$ vi index.html 
[sarah@ststor01 web]$ vi index.html 
[sarah@ststor01 web]$ cat index.html 
Welcome to the xFusionCorp Industries
[sarah@ststor01 web]$ git commit -am "Updated index.html"
[master 73eb96a] Updated index.html
 1 file changed, 1 insertion(+), 1 deletion(-)
[sarah@ststor01 web]$ git branch
* master
[sarah@ststor01 web]$ git push origin master
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Writing objects: 100% (3/3), 291 bytes | 291.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
remote: . Processing 1 references
remote: Processed 1 references in total
To http://git.stratos.xfusioncorp.com/sarah/web.git
   9937785..73eb96a  master -> master
[sarah@ststor01 web]$ 
```



-----------------------------------
Troubleshoot


thor@jumphost ~$ ssh tony@stapp01
The authenticity of host 'stapp01 (172.16.238.10)' can't be established.
ED25519 key fingerprint is SHA256:uVNsYJSZfUCC2N9SPuAiOopkA5LUdTz1t0Unf/++oVU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stapp01' (ED25519) to the list of known hosts.
tony@stapp01's password: 
[tony@stapp01 ~]$ sudo -s

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony: 
[root@stapp01 tony]# yum install httpd -y
CentOS Stream 9 - BaseOS                                                                                         49 kB/s | 6.7 kB     00:00    
CentOS Stream 9 - BaseOS                                                                                        2.0 MB/s | 8.8 MB     00:04    
CentOS Stream 9 - AppStream                                                                                      73 kB/s | 6.8 kB     00:00    
CentOS Stream 9 - AppStream                                                                                      32 MB/s |  25 MB     00:00    
CentOS Stream 9 - Extras packages                                                                                80 kB/s | 8.0 kB     00:00    
CentOS Stream 9 - Extras packages                                                                                73 kB/s |  20 kB     00:00    
Extra Packages for Enterprise Linux 9 - x86_64                                                                  149 kB/s |  30 kB     00:00    
Extra Packages for Enterprise Linux 9 - x86_64                                                                   22 MB/s |  20 MB     00:00    
Extra Packages for Enterprise Linux 9 openh264 (From Cisco) - x86_64                                            5.8 kB/s | 993  B     00:00    
Extra Packages for Enterprise Linux 9 - Next - x86_64                                                           110 kB/s |  23 kB     00:00    
Extra Packages for Enterprise Linux 9 - Next - x86_64                                                            61 kB/s | 289 kB     00:04    
Dependencies resolved.
================================================================================================================================================
 Package                                  Architecture                 Version                            Repository                       Size
================================================================================================================================================
Installing:
 httpd                                    x86_64                       2.4.62-7.el9                       appstream                        46 k
Installing dependencies:
 apr                                      x86_64                       1.7.0-12.el9                       appstream                       123 k
 apr-util                                 x86_64                       1.6.1-23.el9                       appstream                        95 k
 apr-util-bdb                             x86_64                       1.6.1-23.el9                       appstream                        13 k
 centos-logos-httpd                       noarch                       90.8-3.el9                         appstream                       1.5 M
 httpd-core                               x86_64                       2.4.62-7.el9                       appstream                       1.5 M
 httpd-filesystem                         noarch                       2.4.62-7.el9                       appstream                        11 k
 httpd-tools                              x86_64                       2.4.62-7.el9                       appstream                        80 k
 libbrotli                                x86_64                       1.0.9-7.el9                        baseos                          313 k
 mailcap                                  noarch                       2.1.49-5.el9                       baseos                           33 k
Installing weak dependencies:
 apr-util-openssl                         x86_64                       1.6.1-23.el9                       appstream                        15 k
 mod_http2                                x86_64                       2.0.26-5.el9                       appstream                       163 k
 mod_lua                                  x86_64                       2.4.62-7.el9                       appstream                        58 k

Transaction Summary
================================================================================================================================================
Install  13 Packages

Total download size: 3.9 M
Installed size: 9.5 M
Downloading Packages:
(1/13): apr-1.7.0-12.el9.x86_64.rpm                                                                             713 kB/s | 123 kB     00:00    
(2/13): mailcap-2.1.49-5.el9.noarch.rpm                                                                         175 kB/s |  33 kB     00:00    
(3/13): apr-util-1.6.1-23.el9.x86_64.rpm                                                                        1.8 MB/s |  95 kB     00:00    
(4/13): apr-util-bdb-1.6.1-23.el9.x86_64.rpm                                                                    201 kB/s |  13 kB     00:00    
(5/13): apr-util-openssl-1.6.1-23.el9.x86_64.rpm                                                                444 kB/s |  15 kB     00:00    
(6/13): httpd-2.4.62-7.el9.x86_64.rpm                                                                           1.1 MB/s |  46 kB     00:00    
(7/13): libbrotli-1.0.9-7.el9.x86_64.rpm                                                                        918 kB/s | 313 kB     00:00    
(8/13): httpd-filesystem-2.4.62-7.el9.noarch.rpm                                                                177 kB/s |  11 kB     00:00    
(9/13): httpd-core-2.4.62-7.el9.x86_64.rpm                                                                      9.5 MB/s | 1.5 MB     00:00    
(10/13): centos-logos-httpd-90.8-3.el9.noarch.rpm                                                               6.4 MB/s | 1.5 MB     00:00    
(11/13): mod_http2-2.0.26-5.el9.x86_64.rpm                                                                      4.4 MB/s | 163 kB     00:00    
(12/13): httpd-tools-2.4.62-7.el9.x86_64.rpm                                                                    796 kB/s |  80 kB     00:00    
(13/13): mod_lua-2.4.62-7.el9.x86_64.rpm                                                                        1.7 MB/s |  58 kB     00:00    
------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                           5.3 MB/s | 3.9 MB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                        1/1 
  Installing       : apr-1.7.0-12.el9.x86_64                                                                                               1/13 
  Installing       : apr-util-bdb-1.6.1-23.el9.x86_64                                                                                      2/13 
  Installing       : apr-util-openssl-1.6.1-23.el9.x86_64                                                                                  3/13 
  Installing       : apr-util-1.6.1-23.el9.x86_64                                                                                          4/13 
  Installing       : httpd-tools-2.4.62-7.el9.x86_64                                                                                       5/13 
  Running scriptlet: httpd-filesystem-2.4.62-7.el9.noarch                                                                                  6/13 
  Installing       : httpd-filesystem-2.4.62-7.el9.noarch                                                                                  6/13 
  Installing       : centos-logos-httpd-90.8-3.el9.noarch                                                                                  7/13 
  Installing       : mailcap-2.1.49-5.el9.noarch                                                                                           8/13 
  Installing       : httpd-core-2.4.62-7.el9.x86_64                                                                                        9/13 
  Installing       : mod_lua-2.4.62-7.el9.x86_64                                                                                          10/13 
  Installing       : libbrotli-1.0.9-7.el9.x86_64                                                                                         11/13 
  Installing       : mod_http2-2.0.26-5.el9.x86_64                                                                                        12/13 
  Installing       : httpd-2.4.62-7.el9.x86_64                                                                                            13/13 
  Running scriptlet: httpd-2.4.62-7.el9.x86_64                                                                                            13/13 
  Verifying        : libbrotli-1.0.9-7.el9.x86_64                                                                                          1/13 
  Verifying        : mailcap-2.1.49-5.el9.noarch                                                                                           2/13 
  Verifying        : apr-1.7.0-12.el9.x86_64                                                                                               3/13 
  Verifying        : apr-util-1.6.1-23.el9.x86_64                                                                                          4/13 
  Verifying        : apr-util-bdb-1.6.1-23.el9.x86_64                                                                                      5/13 
  Verifying        : apr-util-openssl-1.6.1-23.el9.x86_64                                                                                  6/13 
  Verifying        : centos-logos-httpd-90.8-3.el9.noarch                                                                                  7/13 
  Verifying        : httpd-2.4.62-7.el9.x86_64                                                                                             8/13 
  Verifying        : httpd-core-2.4.62-7.el9.x86_64                                                                                        9/13 
  Verifying        : httpd-filesystem-2.4.62-7.el9.noarch                                                                                 10/13 
  Verifying        : httpd-tools-2.4.62-7.el9.x86_64                                                                                      11/13 
  Verifying        : mod_http2-2.0.26-5.el9.x86_64                                                                                        12/13 
  Verifying        : mod_lua-2.4.62-7.el9.x86_64                                                                                          13/13 

Installed:
  apr-1.7.0-12.el9.x86_64               apr-util-1.6.1-23.el9.x86_64  apr-util-bdb-1.6.1-23.el9.x86_64  apr-util-openssl-1.6.1-23.el9.x86_64 
  centos-logos-httpd-90.8-3.el9.noarch  httpd-2.4.62-7.el9.x86_64     httpd-core-2.4.62-7.el9.x86_64    httpd-filesystem-2.4.62-7.el9.noarch 
  httpd-tools-2.4.62-7.el9.x86_64       libbrotli-1.0.9-7.el9.x86_64  mailcap-2.1.49-5.el9.noarch       mod_http2-2.0.26-5.el9.x86_64        
  mod_lua-2.4.62-7.el9.x86_64          

Complete!
[root@stapp01 tony]# sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf
[root@stapp01 tony]# grep | listen 8080
bash: listen: command not found
Usage: grep [OPTION]... PATTERNS [FILE]...
Try 'grep --help' for more information.
[root@stapp01 tony]# grep Listen /etc/httpd/conf/httpd.conf
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on a specific IP address, but note that if
#Listen 12.34.56.78:80
Listen 8080
[root@stapp01 tony]# sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && echo "Port changed successfully" || echo "Port change failed"
Port changed successfully
[root@stapp01 tony]# systemctl restart httpd
Job for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
[root@stapp01 tony]# systemctl status httpd
× httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; preset: disabled)
     Active: failed (Result: exit-code) since Thu 2025-10-09 11:54:17 UTC; 1min 35s ago
       Docs: man:httpd.service(8)
    Process: 3224 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
   Main PID: 3224 (code=exited, status=1/FAILURE)
     Status: "Reading configuration..."

Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com httpd[3224]: Invalid address or port
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3224 (RELOADING=1, STATUS=Reading configuration...)
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Child 3224 belongs to httpd.service.
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Main process exited, code=exited, status=1/FAILURE
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed with result 'exit-code'.
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Service will not restart (restart setting)
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> failed
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 245 httpd.service/start finished, result=failed
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: Failed to start The Apache HTTP Server.
Oct 09 11:54:17 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Unit entered failed state.
[root@stapp01 tony]# systemctl enable  httpd
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
[root@stapp01 tony]# systemctl restart httpd
Job for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
[root@stapp01 tony]# sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf && echo "Port changed successfully" || echo "Port change failed"
Port changed successfully
[root@stapp01 tony]# systemctl restart httpdJob for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
[root@stapp01 tony]# ^C
[root@stapp01 tony]# sudo sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf[root@stapp01 tony]# systemctl restart httpdJob for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
[root@stapp01 tony]# sudo echo "Listen 8080" >> /etc/httpd/conf/httpd.conf
[root@stapp01 tony]# sudo systemctl restart httpd
Job for httpd.service failed because the control process exited with error code.
See "systemctl status httpd.service" and "journalctl -xeu httpd.service" for details.
[root@stapp01 tony]# systemctl status httpd
× httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: failed (Result: exit-code) since Thu 2025-10-09 11:59:50 UTC; 15s ago
       Docs: man:httpd.service(8)
    Process: 3925 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
   Main PID: 3925 (code=exited, status=1/FAILURE)
     Status: "Reading configuration..."

Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com httpd[3925]: Invalid address or port
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3925 (RELOADING=1, STATUS=Reading configuration...)
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Child 3925 belongs to httpd.service.
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Main process exited, code=exited, status=1/FAILURE
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed with result 'exit-code'.
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Service will not restart (restart setting)
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> failed
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 450 httpd.service/start finished, result=failed
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: Failed to start The Apache HTTP Server.
Oct 09 11:59:50 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Unit entered failed state.
[root@stapp01 tony]# grep -i 'Listen' /etc/httpd/conf/httpd.conf
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on a specific IP address, but note that if
#Listen 12.34.56.78:80
Listen 8080808080
Listen 8080
[root@stapp01 tony]# sudo vi /etc/httpd/conf/httpd.conf
[root@stapp01 tony]# # Verify config syntax before starting (Good Practice)
sudo httpd -t

# Start the service
sudo systemctl start httpd

# Check the status
sudo systemctl status httpd
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using stapp01.stratos.xfusioncorp.com. Set the 'ServerName' directive globally to suppress this message
Syntax OK
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Thu 2025-10-09 12:03:59 UTC; 72ms ago
       Docs: man:httpd.service(8)
   Main PID: 4107 (httpd)
     Status: "Started, listening on: port 8080"
      Tasks: 177 (limit: 411140)
     Memory: 16.1M
     CGroup: /docker/c53df9cd4c1935434771d878f11cc489b61e886cedd0b6f9a5b706fb364036a3/system.slice/httpd.service
             ├─4107 /usr/sbin/httpd -DFOREGROUND
             ├─4114 /usr/sbin/httpd -DFOREGROUND
             ├─4115 /usr/sbin/httpd -DFOREGROUND
             ├─4116 /usr/sbin/httpd -DFOREGROUND
             └─4117 /usr/sbin/httpd -DFOREGROUND

Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 4107 (RELOADING=1, STATUS=Reading configuration...)
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com httpd[4107]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using stapp01.stratos.xfusioncorp.com. Set the 'ServerName' directive globally to suppress this message
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 4107 (RELOADING=1, STATUS=Reading configuration...)
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com httpd[4107]: Server configured, listening on: port 8080
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 4107 (READY=1, STATUS=Configuration loaded.)
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> running
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 490 httpd.service/start finished, result=done
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: Started The Apache HTTP Server.
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed to send unit change signal for httpd.service: Connection reset by peer
Oct 09 12:03:59 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 4107 (READY=1, STATUS=Started, listening on: port 8080, MAINPID=4107)
[root@stapp01 tony]# 
