
### Task:

thor@jumphost ~$ ssh banner@stapp03
The authenticity of host 'stapp03 (172.16.238.12)' can't be established.
ED25519 key fingerprint is SHA256:JUb9Ms+7cgUuRVTJGosmbnljOsM/3V20S/h+lLGwMok.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'stapp03' (ED25519) to the list of known hosts.
banner@stapp03's password: 
[banner@stapp03 ~]$ sudo -s

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner: 
[root@stapp03 banner]# cat /etc/os-release
NAME="CentOS Stream"
VERSION="9"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="9"
PLATFORM_ID="platform:el9"
PRETTY_NAME="CentOS Stream 9"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:centos:centos:9"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://issues.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
[root@stapp03 banner]# sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
CentOS Stream 9 - BaseOS                  34 kB/s | 7.3 kB     00:00    
CentOS Stream 9 - BaseOS                  14 MB/s | 8.8 MB     00:00    
CentOS Stream 9 - AppStream               69 kB/s | 7.5 kB     00:00    
CentOS Stream 9 - AppStream               44 MB/s |  25 MB     00:00    
CentOS Stream 9 - Extras packages         33 kB/s | 8.0 kB     00:00    
CentOS Stream 9 - Extras packages         33 kB/s |  19 kB     00:00    
Extra Packages for Enterprise Linux 9 -  139 kB/s |  36 kB     00:00    
Extra Packages for Enterprise Linux 9 -  8.3 MB/s |  20 MB     00:02    
Extra Packages for Enterprise Linux 9 op 5.3 kB/s | 993  B     00:00    
Extra Packages for Enterprise Linux 9 -  118 kB/s |  25 kB     00:00    
Extra Packages for Enterprise Linux 9 -  691 kB/s | 279 kB     00:00    
Dependencies resolved.
=========================================================================
 Package                     Arch      Version           Repo       Size
=========================================================================
Installing:
 yum-utils                   noarch    4.3.0-21.el9      baseos     40 k
Upgrading:
 dnf-plugins-core            noarch    4.3.0-21.el9      baseos     37 k
 python3-dnf-plugins-core    noarch    4.3.0-21.el9      baseos    264 k

Transaction Summary
=========================================================================
Install  1 Package
Upgrade  2 Packages

Total download size: 341 k
Downloading Packages:
(1/3): yum-utils-4.3.0-21.el9.noarch.rpm 1.0 MB/s |  40 kB     00:00    
(2/3): dnf-plugins-core-4.3.0-21.el9.noa 958 kB/s |  37 kB     00:00    
(3/3): python3-dnf-plugins-core-4.3.0-21 4.2 MB/s | 264 kB     00:00    
-------------------------------------------------------------------------
Total                                    1.4 MB/s | 341 kB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                 1/1 
  Upgrading        : python3-dnf-plugins-core-4.3.0-21.el9.noarch    1/5 
  Upgrading        : dnf-plugins-core-4.3.0-21.el9.noarch            2/5 
  Installing       : yum-utils-4.3.0-21.el9.noarch                   3/5 
  Cleanup          : dnf-plugins-core-4.3.0-16.el9.noarch            4/5 
  Cleanup          : python3-dnf-plugins-core-4.3.0-16.el9.noarch    5/5 
  Running scriptlet: python3-dnf-plugins-core-4.3.0-16.el9.noarch    5/5 
  Verifying        : yum-utils-4.3.0-21.el9.noarch                   1/5 
  Verifying        : dnf-plugins-core-4.3.0-21.el9.noarch            2/5 
  Verifying        : dnf-plugins-core-4.3.0-16.el9.noarch            3/5 
  Verifying        : python3-dnf-plugins-core-4.3.0-21.el9.noarch    4/5 
  Verifying        : python3-dnf-plugins-core-4.3.0-16.el9.noarch    5/5 

Upgraded:
  dnf-plugins-core-4.3.0-21.el9.noarch                                   
  python3-dnf-plugins-core-4.3.0-21.el9.noarch                           
Installed:
  yum-utils-4.3.0-21.el9.noarch                                          

Complete!
Adding repo from: https://download.docker.com/linux/centos/docker-ce.repo
[root@stapp03 banner]# sudo yum install -y docker-ce docker-ce-cli containerd.io
Docker CE Stable - x86_64                441 kB/s |  78 kB     00:00    
Last metadata expiration check: 0:00:01 ago on Mon Aug 25 07:56:09 2025.
Dependencies resolved.
=========================================================================
 Package                   Arch   Version         Repository        Size
