https://github.com/iinsys/devops/tree/master/100-days-of-devops/kodecloud/Day88


The issue is that your inventory file doesn't have a group defined. In Ansible, if you don't specify a group, it defaults to all. However, in your playbook, you're specifying hosts: app_servers, which doesn't exist in your inventory file.

To fix this, you can update your playbook to target the all group instead of app_servers:


---
- hosts: all
  become: yes
  tasks:
  # ... rest of the playbook remains the same ...


This will apply the playbook to all hosts in your inventory file.

Alternatively, you can define a group in your inventory file like this:


[app_servers]
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=tony


Then, your original playbook with hosts: app_servers should work fine.

Also, it seems like ansible_user is missing for stapp03, make sure to add the correct username.



The playbook you've created is close, but there are a few issues that need to be addressed:

1. The hosts parameter is set to all, but the task mentions that the httpd web server should be installed on all app servers. You should update the hosts parameter to target only the app servers. Let's assume the inventory group for app servers is app_servers. You can update the hosts parameter to app_servers.

2. The file permissions for /var/www/html/index.html are set to 0755, but the task requires them to be 0744. You should update the mode parameter in the blockinfile task to 0744.

Here's the corrected playbook:


---
- hosts: app_servers
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


With these changes, the playbook should work as expected. Make sure to test it using the ansible-playbook command with the -i option to specify the inventory file:


bash
ansible-playbook -i inventory playbook.yml
