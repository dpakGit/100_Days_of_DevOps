## Day 8: Install Ansible
--------------------------------------------------
### Task :
**During the weekly meeting, the Nautilus DevOps team discussed about the automation and configuration management solutions that they want to implement. While considering several options, the team has decided to go with Ansible for now due to its simple setup and minimal pre-requisites. The team wanted to start testing using Ansible, so they have decided to use jump host as an Ansible controller to test different kind of tasks on rest of the servers.**

**Install ansible version 4.7.0 on Jump host using pip3 only. Make sure Ansible binary is available globally on this system, i.e all users on this system are able to run Ansible commands.**

---------------------------------------------------------

Let's break down the process of installing Ansible version 4.7.0 on the Jump host using pip3 and making the Ansible binary available globally.

What is Ansible?

Ansible is an open-source automation tool that helps you manage and configure infrastructure, applications, and services. It's a powerful tool for DevOps and automation teams.

- Installing Ansible using pip3:

To install Ansible version 4.7.0 on the Jump host, you'll use pip3, which is a package installer for Python. Here's the command:

```
sudo pip3 install ansible==4.7.0
```

This command installs Ansible version 4.7.0 using pip3. The sudo prefix ensures that the installation is done with administrative privileges, which is required for global installation.

- Verifying Ansible installation:

After installing Ansible, you can verify that it's working correctly by running:

```
ansible --version
```
This command displays the Ansible version, which should be 4.7.0. This confirms that Ansible is installed and working correctly.

- Verifying global availability:

To ensure that Ansible is available globally and can be run by all users, you'll use the following command:

```
sudo su -c "ansible --version"
```

This command switches to the root user and runs the ansible --version command. If Ansible is installed correctly and is globally available, this command should display the Ansible version.

- Testing Ansible with different users:

If you want to test Ansible with a different user, you can switch to that user and run Ansible commands. For example:

```
sudo su - <username>
ansible --version
```

Replace <username> with the actual username. This ensures that Ansible is working correctly for different users.

Why global availability matters:

By installing Ansible using sudo pip3, the Ansible binary is installed in a location that's accessible by all users on the system. This makes Ansible available globally, which is important for several reasons:

- Multiple users can use Ansible without having to install it separately.
- Ansible can be used in automated scripts and workflows that run under different user accounts.
- Global availability ensures that Ansible is consistently available across the system, making it easier to manage and automate infrastructure and applications.

In summary, installing Ansible using sudo pip3 and verifying its global availability ensures that Ansible is working correctly and can be used by all users on the system.

----------------------------------------------------------

### Real World  use case

Let's consider a real-world use case for installing Ansible on a Jump host and making it available globally.

Use Case:

A company called "Example Inc." has a team of system administrators and DevOps engineers who manage a large infrastructure of servers and applications. They want to automate various tasks, such as:

- Configuring servers with specific software packages and settings
- Deploying applications to multiple servers
- Managing user accounts and access controls
- Monitoring server health and performance

To achieve this, they decide to use Ansible as their automation tool. They choose a Jump host as the central server for running Ansible playbooks and making changes to their infrastructure.

Requirements:

- Ansible needs to be installed on the Jump host and made available globally so that all users can use it.
- The Ansible version needs to be consistent across the team, so they decide to install version 4.7.0.
- The team wants to ensure that Ansible is working correctly and can be used by all users without any issues.

Solution:

The team installs Ansible version 4.7.0 on the Jump host using pip3 and makes it available globally by following the steps I outlined earlier:

1. Install Ansible using pip3: sudo pip3 install ansible==4.7.0
2. Verify Ansible installation: ansible --version
3. Verify global availability: sudo su -c "ansible --version"

Benefits:

By installing Ansible on the Jump host and making it available globally, the team achieves several benefits:

- Consistency: All users can use the same version of Ansible, ensuring consistency across the team.
- Ease of use: Ansible is available globally, making it easy for users to run playbooks and automate tasks without worrying about installation or configuration issues.
- Collaboration: Multiple users can collaborate on Ansible playbooks and share knowledge and expertise.
- Automation: Ansible automates repetitive tasks, freeing up the team to focus on more strategic initiatives.

Example Playbook:

The team creates an Ansible playbook to configure a new server with the required software packages and settings. The playbook includes tasks such as:

- Installing the necessary packages (e.g., Apache, MySQL)
- Configuring firewall rules
- Setting up user accounts and access controls
- Deploying the application code

The team can run this playbook on multiple servers using Ansible, ensuring consistency and efficiency across the infrastructure.

By using Ansible on the Jump host and making it available globally, the team can automate complex tasks, improve collaboration, and increase productivity.

--------------------------------------------

**Configuration file not created:**

bash
ansible --version
...
config file = None
...

It appears that Ansible is not finding a configuration file.

By default, Ansible looks for a configuration file in the following locations:

1. ANSIBLE_CONFIG environment variable (if set)
2. ./ansible.cfg (in the current working directory)
3. ~/.ansible.cfg (in the user's home directory)
4. /etc/ansible/ansible.cfg (on Linux systems)

If none of these locations contain an ansible.cfg file, Ansible will use its default settings.

If you want to create a custom configuration file, you can create one at any of these locations and Ansible will pick it up.

For example, you can create a configuration file at /etc/ansible/ansible.cfg with the following command:

bash
sudo mkdir /etc/ansible
sudo touch /etc/ansible/ansible.cfg

Then, you can edit the /etc/ansible/ansible.cfg file to customize your Ansible settings.

After creating the configuration file, you can verify that Ansible is using it by running:

bash
ansible --version

This should display the path to the configuration file.
-----------------------------------------

**Note:**

After installing Ansible, you can check where the configuration file is located by running the following command:

bash
ansible --version

This command will display information about your Ansible installation, including the location of the configuration file.

Look for the line that says config file = in the output. This will indicate the path to the Ansible configuration file.

For example:

bash
$ ansible --version
ansible 2.11.12
  config file = /etc/ansible/ansible.cfg
  ...

In this example, the Ansible configuration file is located at /etc/ansible/ansible.cfg.

If the config file line is not present or says None, it means that Ansible is using its default configuration settings, and you may need to create a configuration file manually.

Some common locations for the Ansible configuration file are:

- /etc/ansible/ansible.cfg
- ~/.ansible.cfg (in the user's home directory)
- ./ansible.cfg (in the current working directory)

You can create a configuration file in one of these locations if you need to customize Ansible's behavior.
