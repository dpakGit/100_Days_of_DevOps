**What I Did**

First Attempt: Using Medium article
-------------------------------

thor@jumphost ~$ ssh tony@172.16.238.10 

[tony@stapp01 ~]$ sudo -s

[root@stapp01 tony]# systemctl status apache2 # This command did not work with the name apache2

Unit apache2.service could not be found.

[root@stapp01 tony]# systemctl status httpd

● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendo
r preset: disabled)
   Active: failed (Result: exit-code) since Fri 2025-08-08 13:
47:14 UTC; 4min 12s ago
     Docs: man:httpd.service(8)
  Process: 493 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (c
ode=exited, status=1/FAILURE)
 Main PID: 493 (code=exited, status=1/FAILURE)
   Status: "Reading configuration..."

Aug 08 13:47:14 stapp01.stratos.xfusioncorp.com httpd[493]: (98)**Address a
lready in use**: AH00072: make_sock: could not bind to address 0.0.0.0:6300

[root@stapp01 tony]# systemctl start httpd

Job for httpd.service failed because the control process exited with error code.

See "systemctl status httpd.service" and "journalctl -xe" for details.

[root@stapp01 tony]# sudo netstat -tulnp | grep 6300

tcp        0      0 127.0.0.1:6300          0.0.0.0:*               LISTEN      432/sendmail: accep 

- Process (sendmail,PID 432), is using port 6300 ,causing Apache to fail with the error ‘Address already in use’.

[root@stapp01 tony]# kill 432

[root@stapp01 tony]# sudo systemctl start httpd

[root@stapp01 tony]# systemctl status httpd

● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendo
r preset: disabled)
   Active: active (running) since Fri 2025-08-08 13:58:30 UTC;
 7s ago
     Docs: man:httpd.service(8)
 Main PID: 870 (httpd)
   Status: "Started, listening on: port 6300"
    Tasks: 213 (limit: 411434)
   Memory: 21.6M
 
- Output is active running

[root@stapp01 tony]# sudo netstat -tulnp | grep 6300

tcp        0      0 0.0.0.0:6300            0.0.0.0:*               LISTEN      870/httpd           

[root@stapp01 tony]# # Firewall Troubleshooting

[root@stapp01 tony]# sudo iptables -L -n

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
 Warning: iptables-legacy tables present, use iptables-legacy to see them


[root@stapp01 tony]# sudo iptables -I INPUT -p tcp --dport 6300 -j ACCEPT 

[root@stapp01 tony]# sudo iptables -L -n # To verify

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:6300
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:5004
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
 Warning: iptables-legacy tables present, use iptables-legacy to see them

[root@stapp01 tony]# sudo service iptables save

iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]

[root@stapp01 tony]# sudo service iptables restart

Redirecting to /bin/systemctl restart iptables.service

[root@stapp01 tony]# exit
exit
[tony@stapp01 ~]$ 

thor@jumphost ~$ curl http://stapp01:3000

-------------------------------------------


Second Attempt : Using MetaAI 
--------------------------------



thor@jumphost ~$ ssh tony@172.16.238.10 

[tony@stapp01 ~]$ sudo -s

[root@stapp01 tony]# systemctl status httpd

[root@stapp01 tony]# systemctl start httpd

[root@stapp01 tony]# ss -tnlp | grep httpd

bash: ss: command not found

[root@stapp01 tony]# netstat -tlnp | grep httpd

[root@stapp01 tony]# netstat -tlnp | grep 3000

tcp        0      0 127.0.0.1:3000          0.0.0.0:*               LISTEN      447/sendmail: accep 

[root@stapp01 tony]# netstat -tulnp | grep 3000

tcp        0      0 127.0.0.1:3000          0.0.0.0:*               LISTEN      447/sendmail: accep 

[root@stapp01 tony]# kill 447

[root@stapp01 tony]# netstat -tulnp | grep 3000

[root@stapp01 tony]# systemctl start httpd

[root@stapp01 tony]# netstat -tulnp | grep 3000
tcp        0      0 0.0.0.0:3000            0.0.0.0:*               LISTEN      889/httpd           

[root@stapp01 tony]# ufw status
bash: ufw: command not found

[root@stapp01 tony]#  firewall-cmd --list-all

bash: firewall-cmd: command not found

**Note:**
```
*If both ufw and firewall-cmd commands aren't found on stapp01, the system might be using a different firewall management tool or maybe no firewall is configured.*
Possible reasons
- No firewall tool installed: Neither ufw nor firewalld is being used.
- Different firewall tool: The system could be using iptables directly.

*Check using iptables*
- Try listing iptables rules:

bash
sudo iptables -L -n -v

- This shows current iptables rules if they're being used to manage the firewall.

Next steps
- If no firewall rules are blocking port 8084, and Apache isn't reachable, double-check Apache config and logs.
- If you need to allow port 8084, you'd typically add rules via iptables if that's what's being used.


*To allow port 3000 via iptables, you'd add a rule like this:*
*Allow port 3000 with iptables*
- Use this command to allow incoming traffic on port 3000:

bash
sudo iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

- What it does:
    - -A INPUT: Appends a rule to the INPUT chain.
    - -p tcp: Specifies TCP protocol.
    - --dport 3000: Matches traffic destined for port 3000.
    - -j ACCEPT: Accepts matching traffic.

*Saving iptables rules*
- Rules aren't persistent by default; to save:

bash
sudo service iptables save

- Or use iptables-save depending on the system.


*You typically don't need to restart the iptables service after saving rules.*
Why
- iptables rules are applied immediately when added.
- Saving rules (sudo service iptables save) writes them to a config file for persistence across reboots.
- No need to restart iptables service for rules to take effect.

Instead
- If you made changes and want to ensure they're in effect, check with:

bash
sudo iptables -L -n -v

- Rules are active as soon as you add them with iptables.

```

