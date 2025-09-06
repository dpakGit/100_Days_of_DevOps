### Task

One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 2 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:

a. Install apache2 in kkloud container using apt that is running on App Server 2 in Stratos Datacenter.

b. Configure Apache to listen on port 6100 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.

-------------------------------------------

### What I Did

```
[root@stapp02 steve]# docker ps -a 
bb641735c4a6   ubuntu:18.04   "/bin/bash"   8 minutes ago   Up 8 minutes             kkloud
# Or
[root@stapp02 steve]# docker ps -a | grep kkloud
bb641735c4a6   ubuntu:18.04   "/bin/bash"   8 minutes ago   Up 8 minutes             kkloud

[root@stapp02 steve]# docker exec -it kkloud bash
root@bb641735c4a6:/# pwd
/

root@bb641735c4a6:/# apt update

root@bb641735c4a6:/# apt install -y apache2
--------------------------------------
The Apache configuration file is usually located at /etc/apache2/ports.conf or /etc/httpd/conf/httpd.conf, depending on your Linux distribution.

You can open the file using a text editor like nano or vim:


bash
# Open the ports.conf file (Ubuntu/Debian-based systems)
nano /etc/apache2/ports.conf

# or

# Open the httpd.conf file (RHEL/CentOS-based systems)
nano /etc/httpd/conf/httpd.conf

-----------------------------------------
root@bb641735c4a6:/# ls -alh
total 76K
drwxr-xr-x   22 root   root    4.0K Aug 30 16:12 .
drwxr-xr-x   22 root   root    4.0K Aug 30 16:12 ..
-rwxr-xr-x    1 root   root       0 Aug 30 16:12 .dockerenv
drwx------    2 root   root    4.0K Aug 30 16:12 .sysbox-procfs-3971741627
drwxr-xr-x    2 root   root    4.0K May 30  2023 bin
drwxr-xr-x    2 root   root    4.0K Apr 24  2018 boot
drwxr-xr-x    5 root   root     360 Aug 30 16:12 dev
drwxr-xr-x   39 root   root    4.0K Aug 30 16:25 etc
drwxr-xr-x    2 root   root    4.0K Apr 24  2018 home
drwxr-xr-x    8 root   root    4.0K May 23  2017 lib
drwxr-xr-x    2 root   root    4.0K May 30  2023 lib64
drwxr-xr-x    2 root   root    4.0K May 30  2023 media
drwxr-xr-x    2 root   root    4.0K May 30  2023 mnt
drwxr-xr-x    2 root   root    4.0K May 30  2023 opt
dr-xr-xr-x 1075 root   root       0 Aug 30 16:12 proc
drwx------    2 root   root    4.0K May 30  2023 root
drwxr-xr-x    5 root   root    4.0K May 30  2023 run
drwxr-xr-x    2 root   root    4.0K May 30  2023 sbin
drwxr-xr-x    2 root   root    4.0K May 30  2023 srv
dr-xr-xr-x   13 nobody nogroup    0 Aug  5 03:23 sys
drwxrwxrwt    2 root   root    4.0K Aug 30 16:25 tmp
drwxr-xr-x   10 root   root    4.0K May 30  2023 usr
drwxr-xr-x   12 root   root    4.0K Aug 30 16:25 var

root@bb641735c4a6:/# cd /etc/

root@bb641735c4a6:/etc# ls 
adduser.conf            gss            mailcap.order  rc6.d
alternatives            host.conf      mime.types     rcS.d
apache2                 hostname       mke2fs.conf    resolv.conf
apt                     hosts          mtab           rmt
bash.bashrc             init.d         network        rpc
bindresvport.blacklist  issue          networks       securetty
ca-certificates         issue.net      nsswitch.conf  security
ca-certificates.conf    kernel         opt            selinux
cloud                   ld.so.cache    os-release     services
cron.daily              ld.so.conf     pam.conf       shadow
debconf.conf            ld.so.conf.d   pam.d          shells
debian_version          ldap           passwd         skel
default                 legal          perl           ssl
deluser.conf            libaudit.conf  profile        subgid
dpkg                    logcheck       profile.d      subuid
environment             login.defs     protocols      sysctl.conf
fstab                   logrotate.d    rc0.d          sysctl.d
gai.conf                lsb-release    rc1.d          systemd
group                   machine-id     rc2.d          terminfo
group-                  magic          rc3.d          ufw
gshadow                 magic.mime     rc4.d          update-motd.d
gshadow-                mailcap        rc5.d

root@bb641735c4a6:/etc# cd apache2/

root@bb641735c4a6:/etc/apache2# ls
apache2.conf    envvars         mods-enabled     sites-enabled
conf-available  magic           ports.conf
conf-enabled    mods-available  sites-available

root@bb641735c4a6:/etc/apache2# vi ports.conf 
bash: vi: command not found
root@bb641735c4a6:/etc/apache2# nano ports.conf 
bash: nano: command not found

Note: If vi or nano is not found install

root@bb641735c4a6:/etc/apache2# apt update

root@bb641735c4a6:/etc/apache2# apt install vim

root@bb641735c4a6:/etc/apache2# vi ports.conf 

# Verify the changes

root@bb641735c4a6:/etc/apache2# cat ports.conf | grep Listen
Listen 6100
        Listen 443
        Listen 443

root@bb641735c4a6:/etc/apache2# service apache2 restart
 * Restarting Apache httpd web server apache2                            AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.12.0.2. Set the 'ServerName' directive globally to suppress this message
                                                                  [ OK ]

root@bb641735c4a6:/etc/apache2# service apache2 status
 * apache2 is running

root@bb641735c4a6:/etc/apache2# exit
exit

[root@stapp02 steve]# pwd
/home/steve

[root@stapp02 steve]# docker exec -it kkloud netstat -tlnp | grep 6100

[root@stapp02 steve]# docker exec -it kkloud ss -tlnp | grep 6100

Note: The above two commands did not work.

[root@stapp02 steve]# docker exec -it kkloud service apache2 status
 * apache2 is running

[root@stapp02 steve]# docker exec -it kkloud cat /etc/apache2/ports.conf # This will show the ports on which apache is listening
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 6100

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

# command to find the the container IP address using:

[root@stapp02 steve]# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kkloud
172.12.0.2

[root@stapp02 steve]# curl http://172.12.0.2:6100

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <!--
    Modified from the Debian original for Ubuntu
    Last updated: 2016-11-16
    See: https://launchpad.net/bugs/1288690
  -->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Apache2 Ubuntu Default Page: It works</title>
    <style type="text/css" media="screen">
  * {
    margin: 0px 0px 0px 0px;
    padding: 0px 0px 0px 0px;
  }

```

 
```      
docker ps -a
# Or
docker ps -a | grep kkloud
docker exec -it kkloud bash
pwd
docker exec -it kkloud netstat -tlnp | grep 6100
docker exec -it kkloud ss -tlnp | grep 6100
docker exec -it kkloud service apache2 status
docker exec -it kkloud cat /etc/apache2/ports.conf
docker exec -it kkloud lsof -i :6100
# Replace <container-ip> with the IP address of the kkloud container. You can find the container IP address using:
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kkloud
curl http://172.12.0.2:6100
```
