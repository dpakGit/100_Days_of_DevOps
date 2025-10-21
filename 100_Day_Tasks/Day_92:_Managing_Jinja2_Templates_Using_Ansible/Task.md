### Task : Managing Jinja2 Templates Using Ansible

One of the Nautilus DevOps team members is working on to develop a role for httpd installation and configuration. Work is almost completed, however there is a requirement to add a jinja2 template for index.html file. Additionally, the relevant task needs to be added inside the role. The inventory file ~/ansible/inventory is already present on jump host that can be used. Complete the task as per details mentioned below:


a. Update ~/ansible/playbook.yml playbook to run the httpd role on App Server 2.


b. Create a jinja2 template index.html.j2 under /home/thor/ansible/role/httpd/templates/ directory and add a line This file was created using Ansible on <respective server> (for example This file was created using Ansible on stapp01 in case of App Server 1). Also please make sure not to hard code the server name inside the template. Instead, use inventory_hostname variable to fetch the correct value.


c. Add a task inside /home/thor/ansible/role/httpd/tasks/main.yml to copy this template on App Server 2 under /var/www/html/index.html. Also make sure that /var/www/html/index.html file's permissions are 0644.


d. The user/group owner of /var/www/html/index.html file must be respective sudo user of the server (for example tony in case of stapp01).


Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.


### What I Did

```
thor@jumphost ~/ansible$ ls
inventory  playbook.yml  role
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_ssh_pass=Ir0nM@n ansible_become_pass=Ir0nM@n
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_ssh_pass=Am3ric@ ansible_become_pass=Am3ric@
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_ssh_pass=BigGr33n ansible_become_pass=BigGr33nthor@jumphost ~/ansible$ cat playbook.yml 
---
- hosts: stapp02
  become: yes
  become_user: root
  roles:
    - role/httpd
thor@jumphost ~/ansible$ cat role/
cat: role/: Is a directory
thor@jumphost ~/ansible$ history |cut -c 8-
cd /home/thor/ansible/
pwd
ls
cat inventory 
cat playbook.yml 
ls -la
# Update playbook.yml to target App Server 2 (stapp01)
cat > playbook.yml << 'EOF'

: stapp02
e: yes
e_user: root
:
ole/httpd


# Create jinja2 template index.html.j2 with inventory_hostname variable
cat > role/httpd/templates/index.html.j2 << 'EOF'
le was created using Ansible on {{ inventory_hostname }}


# Update the main.yml tasks file to include the template task
cat > role/httpd/tasks/main.yml << 'EOF'

ll httpd package
 Install httpd package
ge:
e: httpd
te: present

 and enable httpd service
 Start and enable httpd service
ce:
e: httpd
te: started
bled: yes

y index.html using jinja2 template
 Deploy index.html from jinja2 template
ate:
: index.html.j2
t: /var/www/html/index.html
er: "{{ ansible_user }}"
up: "{{ ansible_user }}"
e: '0644'


ansible -i inventory stapp01 -m ping
ansible -i inventory stapp02 -m ping
ansible -i inventory stapp01 -m shell -a "systemctl status httpd --no-pager -l"
ansible -i inventory stapp02 -m shell -a "systemctl status httpd --no-pager -l"
ansible-playbook -i inventory playbook.yml
ansible -i inventory stapp02 -m shell -a "systemctl status httpd --no-pager -l"
ansible -i inventory stapp02 -m shell -a "cat /var/www/html/index.html"
ansible -i inventory stapp02 -m shell -a "ls -la /var/www/html/index.html"
ansible -i inventory stapp02 -m shell -a "curl -s localhost"
find role/ -type f -exec echo "=== {} ===" \; -exec cat {} \;
ls
cat inventory 
cat playbook.yml 
cat role/
history |cut -c 8-
thor@jumphost ~/ansible$ 
```

