### Task : Ansible Ping Module Usage

The Nautilus DevOps team is planning to test several Ansible playbooks on different app servers in Stratos DC. Before that, some pre-requisites must be met. Essentially, the team needs to set up a password-less SSH connection between Ansible controller and Ansible managed nodes. One of the tickets is assigned to you; please complete the task as per details mentioned below:


a. Jump host is our Ansible controller, and we are going to run Ansible playbooks through thor user from jump host.


b. There is an inventory file /home/thor/ansible/inventory on jump host. Using that inventory file test Ansible ping from jump host to App Server 3, make sure ping works.


### What I Did
```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ cd ansible/
thor@jumphost ~/ansible$ ls
inventory
thor@jumphost ~/ansible$ cd inventory 
bash: cd: inventory: Not a directory
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33nthor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ # Update the inventory file with complete configuration
cat > inventory << 'EOF'
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter=/usr/bin/python3
EOF
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter=/usr/bin/python3
thor@jumphost ~/ansible$ # Test ping to App Server 3 (stapp03)
ansible -i inventory stapp03 -m ping
stapp03 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/ansible$ # Verify all hosts (optional)
ansible -i inventory all -m ping
stapp03 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

```
thor@jumphost ~/ansible$ history | cut -c 8- 
pwd
ls
cd ansible/
ls
cd inventory 
cat inventory 
# Update the inventory file with complete configuration
cat > inventory << 'EOF'
 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n
 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@
 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n

rs]
_ssh_common_args='-o StrictHostKeyChecking=no'
_python_interpreter=/usr/bin/python3


cat inventory 
# Test ping to App Server 3 (stapp03)
ansible -i inventory stapp03 -m ping
# Verify all hosts (optional)
ansible -i inventory all -m ping
history | cut -c 8- 
```
