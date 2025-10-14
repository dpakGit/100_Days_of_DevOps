### Task : Troubleshoot and Create Ansible Playbook

An Ansible playbook needs completion on the jump host, where a team member left off. Below are the details:



The inventory file /home/thor/ansible/inventory requires adjustments. The playbook must run on App Server 1 in Stratos DC. Update the inventory accordingly.


Create a playbook /home/thor/ansible/playbook.yml. Include a task to create an empty file /tmp/file.txt on App Server 1.


Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook works without any additional arguments.


### What I Did

```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ cd ansible/
thor@jumphost ~/ansible$ ls
inventory
thor@jumphost ~/ansible$ pwd
/home/thor/ansible
thor@jumphost ~/ansible$ cat inventory 
stapp02 ansible_host=172.238.16.204 ansible_user=steve ansible_ssh_common_args='-o StrictHostKeyChecking=no'thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ # Update the inventory file with correct configuration
cat > inventory << 'EOF'
[app_servers]
stapp02 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
thor@jumphost ~/ansible$ cat > inventory << 'EOF'
[app_servers]
stapp02 ansible_host=172.16.238.10 ansible_user=steve ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
thor@jumphost ~/ansible$ cat inventory 
[app_servers]
stapp02 ansible_host=172.16.238.10 ansible_user=steve ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n

[app_servers:vars]
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

thor@jumphost ~/ansible$ # Create playbook.yml to create empty file on App Server 1
cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
    - name: Create empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
        mode: '0644'
EOF
thor@jumphost ~/ansible$ ls
inventory  playbook.yml
thor@jumphost ~/ansible$ cat playbook.yml 
---
- hosts: all
  become: yes
  tasks:
    - name: Create empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
        mode: '0644'

thor@jumphost ~/ansible$ ansible -i inventory stapp01 -m ping
stapp02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp01]

TASK [Create empty file /tmp/file.txt] *****************************************************************************************
changed: [stapp01]

PLAY RECAP *********************************************************************************************************************
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

thor@jumphost ~/ansible$ # Verify file creation
ansible -i inventory stapp02 -m shell -a "ls -la /tmp/file.txt"
stapp02 | CHANGED | rc=0 >>
-rw-r--r-- 1 root root 0 Oct 14 10:01 /tmp/file.txt

thor@jumphost ~/ansible$ history | cut -c 8-
pwd
ls
cd ansible/
ls
pwd
cat inventory 
# Update the inventory file with correct configuration
cat > inventory << 'EOF'
rvers]
 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n

rvers:vars]
_become=yes
_become_method=sudo
_python_interpreter=/usr/bin/python3
_ssh_common_args='-o StrictHostKeyChecking=no'


cat > inventory << 'EOF'
rvers]
 ansible_host=172.16.238.10 ansible_user=steve ansible_password=Ir0nM@n ansible_become_password=Ir0nM@n

rvers:vars]
_become=yes
_become_method=sudo
_python_interpreter=/usr/bin/python3
_ssh_common_args='-o StrictHostKeyChecking=no'


cat inventory 
# Create playbook.yml to create empty file on App Server 2
cat > playbook.yml << 'EOF'

: all
e: yes
:
ame: Create empty file /tmp/file.txt
ile:
 path: /tmp/file.txt
 state: touch
 mode: '0644'


ls
cat playbook.yml 
ansible -i inventory stapp02 -m ping
ansible-playbook -i inventory playbook.yml
# Verify file creation
ansible -i inventory stapp02 -m shell -a "ls -la /tmp/file.txt"
history | cut -c 8-
thor@jumphost ~/ansible$ ^C
thor@jumphost ~/ansible$ 
```
