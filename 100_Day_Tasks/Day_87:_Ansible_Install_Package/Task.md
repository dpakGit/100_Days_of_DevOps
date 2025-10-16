### Task : Ansible Install Package

The Nautilus Application development team wanted to test some applications on app servers in Stratos Datacenter. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since we are already using Ansible for automating such tasks, please perform this task using Ansible as per details mentioned below:



Create an inventory file /home/thor/playbook/inventory on jump host and add all app servers in it.


Create an Ansible playbook /home/thor/playbook/playbook.yml to install zip package on all  app servers using Ansible yum module.


Make sure user thor should be able to run the playbook on jump host.

Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.


### What I Did

```
thor@jumphost ~/playbook$ # Verify wget installation
ansible -i inventory all -m shell -a "which zip"
stapp03 | CHANGED | rc=0 >>
/bin/wget
stapp01 | FAILED | rc=1 >>
which: no wget in (/sbin:/bin:/usr/sbin:/usr/bin)non-zero return code
stapp02 | CHANGED | rc=0 >>
/bin/wget
thor@jumphost ~/playbook$ ansible -i inventory all -m shell -a "which zip"
stapp01 | CHANGED | rc=0 >>
/bin/zip
stapp03 | CHANGED | rc=0 >>
/bin/zip
stapp02 | CHANGED | rc=0 >>
/bin/zip
thor@jumphost ~/playbook$ ansible -i inventory all -m shell -a "rpm -q zip"
stapp03 | CHANGED | rc=0 >>
zip-3.0-35.el9.x86_64
stapp02 | CHANGED | rc=0 >>
zip-3.0-35.el9.x86_64
stapp01 | CHANGED | rc=0 >>
zip-3.0-35.el9.x86_64
thor@jumphost ~/playbook$ cat playbook.yml 
---
- hosts: app_servers
  become: yes
  tasks:
  - name: Install zip package using yum
    yum:
      name: zip
      state: present
```
```
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
```

