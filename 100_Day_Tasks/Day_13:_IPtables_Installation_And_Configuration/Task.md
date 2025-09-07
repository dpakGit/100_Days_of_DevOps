## Task :

Provide a detailed and clear explanation of the following task - We have one of our websites up and running on our Nautilus infrastructure in Stratos DC. Our security team has raised a concern that right now Apache’s port i.e 6300 is open for all since there is no firewall installed on these hosts. So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:

1. Install iptables and all its dependencies on each app host.


2. Block incoming port 6300 on all apps for everyone except for LBR host.


3. Make sure the rules remain, even after system reboot.

Task summary by AI:
- Adding security to app hosts in Nautilus infrastructure for Apache on port 6300.
- Requirements:
    1. Install iptables.
    2. Allow LBR host to access port 6300; block others.
    3. Persist iptables rules on reboot.

   


### What I Did


#### I've written a shell script apache.sh to configure iptables on App Servers, allowing access to port 3002 only from the Load Balancer (LB) host (172.16.238.14).

```
#!/bin/bash
sudo yum install iptables-services -y
iptables -F
sudo iptables -A INPUT -p tcp --dport 3002 -s 172.16.238.14 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 3002 -j DROP
sudo systemctl enable iptables
sudo systemctl start iptables
sudo iptables-save | sudo tee /etc/sysconfig/iptables
```

### Post-script commands explanation

```
sudo iptables -L -v -n
```
This command lists all current iptables rules

```
sudo chmod +x apache.sh
```
Makes the script executable (note: filename mismatch with apache.sh in script description).


```
sudo ./apache.sh #  Runs the script.
```


From LB Host:

```
curl http://<app-server-IP>:3002 - *Tests access to App Server port 3002*.
```
----------------------------------------

### Following is the breakdown of commands in the shell script :

```
#!/bin/bash
```

```
sudo yum install iptables-services -y
```
Installs iptables-services package for managing iptables rules.


```
iptables -F
```
Flushes (clears) all existing iptables rules.


```
sudo iptables -A INPUT -p tcp --dport 3002 -s 172.16.238.14 -j ACCEPT
```
Allows TCP traffic on port 3002 only from LB host (172.16.238.14).


```
sudo iptables -A INPUT -p tcp --dport 3002 -j DROP
```
Drops all other TCP traffic on port 3002 from other IPs.


```
sudo systemctl enable iptables
```
Enables iptables service to start on boot.


```
sudo systemctl start iptables
```
Starts the iptables service.


```
sudo iptables-save | sudo tee /etc/sysconfig/iptables
```
Saves current iptables rules to /etc/sysconfig/iptables.

This pipes output to tee, which writes with elevated privileges.

- *iptables-save*: Dumps the current iptables ruleset to standard output.

- *| (pipe)*: Pipes the output to the next command.

- *sudo tee /etc/sysconfig/iptables*:

    - tee writes the input to the file /etc/sysconfig/iptables.
    
    - sudo ensures write permissions to this file.

**tee in sudo iptables-save | sudo tee /etc/sysconfig/iptables**

- *tee* is a command that:

    - Reads from standard input.
    
    - Writes to standard output AND to a specified file.

- Here, tee writes iptables-save output to:

    - Standard output (visible in terminal).
    
    - The file /etc/sysconfig/iptables.

*Why use tee here?*

- Allows saving output to a file *with sudo privileges*.

- Alternative (like >) might need a whole command wrapped in sudo for redirection.

Do you need help with:

--------------------------------
