https://github.com/iinsys/devops/tree/master/100-days-of-devops/kodecloud/Day87

"Replace wget with zip"

### Here's how you can accomplish this task using Ansible:

Step 1: Create the inventory file

Create a file named inventory in the /home/thor/playbook directory with the following content:

[app_servers]
app_server_1 ansible_host=<IP or hostname of app server 1>
app_server_2 ansible_host=<IP or hostname of app server 2>
# Add more app servers as needed

Replace <IP or hostname of app server 1> and <IP or hostname of app server 2> with the actual IP addresses or hostnames of your app servers.

Step 2: Create the Ansible playbook

Create a file named playbook.yml in the /home/thor/playbook directory with the following content:

---
- name: Install zip package on app servers
  hosts: app_servers
  become: yes

  tasks:
  - name: Install zip package
    yum:
      name: zip
      state: present

This playbook targets the app_servers group defined in the inventory file and uses the yum module to install the zip package.

Step 3: Configure Ansible to use the inventory file

Make sure the inventory file is in the correct location and has the correct format. You can test the inventory file by running the following command:

bash
ansible all --list-hosts -i inventory

This should list all the hosts in the app_servers group.

Step 4: Run the playbook

Run the playbook using the following command:

bash
ansible-playbook -i inventory playbook.yml

This should install the zip package on all app servers in the app_servers group.

User thor can run the playbook

To ensure that user thor can run the playbook without any issues, make sure:

- The inventory file and playbook.yml file are owned by user thor and have the correct permissions.
- User thor has the necessary SSH keys or credentials to connect to the app servers.
- Ansible is installed and configured correctly on the jump host.

With these steps, you should be able to run the playbook successfully using the ansible-playbook command.

### Yes, that inventory file will work.

You've defined:

- A group called app_servers with three hosts: stapp01, stapp02, and stapp03.
- Each host has its own ansible_host, ansible_user, and ansible_password variables.
- The ansible_become_password variable is also defined for each host to handle privilege escalation.
- You've also defined group variables for app_servers that apply to all hosts in the group:
    - ansible_become=yes enables privilege escalation for all hosts.
    - ansible_become_method=sudo specifies the method for privilege escalation.
    - ansible_python_interpreter=/usr/bin/python3 specifies the Python interpreter to use.
    - ansible_ssh_common_args='-o StrictHostKeyChecking=no' disables strict host key checking.

This inventory file provides all the necessary details for Ansible to connect to the hosts and run the playbook.

Just make sure to save this inventory file as /home/thor/playbook/inventory and your playbook as /home/thor/playbook/playbook.yml, and you should be able to run the playbook using the command ansible-playbook -i inventory playbook.yml.


### The playbook you've provided will work, but it doesn't exactly match the task requirements. The task asks to install the zip package, but your playbook installs wget.

To fix this, simply replace wget with zip in the playbook:

cat > playbook.yml << 'EOF'
---
- hosts: all
  become: yes
  tasks:
  - name: Install zip package using yum
    yum:
      name: zip
      state: present
EOF

With this change, the playbook should work as expected and install the zip package on all hosts in the inventory.

Also, since your inventory file has app_servers as the group name, you could change hosts: all to hosts: app_servers to target only the hosts in that group:

---
- hosts: app_servers
  become: yes
  tasks:
  - name: Install zip package using yum
    yum:
      name: zip
      state: present

### . Increase verbosity: Run the playbook with increased verbosity using -vvv to get more detailed output. This might help you identify the issue:

bash
ansible-playbook -i inventory playbook.yml -vvv


