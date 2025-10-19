### Task : Managing ACLs Using Ansible

There are some files that need to be created on all app servers in Stratos DC. The Nautilus DevOps team want these files to be owned by user root only however, they also want that the app specific user to have a set of permissions on these files. All tasks must be done using Ansible only, so they need to create a playbook. Below you can find more information about the task.



Create a playbook named playbook.yml under /home/thor/ansible directory on jump host, an inventory file is already present under /home/thor/ansible directory on Jump Server itself.


Create an empty file blog.txt under /opt/devops/ directory on app server 1. Set some acl properties for this file. Using acl provide read '(r)' permissions to group tony (i.e entity is tony and etype is group).


Create an empty file story.txt under /opt/devops/ directory on app server 2. Set some acl properties for this file. Using acl provide read + write '(rw)' permissions to user steve (i.e entity is steve and etype is user).


Create an empty file media.txt under /opt/devops/ on app server 3. Set some acl properties for this file. Using acl provide read + write '(rw)' permissions to group banner (i.e entity is banner and etype is group).


Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way, without passing any extra arguments.

### What I Did

```
thor@jumphost ~$ pwd
/home/thor
thor@jumphost ~$ ls
ansible
thor@jumphost ~$ cd ansible/
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=bannerthor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ vi playbook.yml
thor@jumphost ~/ansible$ # Test connectivity to all app servers
ansible -i inventory all -m ping
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
thor@jumphost ~/ansible$ # Run the playbook
ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Create /opt/devops directory on all servers] *****************************************************************************
ok: [stapp02]
ok: [stapp01]
ok: [stapp03]

TASK [Create empty file blog.txt] **********************************************************************************************
skipping: [stapp02]
skipping: [stapp03]
changed: [stapp01]

TASK [Set ACL for tony group with read permissions] ****************************************************************************
skipping: [stapp02]
skipping: [stapp03]
changed: [stapp01]

TASK [Create empty file story.txt] *********************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Set ACL for steve user with read+write permissions] **********************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Create empty file media.txt] *********************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

TASK [Set ACL for banner group with read+write permissions] ********************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=4    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   
stapp02                    : ok=4    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   
stapp03                    : ok=4    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0   

thor@jumphost ~/ansible$ # Verify ACL settings on each server
ansible -i inventory stapp01 -m shell -a "getfacl /opt/devops/blog.txt"
ansible -i inventory stapp02 -m shell -a "getfacl /opt/devops/story.txt"
ansible -i inventory stapp03 -m shell -a "getfacl /opt/devops/media.txt"
stapp01 | CHANGED | rc=0 >>
# file: opt/devops/blog.txt
# owner: root
# group: root
user::rw-
group::r--
group:tony:r--
mask::r--
other::r--getfacl: Removing leading '/' from absolute path names
stapp02 | CHANGED | rc=0 >>
# file: opt/devops/story.txt
# owner: root
# group: root
user::rw-
user:steve:rw-
group::r--
mask::rw-
other::r--getfacl: Removing leading '/' from absolute path names
stapp03 | CHANGED | rc=0 >>
# file: opt/devops/media.txt
# owner: root
# group: root
user::rw-
group::r--
group:banner:rw-
mask::rw-
other::r--getfacl: Removing leading '/' from absolute path names
thor@jumphost ~/ansible$ # Verify file ownership
ansible -i inventory all -m shell -a "ls -la /opt/devops/"
stapp02 | CHANGED | rc=0 >>
total 8
drwxr-xr-x  2 root root 4096 Oct 19 03:46 .
drwxr-xr-x  1 root root 4096 Oct 19 03:28 ..
-rw-rw-r--+ 1 root root    0 Oct 19 03:46 story.txt
stapp03 | CHANGED | rc=0 >>
total 8
drwxr-xr-x  2 root root 4096 Oct 19 03:46 .
drwxr-xr-x  1 root root 4096 Oct 19 03:28 ..
-rw-rw-r--+ 1 root root    0 Oct 19 03:46 media.txt
stapp01 | CHANGED | rc=0 >>
total 8
drwxr-xr-x  2 root root 4096 Oct 19 03:46 .
drwxr-xr-x  1 root root 4096 Oct 19 03:28 ..
-rw-r--r--+ 1 root root    0 Oct 19 03:46 blog.txt
thor@jumphost ~/ansible$ cat playbook.yml 
---
- hosts: all
  become: yes
  tasks:
  - name: Create /opt/devops directory on all servers
    file:
      path: /opt/devops
      state: directory
      mode: '0755'

  - name: Create blog.txt on App Server 1 with ACL for tony group (read)
    block:
      - name: Create empty file blog.txt
        file:
          path: /opt/devops/blog.txt
          state: touch
          owner: root
          group: root
          mode: '0644'
      - name: Set ACL for tony group with read permissions
        acl:
          path: /opt/devops/blog.txt
          entity: tony
          etype: group
          permissions: r
          state: present
    when: inventory_hostname == 'stapp01'

  - name: Create story.txt on App Server 2 with ACL for steve user (read+write)
    block:
      - name: Create empty file story.txt
        file:
          path: /opt/devops/story.txt
          state: touch
          owner: root
          group: root
          mode: '0644'
      - name: Set ACL for steve user with read+write permissions
        acl:
          path: /opt/devops/story.txt
          entity: steve
          etype: user
          permissions: rw
          state: present
    when: inventory_hostname == 'stapp02'

  - name: Create media.txt on App Server 3 with ACL for banner group (read+write)
    block:
      - name: Create empty file media.txt
        file:
          path: /opt/devops/media.txt
          state: touch
          owner: root
          group: root
          mode: '0644'
      - name: Set ACL for banner group with read+write permissions
        acl:
          path: /opt/devops/media.txt
          entity: banner
          etype: group
          permissions: rw
          state: present
    when: inventory_hostname == 'stapp03'

thor@jumphost ~/ansible$ 
```