=========================================================================
Installing:
 containerd.io             x86_64 1.7.27-3.1.el9  docker-ce-stable  44 M
 docker-ce                 x86_64 3:28.3.3-1.el9  docker-ce-stable  21 M
 docker-ce-cli             x86_64 1:28.3.3-1.el9  docker-ce-stable 8.6 M
Upgrading:
 python3-rpm               x86_64 4.16.1.3-37.el9 baseos            65 k
 rpm                       x86_64 4.16.1.3-37.el9 baseos           536 k
 rpm-build-libs            x86_64 4.16.1.3-37.el9 baseos            89 k
 rpm-libs                  x86_64 4.16.1.3-37.el9 baseos           308 k
 rpm-sign-libs             x86_64 4.16.1.3-37.el9 baseos            21 k
Installing dependencies:
 container-selinux         noarch 4:2.240.0-1.el9 appstream         60 k
 fuse-common               x86_64 3.10.2-9.el9    baseos           8.3 k
 fuse-overlayfs            x86_64 1.15-1.el9      appstream         67 k
 fuse3                     x86_64 3.10.2-9.el9    appstream         54 k
 fuse3-libs                x86_64 3.10.2-9.el9    appstream         91 k
 iptables-legacy           x86_64 1.8.10-11.1.el9 epel              50 k
 iptables-legacy-libs      x86_64 1.8.10-11.1.el9 epel              38 k
 iptables-libs             x86_64 1.8.10-11.el9   baseos           462 k
 kmod                      x86_64 28-10.el9       baseos           126 k
 libnetfilter_conntrack    x86_64 1.0.9-1.el9     baseos            59 k
 libnfnetlink              x86_64 1.0.1-23.el9    baseos            29 k
 libslirp                  x86_64 4.4.0-8.el9     appstream         68 k
 rpm-plugin-selinux        x86_64 4.16.1.3-37.el9 baseos            17 k
 selinux-policy            noarch 38.1.63-1.el9   baseos            44 k
 selinux-policy-targeted   noarch 38.1.63-1.el9   baseos           6.9 M
 slirp4netns               x86_64 1.3.3-1.el9     appstream         47 k
 xz                        x86_64 5.2.5-8.el9     baseos           226 k
Installing weak dependencies:
 docker-buildx-plugin      x86_64 0.26.1-1.el9    docker-ce-stable  16 M
 docker-ce-rootless-extras x86_64 28.3.3-1.el9    docker-ce-stable 3.4 M
 docker-compose-plugin     x86_64 2.39.1-1.el9    docker-ce-stable  15 M

Transaction Summary
=========================================================================
Install  23 Packages
Upgrade   5 Packages

