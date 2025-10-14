### Task : Create Files on App Servers using Ansible

The Nautilus DevOps team is testing various Ansible modules on servers in Stratos DC. They're currently focusing on file creation on remote hosts using Ansible. Here are the details:


a. Create an inventory file ~/playbook/inventory on jump host and include all app servers.


b. Create a playbook ~/playbook/playbook.yml to create a blank file /opt/code.txt on all app servers.


c. Set the permissions of the /opt/code.txt file to 0644.


d. Ensure the user/group owner of the /opt/code.txt file is tony on app server 1, steve on app server 2 and banner on app server 3.


Note: Validation will execute the playbook using the command ansible-playbook -i inventory playbook.yml, so ensure the playbook functions correctly without any additional arguments.

### What I Did

```
thor@jumphost ~$ ls
playbook
thor@jumphost ~$ cd playbook/
thor@jumphost ~/playbook$ ls
thor@jumphost ~/playbook$ # Navigate to playbook directory (create if doesn't exist)
mkdir -p ~/playbook
cd ~/playbook

# Create inventory file with all app servers
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
thor@jumphost ~/playbook$ ls
inventory
thor@jumphost ~/playbook$ # Create playbook to create webdata.txt with specific ownership per server
cat > playbook.yml << 'EOF'
---
- hosts: stapp01
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 1
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
        owner: tony
        group: tony

- hosts: stapp02
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 2
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
EOF     group: bannerpp.txtp.txt on App Server 3
thor@jumphost ~/playbook$ ls
inventory  playbook.yml
thor@jumphost ~/playbook$ rm -rf playbook.yml 
thor@jumphost ~/playbook$ # Create playbook to create webdata.txt with specific ownership per server
cat > playbook.yml << 'EOF'
---
- hosts: stapp01
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 1
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
        owner: tony
        group: tony

- hosts: stapp02
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 2
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
EOF     group: bannerpp.txtp.txt on App Server 3
thor@jumphost ~/playbook$ ls
inventory  playbook.yml
thor@jumphost ~/playbook$ cat playbook.yml 
---
- hosts: stapp01
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 1
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
        owner: tony
        group: tony

- hosts: stapp02
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 2
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
        owner: steve
        group: steve

- hosts: stapp03
  become: yes
  tasks:
    - name: Create /home/app.txt on App Server 3
      file:
        path: /home/app.txt
        state: touch
        mode: '0755'
        owner: banner
        group: banner
thor@jumphost ~/playbook$ ansible -i inventory all -m ping
stapp03 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/playbook$ ansible-playbook -i inventory playbook.yml

PLAY [stapp01] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]

TASK [Create /home/app.txt on App Server 1] ************************************
changed: [stapp01]

PLAY [stapp02] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp02]

TASK [Create /home/app.txt on App Server 2] ************************************
changed: [stapp02]

PLAY [stapp03] *****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp03]

TASK [Create /home/app.txt on App Server 3] ************************************
changed: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/playbook$ ansible -i inventory all -m shell -a "ls -la /home/app.txt"
stapp03 | CHANGED | rc=0 >>
-rwxr-xr-x 1 banner banner 0 Oct 14 10:56 /home/app.txt
stapp02 | CHANGED | rc=0 >>
-rwxr-xr-x 1 steve steve 0 Oct 14 10:56 /home/app.txt
stapp01 | CHANGED | rc=0 >>
-rwxr-xr-x 1 tony tony 0 Oct 14 10:56 /home/app.txt
```
```
history | cut -c 8-
ls
cd playbook/
ls
# Navigate to playbook directory (create if doesn't exist)
mkdir -p ~/playbook
cd ~/playbook
# Create inventory file with all app servers
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
# Create playbook to create webdata.txt with specific ownership per server
cat > playbook.yml << 'EOF'

: stapp01
e: yes
:
ame: Create /home/app.txt on App Server 1
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: tony
 group: tony

: stapp02
e: yes
:
ame: Create /home/app.txt on App Server 2
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: steve
 group: steve

: stapp03
e: yes
:
ame: Create /home/app.txt on App Server 3
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: banner
 group: banner


ls
rm -rf playbook.yml 
# Create playbook to create webdata.txt with specific ownership per server
cat > playbook.yml << 'EOF'

: stapp01
e: yes
:
ame: Create /home/app.txt on App Server 1
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: tony
 group: tony

: stapp02
e: yes
:
ame: Create /home/app.txt on App Server 2
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: steve
 group: steve

: stapp03
e: yes
:
ame: Create /home/app.txt on App Server 3
ile:
 path: /home/app.txt
 state: touch
 mode: '0755'
 owner: banner
 group: banner


ls
cat playbook.yml 
ansible -i inventory all -m ping
ansible-playbook -i inventory playbook.yml
ansible -i inventory all -m shell -a "ls -la /home/app.txt"
history | cut -c 8-
```
