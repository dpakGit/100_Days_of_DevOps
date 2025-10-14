### Task : Copy Data to App Servers using Ansible

The Nautilus DevOps team needs to copy data from the jump host to all application servers in Stratos DC using Ansible. Execute the task with the following details:


a. Create an inventory file /home/thor/ansible/inventory on jump_host and add all application servers as managed nodes.


b. Create a playbook /home/thor/ansible/playbook.yml on the jump host to copy the /usr/src/sysops/index.html file to all application servers, placing it at /opt/sysops.


Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook functions properly without any extra arguments.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ mkdir -p /home/thor/ansible
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ ^C
thor@jumphost ~$ # Navigate to ansible directory (create if doesn't exist)
mkdir -p /home/thor/ansible
cd /home/thor/ansible

# Create inventory file with all application servers
cat > inventory << 'EOF'
[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33n ansible_become_password=BigGr33n

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
thor@jumphost ~/ansible$ ls
inventory
thor@jumphost ~/ansible$ # Create playbook to copy index.html to all app servers
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Create destination directory /opt/data
      file:
        path: /opt/data
        state: directory
        mode: '0755'
    
    - name: Copy index.html from jump host to app servers
      copy:
        src: /usr/src/data/index.html
        dest: /opt/data/index.html
        mode: '0644'
EOF
thor@jumphost ~/ansible$ ls
inventory  playbook.yml
thor@jumphost ~/ansible$ ansible -i inventory all -m ping
stapp02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp03 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Create destination directory /opt/data] **********************************
changed: [stapp02]
changed: [stapp03]
changed: [stapp01]

TASK [Copy index.html from jump host to app servers] ***************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
fatal: [stapp02]: FAILED! => {"changed": false, "msg": "Could not find or access '/usr/src/data/index.html' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
fatal: [stapp01]: FAILED! => {"changed": false, "msg": "Could not find or access '/usr/src/data/index.html' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
fatal: [stapp03]: FAILED! => {"changed": false, "msg": "Could not find or access '/usr/src/data/index.html' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}

PLAY RECAP *********************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$ ls
inventory  playbook.yml
thor@jumphost ~/ansible$ rm -rf playbook.yml 
thor@jumphost ~/ansible$ # Create playbook to copy index.html to all app servers
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Create destination directory /opt/data
      file:
        path: /opt/data
        state: directory
        mode: '0755'
    
    - name: Copy index.html from jump host to app servers
      copy:
        src: /usr/src/sysops/index.html
        dest: /opt/sysops/index.html
        mode: '0644'
EOF
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Create destination directory /opt/data] **********************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Copy index.html from jump host to app servers] ***************************
changed: [stapp01]
changed: [stapp03]
changed: [stapp02]

PLAY RECAP *********************************************************************
stapp01                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$ # Made changes in the playbook according to my question 
thor@jumphost ~/ansible$ ansible -i inventory all -m shell -a "ls -la /opt/sysops/index.html"
stapp01 | CHANGED | rc=0 >>
-rw-r--r-- 1 root root 35 Oct 14 10:31 /opt/sysops/index.html
stapp03 | CHANGED | rc=0 >>
-rw-r--r-- 1 root root 35 Oct 14 10:31 /opt/sysops/index.html
stapp02 | CHANGED | rc=0 >>
-rw-r--r-- 1 root root 35 Oct 14 10:31 /opt/sysops/index.html
```
```
thor@jumphost ~/ansible$ history | cut -c 8-
pwd
ls
mkdir -p /home/thor/ansible
ls
# Navigate to ansible directory (create if doesn't exist)
mkdir -p /home/thor/ansible
cd /home/thor/ansible
# Create inventory file with all application servers
cat > inventory << 'EOF'
rvers]
 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n
 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_become_password=Am3ric@
 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33n ansible_become_password=BigGr33n

rvers:vars]
_become=yes
_become_method=sudo
_python_interpreter=/usr/bin/python3
_ssh_common_args='-o StrictHostKeyChecking=no'


ls
# Create playbook to copy index.html to all app servers
cat > playbook.yml << 'EOF'

: all
e: yes
:
ame: Create destination directory /opt/data
ile:
 path: /opt/data
 state: directory
 mode: '0755'

ame: Copy index.html from jump host to app servers
opy:
 src: /usr/src/data/index.html
 dest: /opt/data/index.html
 mode: '0644'


ls
ansible -i inventory all -m ping
ansible-playbook -i inventory playbook.yml
ls
rm -rf playbook.yml 
# Create playbook to copy index.html to all app servers
cat > playbook.yml << 'EOF'

: all
e: yes
:
ame: Create destination directory /opt/data
ile:
 path: /opt/data
 state: directory
 mode: '0755'

ame: Copy index.html from jump host to app servers
opy:
 src: /usr/src/sysops/index.html
 dest: /opt/sysops/index.html
 mode: '0644'


ansible-playbook -i inventory playbook.yml
# Made changes in the playbook according to my question 
ansible -i inventory all -m shell -a "ls -la /opt/sysops/index.html"
history | cut -c 8-
thor@jumphost ~/ansible$ ls
inventory  playbook.yml
thor@jumphost ~/ansible$
```