Total download size: 118 M
Downloading Packages:
(1/28): fuse-common-3.10.2-9.el9.x86_64.  57 kB/s | 8.3 kB     00:00    
(2/28): libnetfilter_conntrack-1.0.9-1.e 560 kB/s |  59 kB     00:00    
(3/28): kmod-28-10.el9.x86_64.rpm        462 kB/s | 126 kB     00:00    
(4/28): libnfnetlink-1.0.1-23.el9.x86_64 531 kB/s |  29 kB     00:00    
(5/28): rpm-plugin-selinux-4.16.1.3-37.e 332 kB/s |  17 kB     00:00    
(6/28): selinux-policy-38.1.63-1.el9.noa 769 kB/s |  44 kB     00:00    
(7/28): iptables-libs-1.8.10-11.el9.x86_ 1.1 MB/s | 462 kB     00:00    
(8/28): xz-5.2.5-8.el9.x86_64.rpm        2.0 MB/s | 226 kB     00:00    
(9/28): container-selinux-2.240.0-1.el9. 401 kB/s |  60 kB     00:00    
(10/28): fuse3-3.10.2-9.el9.x86_64.rpm   1.1 MB/s |  54 kB     00:00    
(11/28): fuse-overlayfs-1.15-1.el9.x86_6 475 kB/s |  67 kB     00:00    
(12/28): fuse3-libs-3.10.2-9.el9.x86_64. 1.9 MB/s |  91 kB     00:00    
(13/28): libslirp-4.4.0-8.el9.x86_64.rpm 1.4 MB/s |  68 kB     00:00    
(14/28): slirp4netns-1.3.3-1.el9.x86_64. 1.2 MB/s |  47 kB     00:00    
(15/28): selinux-policy-targeted-38.1.63  13 MB/s | 6.9 MB     00:00    
(16/28): docker-buildx-plugin-0.26.1-1.e  38 MB/s |  16 MB     00:00    
(17/28): docker-ce-cli-28.3.3-1.el9.x86_  20 MB/s | 8.6 MB     00:00    
(18/28): docker-ce-28.3.3-1.el9.x86_64.r  23 MB/s |  21 MB     00:00    
(19/28): containerd.io-1.7.27-3.1.el9.x8  32 MB/s |  44 MB     00:01    
(20/28): docker-ce-rootless-extras-28.3. 7.1 MB/s | 3.4 MB     00:00    
(21/28): docker-compose-plugin-2.39.1-1.  28 MB/s |  15 MB     00:00    
(22/28): iptables-legacy-libs-1.8.10-11. 136 kB/s |  38 kB     00:00    
(23/28): iptables-legacy-1.8.10-11.1.el9 121 kB/s |  50 kB     00:00    
(24/28): python3-rpm-4.16.1.3-37.el9.x86 375 kB/s |  65 kB     00:00    
(25/28): rpm-build-libs-4.16.1.3-37.el9. 485 kB/s |  89 kB     00:00    
(26/28): rpm-4.16.1.3-37.el9.x86_64.rpm  1.8 MB/s | 536 kB     00:00    
(27/28): rpm-sign-libs-4.16.1.3-37.el9.x 237 kB/s |  21 kB     00:00    
(28/28): rpm-libs-4.16.1.3-37.el9.x86_64 1.2 MB/s | 308 kB     00:00    
-------------------------------------------------------------------------
Total                                     34 MB/s | 118 MB     00:03     
Docker CE Stable - x86_64                 24 kB/s | 1.6 kB     00:00    
Importing GPG key 0x621E9F35:
 Userid     : "Docker Release (CE rpm) <docker@docker.com>"
 Fingerprint: 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35
 From       : https://download.docker.com/linux/centos/gpg
