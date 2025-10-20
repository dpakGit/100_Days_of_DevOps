### Task : Ansible Lineinfile Module

The Nautilus DevOps team want to install and set up a simple httpd web server on all app servers in Stratos DC. They also want to deploy a sample web page using Ansible. Therefore, write the required playbook to complete this task as per details mentioned below.


We already have an inventory file under /home/thor/ansible directory on jump host. Write a playbook playbook.yml under /home/thor/ansible directory on jump host itself. Using the playbook perform below given tasks:


Install httpd web server on all app servers, and make sure its service is up and running.


Create a file /var/www/html/index.html with content:


This is a Nautilus sample file, created using Ansible!


Using lineinfile Ansible module add some more content in /var/www/html/index.html file. Below is the content:

Welcome to Nautilus Group!


Also make sure this new line is added at the top of the file.


The /var/www/html/index.html file's user and group owner should be apache on all app servers.


The /var/www/html/index.html file's permissions should be 0744 on all app servers.


Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

### What I Did
```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ cd ansible/
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=bannerthor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ # Create playbook.yml with httpd installation and lineinfile tasks
thor@jumphost ~/ansible$ cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    # Install httpd web server
    - name: Install httpd package
      package:
        name: httpd
        state: present
    
    # Start and enable httpd service
    - name: Start and enable httpd service
      service:
        name: httpd
        state: started
        enabled: yes
    
    # Create initial index.html file with base content
    - name: Create index.html with initial content
      copy:
        content: "This is a Nautilus sample file, created using Ansible!" 
EOF     state: file 'w/html/index.htmlpermissions for index.htmlineinfile
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory  playbook.yml
thor@jumphost ~/ansible$ # Test connectivity to all app servers
ansible -i inventory all -m ping
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/ansible$ # Run the playbook
ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]
ok: [stapp02]
ok: [stapp03]

TASK [Install httpd package] ***************************************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

TASK [Start and enable httpd service] ******************************************
changed: [stapp02]
changed: [stapp03]
changed: [stapp01]

TASK [Create index.html with initial content] **********************************
changed: [stapp01]
changed: [stapp03]
changed: [stapp02]

TASK [Add welcome message at the top of index.html using lineinfile] ***********
changed: [stapp02]
changed: [stapp01]
changed: [stapp03]

TASK [Set correct ownership and permissions for index.html] ********************
ok: [stapp01]
ok: [stapp02]
ok: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$ # Verify httpd service is running on all servers 
ansible -i inventory all -m shell -a "systemctl status httpd --no-pager -l"
stapp03 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Mon 2025-10-20 04:34:24 UTC; 49s ago
       Docs: man:httpd.service(8)
   Main PID: 3914 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 411140)
     Memory: 16.1M
     CGroup: /docker/10f2ea3becd3e4973513a647192c238ff662be004ba5243368e3094afb007704/system.slice/httpd.service
             ├─3914 /usr/sbin/httpd -DFOREGROUND
             ├─3921 /usr/sbin/httpd -DFOREGROUND
             ├─3922 /usr/sbin/httpd -DFOREGROUND
             ├─3923 /usr/sbin/httpd -DFOREGROUND
             └─3924 /usr/sbin/httpd -DFOREGROUND

Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Configuration loaded.)
Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> running
Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 294 httpd.service/start finished, result=done
Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: Started The Apache HTTP Server.
Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed to send unit change signal for httpd.service: Connection reset by peer
Oct 20 04:34:24 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Started, listening on: port 80, MAINPID=3914)
Oct 20 04:34:33 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:43 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:53 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:35:03 stapp03.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3914 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
stapp01 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Mon 2025-10-20 04:34:24 UTC; 48s ago
       Docs: man:httpd.service(8)
   Main PID: 3919 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 411140)
     Memory: 16.4M
     CGroup: /docker/2ab40eeccbc5b426c29fcac52a0d93a64032a758e33b576271591eab25e753fb/system.slice/httpd.service
             ├─3919 /usr/sbin/httpd -DFOREGROUND
             ├─3927 /usr/sbin/httpd -DFOREGROUND
             ├─3928 /usr/sbin/httpd -DFOREGROUND
             ├─3929 /usr/sbin/httpd -DFOREGROUND
             └─3930 /usr/sbin/httpd -DFOREGROUND

Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Configuration loaded.)
Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> running
Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 294 httpd.service/start finished, result=done
Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: Started The Apache HTTP Server.
Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed to send unit change signal for httpd.service: Connection reset by peer
Oct 20 04:34:24 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Started, listening on: port 80, MAINPID=3919)
Oct 20 04:34:33 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:43 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:53 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:35:03 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3919 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
stapp02 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Mon 2025-10-20 04:34:24 UTC; 49s ago
       Docs: man:httpd.service(8)
   Main PID: 3902 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 411140)
     Memory: 16.3M
     CGroup: /docker/33d8812ae85931710db4f7d1978c9bfb656bd40b199c3b03f595e1c971350ff0/system.slice/httpd.service
             ├─3902 /usr/sbin/httpd -DFOREGROUND
             ├─3909 /usr/sbin/httpd -DFOREGROUND
             ├─3910 /usr/sbin/httpd -DFOREGROUND
             ├─3911 /usr/sbin/httpd -DFOREGROUND
             └─3912 /usr/sbin/httpd -DFOREGROUND

Oct 20 04:34:24 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Changed start -> running
Oct 20 04:34:24 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Job 294 httpd.service/start finished, result=done
Oct 20 04:34:24 stapp02.stratos.xfusioncorp.com systemd[1]: Started The Apache HTTP Server.
Oct 20 04:34:24 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Failed to send unit change signal for httpd.service: Connection reset by peer
Oct 20 04:34:24 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Started, listening on: port 80, MAINPID=3902)
Oct 20 04:34:33 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:43 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:34:53 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:35:03 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
Oct 20 04:35:13 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 3902 (READY=1, STATUS=Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec)
thor@jumphost ~/ansible$ # Verify the content of index.html file
ansible -i inventory all -m shell -a "cat /var/www/html/index.html"
stapp01 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
stapp03 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
stapp02 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
thor@jumphost ~/ansible$ # Verify file ownership and permissions
ansible -i inventory all -m shell -a "ls -la /var/www/html/index.html"
stapp03 | CHANGED | rc=0 >>
-rwxr--r-- 1 apache apache 81 Oct 20 04:34 /var/www/html/index.html
stapp02 | CHANGED | rc=0 >>
-rwxr--r-- 1 apache apache 81 Oct 20 04:34 /var/www/html/index.html
stapp01 | CHANGED | rc=0 >>
-rwxr--r-- 1 apache apache 81 Oct 20 04:34 /var/www/html/index.html
thor@jumphost ~/ansible$ # Test web server response
ansible -i inventory all -m shell -a "curl -s localhost"
stapp03 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
stapp02 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
stapp01 | CHANGED | rc=0 >>
Welcome to Nautilus Group!
This is a Nautilus sample file, created using Ansible!
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory  playbook.yml
thor@jumphost ~/ansible$ 
```
