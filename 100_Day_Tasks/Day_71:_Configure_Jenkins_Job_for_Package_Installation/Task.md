### Task : Day 71: Configure Jenkins Job for Package Installation

Some new requirements have come up to install and configure some packages on the Nautilus infrastructure under Stratos Datacenter. The Nautilus DevOps team installed and configured a new Jenkins server so they wanted to create a Jenkins job to automate this task. Find below more details and complete the task accordingly:

1. Access the Jenkins UI by clicking on the Jenkins button in the top bar. Log in using the credentials: username admin and password Adm!n321.

2. Create a new Jenkins job named install-packages and configure it with the following specifications:

Add a string parameter named PACKAGE.
Configure the job to install a package specified in the $PACKAGE parameter on the storage server within the Stratos Datacenter.

Note:

1. Ensure to install any required plugins and restart the Jenkins service if necessary. Opt for Restart Jenkins when installation is complete and no jobs are running on the plugin installation/update page. Refresh the UI page if needed after restarting the service.

2. Verify that the Jenkins job runs successfully on repeated executions to ensure reliability.

3. Capture screenshots of your configuration for documentation and review purposes. Alternatively, use screen recording software like loom.com for comprehensive documentation and sharing.

### What I Did

https://www.youtube.com/watch?v=Abxm13_i8A4

https://www.youtube.com/watch?v=_coKow-BTbI



#### Console Output
```
Started by user admin

Running as SYSTEM
Building in workspace /var/lib/jenkins/workspace/install-packages
[SSH] script:
PACKAGE="nginx"

echo 'Bl@kW' | sudo -S yum install -y $PACKAGE

[SSH] executing...
[sudo] password for natasha: CentOS Stream 9 - BaseOS                         11 kB/s | 6.4 kB     00:00    
CentOS Stream 9 - BaseOS                         16 MB/s | 8.8 MB     00:00    
CentOS Stream 9 - AppStream                      49 kB/s | 6.5 kB     00:00    

CentOS Stream 9 - AppStream                     1.8 MB/s |  25 MB     00:13    

CentOS Stream 9 - Extras packages                47 kB/s | 8.0 kB     00:00    
CentOS Stream 9 - Extras packages                51 kB/s |  20 kB     00:00    

Extra Packages for Enterprise Linux 9 - x86_64   71 kB/s |  22 kB     00:00    
Extra Packages for Enterprise Linux 9 - x86_64   20 MB/s |  20 MB     00:01    

Extra Packages for Enterprise Linux 9 openh264  7.0 kB/s | 993  B     00:00    
Extra Packages for Enterprise Linux 9 - Next -  127 kB/s |  24 kB     00:00    
Extra Packages for Enterprise Linux 9 - Next -  587 kB/s | 289 kB     00:00    

Dependencies resolved.
================================================================================
 Package                 Arch        Version               Repository      Size
================================================================================
Installing:
 nginx                   x86_64      2:1.20.1-24.el9       appstream       36 k
Installing dependencies:
 centos-logos-httpd      noarch      90.8-3.el9            appstream      1.5 M
 nginx-core              x86_64      2:1.20.1-24.el9       appstream      570 k
 nginx-filesystem        noarch      2:1.20.1-24.el9       appstream      9.3 k
Installing weak dependencies:
 logrotate               x86_64      3.18.0-12.el9         baseos          74 k

Transaction Summary
================================================================================
Install  5 Packages

Total download size: 2.2 M
Installed size: 4.5 M
Downloading Packages:
(1/5): nginx-1.20.1-24.el9.x86_64.rpm           295 kB/s |  36 kB     00:00    
(2/5): nginx-core-1.20.1-24.el9.x86_64.rpm      3.4 MB/s | 570 kB     00:00    
(3/5): nginx-filesystem-1.20.1-24.el9.noarch.rp 225 kB/s | 9.3 kB     00:00    
(4/5): centos-logos-httpd-90.8-3.el9.noarch.rpm 4.2 MB/s | 1.5 MB     00:00    
(5/5): logrotate-3.18.0-12.el9.x86_64.rpm       181 kB/s |  74 kB     00:00    
--------------------------------------------------------------------------------
Total                                           2.9 MB/s | 2.2 MB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction

  Preparing        :                                                        1/1 
  Running scriptlet: nginx-filesystem-2:1.20.1-24.el9.noarch                1/5 
  Installing       : nginx-filesystem-2:1.20.1-24.el9.noarch                1/5 
  Installing       : nginx-core-2:1.20.1-24.el9.x86_64                      2/5 
  Installing       : centos-logos-httpd-90.8-3.el9.noarch                   3/5 
  Running scriptlet: logrotate-3.18.0-12.el9.x86_64                         4/5 
  Installing       : logrotate-3.18.0-12.el9.x86_64                         4/5 
  Running scriptlet: logrotate-3.18.0-12.el9.x86_64                         4/5 
Created symlink /etc/systemd/system/timers.target.wants/logrotate.timer → /usr/lib/systemd/system/logrotate.timer.

  Installing       : nginx-2:1.20.1-24.el9.x86_64                           5/5 
  Running scriptlet: nginx-2:1.20.1-24.el9.x86_64                           5/5 
  Verifying        : logrotate-3.18.0-12.el9.x86_64                         1/5 
  Verifying        : centos-logos-httpd-90.8-3.el9.noarch                   2/5 
  Verifying        : nginx-2:1.20.1-24.el9.x86_64                           3/5 
  Verifying        : nginx-core-2:1.20.1-24.el9.x86_64                      4/5 
  Verifying        : nginx-filesystem-2:1.20.1-24.el9.noarch                5/5 

Installed:
  centos-logos-httpd-90.8-3.el9.noarch      logrotate-3.18.0-12.el9.x86_64     
  nginx-2:1.20.1-24.el9.x86_64              nginx-core-2:1.20.1-24.el9.x86_64  
  nginx-filesystem-2:1.20.1-24.el9.noarch  

Complete!

[SSH] completed
[SSH] exit-status: 0

Finished: SUCCESS

```