Key imported successfully
Extra Packages for Enterprise Linux 9 -  1.6 MB/s | 1.6 kB     00:00    
Importing GPG key 0x3228467C:
 Userid     : "Fedora (epel9) <epel@fedoraproject.org>"
 Fingerprint: FF8A D134 4597 106E CE81 3B91 8A38 72BF 3228 467C
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Running scriptlet: selinux-policy-targeted-38.1.63-1.el9.noarch    1/1 
  Preparing        :                                                 1/1 
  Installing       : selinux-policy-38.1.63-1.el9.noarch            1/33 
  Running scriptlet: selinux-policy-38.1.63-1.el9.noarch            1/33 
  Running scriptlet: selinux-policy-targeted-38.1.63-1.el9.noarc    2/33 
  Installing       : selinux-policy-targeted-38.1.63-1.el9.noarc    2/33 
  Running scriptlet: selinux-policy-targeted-38.1.63-1.el9.noarc    2/33 
  Running scriptlet: container-selinux-4:2.240.0-1.el9.noarch       3/33 
  Installing       : container-selinux-4:2.240.0-1.el9.noarch       3/33 
  Running scriptlet: container-selinux-4:2.240.0-1.el9.noarch       3/33 
  Installing       : docker-buildx-plugin-0.26.1-1.el9.x86_64       4/33 
  Running scriptlet: docker-buildx-plugin-0.26.1-1.el9.x86_64       4/33 
  Installing       : docker-compose-plugin-2.39.1-1.el9.x86_64      5/33 
  Running scriptlet: docker-compose-plugin-2.39.1-1.el9.x86_64      5/33 
  Installing       : fuse3-libs-3.10.2-9.el9.x86_64                 6/33 
  Installing       : kmod-28-10.el9.x86_64                          7/33 
  Installing       : docker-ce-cli-1:28.3.3-1.el9.x86_64            8/33 
  Running scriptlet: docker-ce-cli-1:28.3.3-1.el9.x86_64            8/33 
  Installing       : containerd.io-1.7.27-3.1.el9.x86_64            9/33 
  Running scriptlet: containerd.io-1.7.27-3.1.el9.x86_64            9/33 
  Upgrading        : rpm-libs-4.16.1.3-37.el9.x86_64               10/33 
  Upgrading        : rpm-4.16.1.3-37.el9.x86_64                    11/33 
  Upgrading        : rpm-build-libs-4.16.1.3-37.el9.x86_64         12/33 
  Upgrading        : rpm-sign-libs-4.16.1.3-37.el9.x86_64          13/33 
  Installing       : iptables-legacy-libs-1.8.10-11.1.el9.x86_64   14/33 
  Installing       : libslirp-4.4.0-8.el9.x86_64                   15/33 
  Installing       : slirp4netns-1.3.3-1.el9.x86_64                16/33 
  Installing       : xz-5.2.5-8.el9.x86_64                         17/33 
  Installing       : libnfnetlink-1.0.1-23.el9.x86_64              18/33 
  Installing       : libnetfilter_conntrack-1.0.9-1.el9.x86_64     19/33 
  Installing       : iptables-libs-1.8.10-11.el9.x86_64            20/33 
  Installing       : iptables-legacy-1.8.10-11.1.el9.x86_64        21/33 
  Running scriptlet: iptables-legacy-1.8.10-11.1.el9.x86_64        21/33 
  Installing       : fuse-common-3.10.2-9.el9.x86_64               22/33 
  Installing       : fuse3-3.10.2-9.el9.x86_64                     23/33 
  Installing       : fuse-overlayfs-1.15-1.el9.x86_64              24/33 
  Running scriptlet: fuse-overlayfs-1.15-1.el9.x86_64              24/33 
  Installing       : docker-ce-3:28.3.3-1.el9.x86_64               25/33 
  Running scriptlet: docker-ce-3:28.3.3-1.el9.x86_64               25/33 
  Installing       : docker-ce-rootless-extras-28.3.3-1.el9.x86_   26/33 
  Running scriptlet: docker-ce-rootless-extras-28.3.3-1.el9.x86_   26/33 
  Upgrading        : python3-rpm-4.16.1.3-37.el9.x86_64            27/33 
  Installing       : rpm-plugin-selinux-4.16.1.3-37.el9.x86_64     28/33 
  Cleanup          : python3-rpm-4.16.1.3-30.el9.x86_64            29/33 
  Cleanup          : rpm-build-libs-4.16.1.3-30.el9.x86_64         30/33 
  Cleanup          : rpm-sign-libs-4.16.1.3-30.el9.x86_64          31/33 
  Cleanup          : rpm-4.16.1.3-30.el9.x86_64                    32/33 
  Cleanup          : rpm-libs-4.16.1.3-30.el9.x86_64               33/33 
  Running scriptlet: selinux-policy-targeted-38.1.63-1.el9.noarc   33/33 
  Running scriptlet: container-selinux-4:2.240.0-1.el9.noarch      33/33 
  Running scriptlet: rpm-4.16.1.3-37.el9.x86_64                    33/33 
  Running scriptlet: rpm-libs-4.16.1.3-30.el9.x86_64               33/33 
  Verifying        : fuse-common-3.10.2-9.el9.x86_64                1/33 
  Verifying        : iptables-libs-1.8.10-11.el9.x86_64             2/33 
  Verifying        : kmod-28-10.el9.x86_64                          3/33 
  Verifying        : libnetfilter_conntrack-1.0.9-1.el9.x86_64      4/33 
  Verifying        : libnfnetlink-1.0.1-23.el9.x86_64               5/33 
  Verifying        : rpm-plugin-selinux-4.16.1.3-37.el9.x86_64      6/33 
  Verifying        : selinux-policy-38.1.63-1.el9.noarch            7/33 
  Verifying        : selinux-policy-targeted-38.1.63-1.el9.noarc    8/33 
  Verifying        : xz-5.2.5-8.el9.x86_64                          9/33 
  Verifying        : container-selinux-4:2.240.0-1.el9.noarch      10/33 
  Verifying        : fuse-overlayfs-1.15-1.el9.x86_64              11/33 
  Verifying        : fuse3-3.10.2-9.el9.x86_64                     12/33 
  Verifying        : fuse3-libs-3.10.2-9.el9.x86_64                13/33 
  Verifying        : libslirp-4.4.0-8.el9.x86_64                   14/33 
  Verifying        : slirp4netns-1.3.3-1.el9.x86_64                15/33 
  Verifying        : containerd.io-1.7.27-3.1.el9.x86_64           16/33 
  Verifying        : docker-buildx-plugin-0.26.1-1.el9.x86_64      17/33 
  Verifying        : docker-ce-3:28.3.3-1.el9.x86_64               18/33 
  Verifying        : docker-ce-cli-1:28.3.3-1.el9.x86_64           19/33 
  Verifying        : docker-ce-rootless-extras-28.3.3-1.el9.x86_   20/33 
  Verifying        : docker-compose-plugin-2.39.1-1.el9.x86_64     21/33 
  Verifying        : iptables-legacy-1.8.10-11.1.el9.x86_64        22/33 
  Verifying        : iptables-legacy-libs-1.8.10-11.1.el9.x86_64   23/33 
  Verifying        : python3-rpm-4.16.1.3-37.el9.x86_64            24/33 
  Verifying        : python3-rpm-4.16.1.3-30.el9.x86_64            25/33 
  Verifying        : rpm-4.16.1.3-37.el9.x86_64                    26/33 
  Verifying        : rpm-4.16.1.3-30.el9.x86_64                    27/33 
  Verifying        : rpm-build-libs-4.16.1.3-37.el9.x86_64         28/33 
  Verifying        : rpm-build-libs-4.16.1.3-30.el9.x86_64         29/33 
  Verifying        : rpm-libs-4.16.1.3-37.el9.x86_64               30/33 
  Verifying        : rpm-libs-4.16.1.3-30.el9.x86_64               31/33 
  Verifying        : rpm-sign-libs-4.16.1.3-37.el9.x86_64          32/33 
  Verifying        : rpm-sign-libs-4.16.1.3-30.el9.x86_64          33/33 

