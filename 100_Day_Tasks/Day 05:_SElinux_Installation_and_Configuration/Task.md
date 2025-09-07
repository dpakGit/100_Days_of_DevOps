### Day 5: SElinux Installation and Configuration

#### Following a security audit, the xFusionCorp Industries security team has opted to enhance application and server security with SELinux. To initiate testing, the following requirements have been established for App server 3 in the Stratos Datacenter:

- Install the required SELinux packages.

- Permanently disable SELinux for the time being; it will be re-enabled after necessary configuration changes.

- No need to reboot the server, as a scheduled maintenance reboot is already planned for tonight.

- Disregard the current status of SELinux via the command line; the final status after the reboot should be disabled.

Solution:

NOTE: SELinux, which stands for Security-Enhanced Linux, is a security system built into the Linux kernel that implements mandatory access controls (MAC). It enhances system security by restricting how programs and users can access files, data, and other resources, thereby limiting the potential damage from security breaches. Think of it as a more granular and stricter access control system than the traditional discretionary access controls (DAC) in Linux. 

#### Break down the task into simpler terms:

Task: Enhance security on App server 3 with SELinux

Step 1: Install SELinux packages

- Make sure the server has the necessary SELinux software installed.

Step 2: Disable SELinux (temporarily)

- Configure SELinux to be disabled after the next reboot.
- Don't worry about the current status of SELinux; just make sure it's disabled after the reboot.

Important details:

- No need to reboot the server now; a maintenance reboot is scheduled for tonight.
- SELinux will be re-enabled later after necessary configuration changes are made.

In simple terms, the task is to:

1. Install SELinux software on the server.
2. Set SELinux to be disabled after the next reboot (which is scheduled for tonight).
3. Don't worry about the current status of SELinux; just make sure it's disabled after the reboot.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

**What I Did :**

```
Task - 5

1. root@jumphost /home/thor# ssh banner@172.16.238.12  

[banner@stapp03 ~]$ history | cut -c 8-
 cat /etc/os-release # to see the Linux distribution

sudo yum install -y selinux-policy selinux-policy-targeted libselinux-utils

sestatus # T Verify the installation
Output: # The output of the above command sestatus shows its already disabled
[banner@stapp03 ~]$ sestatus
SELinux status:                 disabled


sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# Verify the changes
grep SELINUX /etc/selinux/config
Output of the commmad:
[banner@stapp03 ~]$ grep SELINUX /etc/selinux/config
# SELINUX= can take one of these three values:
# NOTE: Up to RHEL 8 release included, SELINUX=disabled would also
SELINUX=disabled
# SELINUXTYPE= can take one of these three values:
SELINUXTYPE=targeted
```

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#### To check the Linux distribution and version, you can use several commands. Here are a few:

1. *Using `lsb_release`*:
```
bash
lsb_release -a
```
This command provides detailed information about the Linux distribution, including the distributor ID, description, release, and codename. However, `lsb_release` might not be available on all distributions by default.

2. *Checking `/etc/os-release`*:
```
bash
cat /etc/os-release
```
This file contains information about the Linux distribution, including `NAME`, `VERSION`, `ID`, `VERSION_ID`, `PRETTY_NAME`, and more. This method is widely supported across many Linux distributions.

3. *Using `uname`*:
```
bash
uname -o
```
This command provides a more general output, typically indicating "GNU/Linux". For more specific details about the kernel version, you can use `uname -r` or `uname -v`.

4. *Checking `/etc/*release`*:
```
bash
cat /etc/*release
```
This command can provide detailed information about the distribution. Files like `/etc/redhat-release`, `/etc/debian_version`, etc., are distribution-specific and can give you insights into the system you're working on.

These commands should help you determine the Linux distribution and version of your system.


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

**Meta AI Solutions:**
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

### To fulfill the requirements on App server 3 in the Stratos Datacenter, follow these steps:

