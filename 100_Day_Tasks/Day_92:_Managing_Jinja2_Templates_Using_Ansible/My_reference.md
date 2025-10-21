https://github.com/iinsys/devops/tree/master/100-days-of-devops/kodecloud/Day92


### Here's the updated playbook and role configuration based on the task requirements:

Update playbook.yml to target App Server 2


---
- hosts: stapp02
  become: yes
  become_user: root
  roles:
    - role: httpd


Create jinja2 template index.html.j2


bash
mkdir -p role/httpd/templates/
cat > role/httpd/templates/index.html.j2 << 'EOF'
This file was created using Ansible on {{ inventory_hostname }}
EOF


Update main.yml tasks file


---
# Install httpd package
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

# Deploy index.html using jinja2 template
- name: Deploy index.html from jinja2 template
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: "{{ ansible_user }}"
    group: "{{ ansible_user }}"
    mode: '0644'


Make sure the inventory file ~/ansible/inventory has the correct hostname and IP address for stapp02.

Run the playbook


bash
ansible-playbook -i inventory playbook.yml


This should configure the httpd role on App Server 2 and create an index.html file with the specified content. The file's permissions will be set to 0644, and the owner/group will be set to the respective sudo user of the server.