Upgraded:
  python3-rpm-4.16.1.3-37.el9.x86_64     rpm-4.16.1.3-37.el9.x86_64      
  rpm-build-libs-4.16.1.3-37.el9.x86_64  rpm-libs-4.16.1.3-37.el9.x86_64 
  rpm-sign-libs-4.16.1.3-37.el9.x86_64  
Installed:
  container-selinux-4:2.240.0-1.el9.noarch                               
  containerd.io-1.7.27-3.1.el9.x86_64                                    
  docker-buildx-plugin-0.26.1-1.el9.x86_64                               
  docker-ce-3:28.3.3-1.el9.x86_64                                        
  docker-ce-cli-1:28.3.3-1.el9.x86_64                                    
  docker-ce-rootless-extras-28.3.3-1.el9.x86_64                          
  docker-compose-plugin-2.39.1-1.el9.x86_64                              
  fuse-common-3.10.2-9.el9.x86_64                                        
  fuse-overlayfs-1.15-1.el9.x86_64                                       
  fuse3-3.10.2-9.el9.x86_64                                              
  fuse3-libs-3.10.2-9.el9.x86_64                                         
  iptables-legacy-1.8.10-11.1.el9.x86_64                                 
  iptables-legacy-libs-1.8.10-11.1.el9.x86_64                            
  iptables-libs-1.8.10-11.el9.x86_64                                     
  kmod-28-10.el9.x86_64                                                  
  libnetfilter_conntrack-1.0.9-1.el9.x86_64                              
  libnfnetlink-1.0.1-23.el9.x86_64                                       
  libslirp-4.4.0-8.el9.x86_64                                            
  rpm-plugin-selinux-4.16.1.3-37.el9.x86_64                              
  selinux-policy-38.1.63-1.el9.noarch                                    
  selinux-policy-targeted-38.1.63-1.el9.noarch                           
  slirp4netns-1.3.3-1.el9.x86_64                                         
  xz-5.2.5-8.el9.x86_64                                                  

Complete!
[root@stapp03 banner]# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:-- 100 12.1M  100 12.1M    0     0  30.3M      0 --:--:-- --:--:-- --:--:--  102M
[root@stapp03 banner]# sudo chmod +x /usr/local/bin/docker-compose
[root@stapp03 banner]# sudo systemctl start docker
sudo systemctl enable docker

Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.
[root@stapp03 banner]# History |cut -c 8-
bash: History: command not found
[root@stapp03 banner]# history |cut -c 8-
cat /etc/os-release
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl start docker
sudo systemctl enable docker
History |cut -c 8-
history |cut -c 8-
[root@stapp03 banner]# 