*Step 1: Install SELinux Packages*
First, ensure that the necessary SELinux packages are installed. You can install them using the package manager. For RHEL/CentOS systems, you can use `yum` or `dnf`:

```
bash
sudo yum install -y selinux-policy selinux-policy-targeted libselinux-utils
```

or if you're using a system with `dnf` (like Fedora):

```
bash
sudo dnf install -y selinux-policy selinux-policy-targeted libselinux-utils
```

*Step 2: Permanently Disable SELinux*
To permanently disable SELinux, you'll need to modify the `/etc/selinux/config` file. Change the `SELINUX` directive to `disabled`:

```
bash
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
```

Verify the change:

```
bash
grep SELINUX /etc/selinux/config
```

You should see `SELINUX=disabled`.

*Step 3: Current SELinux Status (Optional Immediate Change)*
If you want to immediately change the SELinux status to permissive or disabled without rebooting (though it's mentioned that a reboot is planned), you can use:

```
bash
sudo setenforce 0
```

This sets SELinux to permissive mode temporarily until the next reboot. However, since the requirement is to have it disabled after the reboot and a reboot is scheduled, this step is more about awareness. The permanent change is made in the `/etc/selinux/config` file.

*Final Check Before Reboot*
Before the scheduled reboot tonight, ensure that the `/etc/selinux/config` file reflects `SELINUX=disabled`. After the reboot, SELinux should be disabled as per the configuration.

After the reboot, you can verify SELinux status with:

```
bash
sestatus
```
or
```
bash
getenforce
```
Both commands should indicate that SELinux is disabled.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

To check if SELinux is installed and its current status on your system, you can use the following commands:

1. *Check SELinux status*:
```
bash
sestatus
```
This command provides detailed information about SELinux, including whether it's enabled or disabled, the policy type, and more. If SELinux is not installed, you might see an error message or it might not be recognized.

2. *Check if SELinux utilities are installed*:
You can also check if the SELinux utilities are installed by trying to run SELinux-specific commands. If the command-line tools are not installed, you might see a "command not found" error.

3. *Check for SELinux packages*:
Depending on your package manager, you can check if SELinux-related packages are installed:
    - On RPM-based systems (like RHEL, CentOS):
```
bash
rpm -qa | grep selinux
```
    - On Debian-based systems (like Ubuntu):
```
bash
dpkg -l | grep selinux
```

If SELinux is installed but disabled, `sestatus` will still provide information about its configuration and status. If it's not installed, you'll likely see an error when trying to run SELinux commands.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

The output you've shared seems to be a part of the `/etc/selinux/config` file, which is used to configure SELinux. Let's break down what it shows:

1. *SELINUX=disabled*: This line indicates that SELinux is currently configured to be disabled. This setting will take effect after a system reboot if it hasn't already.

2. *# SELINUX= can take one of these three values:* This is a comment explaining that the `SELINUX=` directive can be set to one of three values, though it doesn't specify what those values are in this snippet. Typically, the three values are:
    - `enforcing`: SELinux is enabled and enforcing its policies.
    - `permissive`: SELinux is enabled but not enforcing its policies; it logs violations instead.
    - `disabled`: SELinux is completely disabled.

3. *# NOTE: Up to RHEL 8 release included, SELINUX=disabled would also ...*: This comment seems to be incomplete in your output, but it likely discusses how SELinux behaves or changes in behavior in different RHEL versions.

4. *SELINUXTYPE=targeted*: This line specifies the type of SELinux policy to use. The `targeted` policy is the most common and means that SELinux will focus on protecting specific services (targets) while allowing others to run in a less restricted manner.

Given the context, the output seems correct in terms of format and content for an `/etc/selinux/config` file where SELinux is set to be disabled and the policy type is set to `targeted`. The comments provide additional context and instructions for configuring SELinux.

If you're looking to ensure SELinux is properly configured according to your requirements, verify that the settings match your needs and adjust the file accordingly. After making changes, a system reboot is typically required for them to take effect.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