[root@stapp01 tony]# sudo iptables -L -n -v

-L: Lists the rules
-v: Provides verbose output
-n: Displays IP addresses instead of resolving hostnames

Output:
......
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
  520 39729 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0           
    1    60 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT 306 packets, 34513 bytes)
 pkts bytes target     prot opt in     out     source               destination         
 Warning: iptables-legacy tables present, use iptables-legacy to see them


[root@stapp01 tony]# sudo iptables -I INPUT -p tcp --dport 3000 -j ACCEPT 


[root@stapp01 tony]# sudo iptables -L -n -v

Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:3000
  589 44829 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0           
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0           
    1    60 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT 350 packets, 40945 bytes)
 pkts bytes target     prot opt in     out     source               destination         
 Warning: iptables-legacy tables present, use iptables-legacy to see them

[root@stapp01 tony]# sudo service iptables save

iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]

[root@stapp01 tony]# sudo service iptables restart

Redirecting to /bin/systemctl restart iptables.service


[root@stapp01 tony]# systemctl status httpd

● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendo
r preset: disabled)
   Active: active (running) since Fri 2025-08-08 14:19:32 UTC;
 9min ago
     Docs: man:httpd.service(8)
 Main PID: 889 (httpd)
   Status: "Running, listening on: port 3000"
    Tasks: 213 (limit: 411434)
   Memory: 21.7M
   CGroup: /docker/128ff3671a6e231700246cecf37ea46e3498094d248f705809bd5d
abcc83a9ae/system.slice/httpd.service
           ├─889 /usr/sbin/httpd -DFOREGROUND
           ├─914 /usr/sbin/httpd -DFOREGROUND
           ├─915 /usr/sbin/httpd -DFOREGROUND
           ├─916 /usr/sbin/httpd -DFOREGROUND
           └─917 /usr/sbin/httpd -DFOREGROUND

Aug 08 14:27:31 stapp01.stratos.xfusioncorp.com systemd[1]: 
httpd.service: Got notification message from PID 889 (READY=1,
 STATUS=Running, listening on: port 3000)
Aug 08 14:27:41 stapp01.stratos.xfusioncorp.com systemd[1]: 

[root@stapp01 tony]# 

**History**

[root@stapp01 tony]# history | cut -c 8-
systemctl status apache2
systemctl status httpd
systemctl start httpd
ss -tnlo | grep httpd
ss -tnlp | grep httpd
netstat -tlnp | grep httpd
netstat -tlnp | grep 3000
sudo netstat -tulnp | grep 5004
netstat -tulnp | grep 3000
kill 447
netstat -tulnp | grep 3000
systemctl start httpd
netstat -tulnp | grep 3000
systemctl stat
 firewall-cmd --list-all
sudo iptables -L -n -v
sudo iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
sudo iptables -L -n -v
sudo service iptables save
sudo service iptables restart
sudo iptables -L -n -v
systemctl status httpd
history | cut -c 8-
[root@stapp01 tony]# 

thor@jumphost ~$ curl http://stapp01:3000
curl http://stapp01:3000
history | cut -c 8-

---------------------------------


**Meta AI Solutions:**
-------------------------------

Elaborate explanation of each command in the Steps to Troubleshoot and Fix the Issue.
*Step 1: Check if Apache service is running on stapp01*
- *sudo systemctl status apache2*: Checks the current status of the Apache service (active, inactive, etc.). You might see httpd instead of apache2 on some systems.
- *sudo systemctl start apache2*: Starts the Apache service if it's not running.

*Step 2: Verify Apache is listening on port 8084 on stapp01*
- *sudo netstat -tlnp | grep apache2*:
    - *netstat -tlnp*: Lists all listening TCP (-t) ports (-l listening, -n numeric, -p show PID/program).
    - *grep apache2*: Filters output to show lines related to Apache.
- *sudo ss -tlnp | grep apache2*: Similar to netstat, but ss is more modern. Checks if Apache is listening on port 8084.

*Step 3: Check firewall rules on stapp01*
- *sudo ufw status*: Shows the status of ufw firewall rules if ufw is used.
- *sudo firewall-cmd --list-all*: Lists all firewall rules if firewalld is used.
- *sudo ufw allow 8084/tcp*: Adds a rule to allow traffic on port 8084 via ufw.
- *sudo firewall-cmd --add-port=8084/tcp --permanent*: Adds a permanent rule for port 8084 via firewalld.
- *sudo firewall-cmd --reload*: Reloads firewalld rules to apply changes.

Step 4: Test connectivity from Jump host
- *curl http://stapp01:8084*: Sends an HTTP request to Apache on stapp01 port 8084 and shows the response (if Apache is serving content).



**If sudo ss -tlnp | grep httpd gives sudo: ss: command not found, you can use netstat instead.**
*Alternative command using netstat*
- Try using:

bash
sudo netstat -tlnp | grep httpd

- This does the same thing as ss:
    - Lists listening TCP ports (-tlnp).
    - Shows PID/program name.
    - grep httpd filters for Apache (httpd on some systems).

*Why ss wasn't found*
- ss is part of iproute2 utilities.
- If ss isn't available, netstat (part of net-tools) is a good fallback.

