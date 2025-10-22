The solution you provided seems mostly correct according to the task. However, the task mentions using ansible_nodename variable from gathered facts with when condition, but in your solution, you are using inventory_hostname.

If the hostname of the servers matches with the inventory hostname (stapp01, stapp02, stapp03), then your solution will work fine. But if the ansible_nodename is different from the inventory hostname, you might need to use ansible_nodename instead.

Here's how you can modify your playbook to use ansible_nodename:


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
      when: ansible_nodename == 'stapp01'

    # Copy story.txt to App Server 2
    - name: Copy story.txt to stapp02
      copy:
        src: /usr/src/finance/story.txt
        dest: /opt/finance/story.txt
        owner: steve
        group: steve
        mode: '0777'
      when: ansible_nodename == 'stapp02'

    # Copy media.txt to App Server 3
    - name: Copy media.txt to stapp03
      copy:
        src: /usr/src/finance/media.txt
        dest: /opt/finance/media.txt
        owner: banner
        group: banner
        mode: '0777'
      when: ansible_nodename == 'stapp03'


Also, make sure that the /opt/finance directory exists on the target servers. If not, you can add a task to create the directory before copying the files:


- name: Create /opt/finance directory
  file:
    path: /opt/finance
    state: directory


You can add this task before the copy tasks.

One more thing, the become: yes is used to gain root privileges, so the owner and group in the copy module should be the actual user and group names, not necessarily the same as the file owner on the source server.

If everything is set up correctly, your playbook should work fine with the command ansible-playbook -i inventory playbook.yml.
