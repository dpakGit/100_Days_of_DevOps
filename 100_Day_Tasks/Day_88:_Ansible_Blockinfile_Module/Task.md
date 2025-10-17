### Task : Ansible Blockinfile Module



### What I Did

```
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory  playbook.yml
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=bannerthor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ cat playbook.yml 
---
- hosts: all
  become: yes
  tasks:
  - name: Install httpd package
    yum:
      name: httpd
      state: present

  - name: Start and enable httpd service
    service:
      name: httpd
      state: started
      enabled: yes

  - name: Create index.html with blockinfile content
    blockinfile:
      path: /var/www/html/index.html
      create: yes
      owner: apache
      group: apache
      mode: '0744'
      block: |
        Welcome to XfusionCorp!
        This is Nautilus sample file, created using Ansible!
        Please do not modify this file manually!

thor@jumphost ~/ansible$ history | cut -c 8-
pwd
ls
cd a
cd ansible/
ls
cat inventory 
cat ansible.cfg 
# Create playbook.yml with httpd installation and blockinfile content
cat > playbook.yml << 'EOF'

: all
e: yes
:
ame: Install httpd package
um:
 name: httpd
 state: present

ame: Start and enable httpd service
ervice:
 name: httpd
 state: started
 enabled: yes

ame: Create index.html with blockinfile content
lockinfile:
 path: /var/www/html/index.html
 create: yes
 owner: apache
 group: apache
 mode: '0744'
 block: |
   Welcome to XfusionCorp!
   This is  Nautilus sample file, created using Ansible!
   Please do not modify this file manually!


ls
# Test connectivity to all app servers
ansible -i inventory all -m ping
# Run the playbook
ansible-playbook -i inventory playbook.yml
ls
vi playbook.yml 
ansible-playbook -i inventory playbook.yml
vi playbook.yml 
ansible-playbook -i inventory playbook.yml
ansible -i inventory all -m ping
ansible -i inventory all -m shell -a "systemctl status httpd"
# Verify index.html file content and permissions
ansible -i inventory all -m shell -a "ls -la /var/www/html/index.html"
ansible -i inventory all -m shell -a "cat /var/www/html/index.html"
ls
cat inventory 
cat playbook.yml 
history | cut -c 8-
```
