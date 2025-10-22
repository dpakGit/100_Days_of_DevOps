### Task : Using Ansible Conditionals

The Nautilus DevOps team had a discussion about, how they can train different team members to use Ansible for different automation tasks. There are numerous ways to perform a particular task using Ansible, but we want to utilize each aspect that Ansible offers. The team wants to utilise Ansible's conditionals to perform the following task:


An inventory file is already placed under /home/thor/ansible directory on jump host, with all the Stratos DC app servers included.


Create a playbook /home/thor/ansible/playbook.yml and make sure to use Ansible's when conditionals statements to perform the below given tasks.


Copy blog.txt file present under /usr/src/finance directory on jump host to App Server 1 under /opt/finance directory. Its user and group owner must be user tony and its permissions must be 0777 .


Copy story.txt file present under /usr/src/finance directory on jump host to App Server 2 under /opt/finance directory. Its user and group owner must be user steve and its permissions must be 0777 .


Copy media.txt file present under /usr/src/finance directory on jump host to App Server 3 under /opt/finance directory. Its user and group owner must be user banner and its permissions must be 0777.


NOTE: You can use ansible_nodename variable from gathered facts with when condition. Additionally, please make sure you are running the play for all hosts i.e use - hosts: all.


Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml, so please make sure the playbook works this way without passing any extra arguments.


### What I Did

```
thor@jumphost ~$ cd /home/thor/ansible
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory
thor@jumphost ~/ansible$ cat inventory 
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=bannerthor@jumphost ~/ansible$ vi playbook.yml
thor@jumphost ~/ansible$ ansible -i inventory all -m ping
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
stapp03 | SUCCESS => {
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
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]
ok: [stapp02]
ok: [stapp03]

TASK [Copy blog.txt to stapp01] ************************************************
skipping: [stapp01]
skipping: [stapp02]
skipping: [stapp03]

TASK [Copy story.txt to stapp02] ***********************************************
skipping: [stapp01]
skipping: [stapp02]
skipping: [stapp03]

TASK [Copy media.txt to stapp03] ***********************************************
skipping: [stapp01]
skipping: [stapp02]
skipping: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=1    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0   
stapp02                    : ok=1    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0   
stapp03                    : ok=1    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0   

thor@jumphost ~/ansible$ ansible -i inventory stapp01 -m shell -a "ls -la /opt/finance/blog.txt"
ansible -i inventory stapp02 -m shell -a "ls -la /opt/finance/story.txt"
ansible -i inventory stapp03 -m shell -a "ls -la /opt/finance/media.txt"
stapp01 | FAILED | rc=2 >>
ls: cannot access '/opt/finance/blog.txt': No such file or directorynon-zero return code
stapp02 | FAILED | rc=2 >>
ls: cannot access '/opt/finance/story.txt': No such file or directorynon-zero return code
stapp03 | FAILED | rc=2 >>
ls: cannot access '/opt/finance/media.txt': No such file or directorynon-zero return code
thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ vi playbook.yml 
thor@jumphost ~/ansible$ ansible-playbook -i inventory playbook.yml
PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [stapp01]
ok: [stapp03]
ok: [stapp02]

TASK [Copy blog.txt to stapp01] ************************************************
skipping: [stapp02]
skipping: [stapp03]
changed: [stapp01]

TASK [Copy story.txt to stapp02] ***********************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Copy media.txt to stapp03] ***********************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

thor@jumphost ~/ansible$ 
ansible -i inventory stapp01 -m shell -a "ls -la /opt/finance/blog.txt"
ansible -i inventory stapp02 -m shell -a "ls -la /opt/finance/story.txt"
ansible -i inventory stapp03 -m shell -a "ls -la /opt/finance/media.txt"
stapp01 | CHANGED | rc=0 >>
-rwxrwxrwx 1 tony tony 35 Oct 22 04:34 /opt/finance/blog.txt
stapp02 | CHANGED | rc=0 >>
-rwxrwxrwx 1 steve steve 27 Oct 22 04:34 /opt/finance/story.txt
stapp03 | CHANGED | rc=0 >>
-rwxrwxrwx 1 banner banner 22 Oct 22 04:35 /opt/finance/media.txt
thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ 
thor@jumphost ~/ansible$ # Verify file content
ansible -i inventory stapp01 -m shell -a "cat /opt/finance/blog.txt"
ansible -i inventory stapp02 -m shell -a "cat /opt/finance/story.txt"
ansible -i inventory stapp03 -m shell -a "cat /opt/finance/media.txt"
stapp01 | CHANGED | rc=0 >>
Welcome to xFusionCorp Industries !
stapp02 | CHANGED | rc=0 >>
Welcome to Nautilus Group !
stapp03 | CHANGED | rc=0 >>
Welcome to KodeKloud !
thor@jumphost ~/ansible$ ls
ansible.cfg  inventory  playbook.yml
thor@jumphost ~/ansible$ cat playbook.yml 
---
- hosts: all
  become: yes
  tasks:
    # Copy blog.txt to App Server 1
    - name: Copy blog.txt to stapp01
      copy:
        src: /usr/src/finance/blog.txt
        dest: /opt/finance/blog.txt
        owner: tony
        group: tony
        mode: '0777'
      when: inventory_hostname == 'stapp01'

    # Copy story.txt to App Server 2
    - name: Copy story.txt to stapp02
      copy:
        src: /usr/src/finance/story.txt
        dest: /opt/finance/story.txt
        owner: steve
        group: steve
        mode: '0777'
      when: inventory_hostname == 'stapp02'

    # Copy media.txt to App Server 3
    - name: Copy media.txt to stapp03
      copy:
        src: /usr/src/finance/media.txt
        dest: /opt/finance/media.txt
        owner: banner
        group: banner
        mode: '0777'
      when: inventory_hostname == 'stapp03'

thor@jumphost ~/ansible$ 
```
