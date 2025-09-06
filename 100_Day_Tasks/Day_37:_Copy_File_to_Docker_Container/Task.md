### Task:
The Nautilus DevOps team possesses confidential data on App Server 1 in the Stratos Datacenter. A container named ubuntu_latest is running on the same server.

Copy an encrypted file /tmp/nautilus.txt.gpg from the docker host to the ubuntu_latest container located at /tmp/. Ensure the file is not modified during this operation.

---------------------------------------
### Task Breakdown
To copy the encrypted file /tmp/nautilus.txt.gpg from the Docker host to the ubuntu_latest container at /tmp/ without modifying it, use the docker cp command.

- Scroll down to see more

-----------------------------------------------


### What I Did
```
thor@jumphost ~$ ssh tony@stappo1

[tony@stapp01 ~]$ sudo -s

root@stapp01 tony]# docker ps -a

CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
7c0940bcaf97   ubuntu    "/bin/bash"   2 minutes ago   Up 2 minutes             ubuntu_latest

[root@stapp01 tony]# ls /tmp/

nautilus.txt.gpg
systemd-private-9e0b3f4f9f944fabb6055bb68fd4247f-dbus-broker.service-IK5g9s
systemd-private-9e0b3f4f9f944fabb6055bb68fd4247f-systemd-logind.service-OMoZp8


[root@stapp01 tony]# docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/tmp/

Successfully copied 2.05kB to ubuntu_latest:/tmp/

[root@stapp01 tony]# docker exec -it ubuntu_latest bash

root@7c0940bcaf97:/# ls /tmp/
nautilus.txt.gpg

root@7c0940bcaf97:/# exit

exit

# Alternative - Use docker exec with a command to check directly:                                       

[root@stapp01 tony]# docker exec ubuntu_latest ls /tmp/nautilus.txt.gpg
/tmp/nautilus.txt.gpg # This is the output of the above command

[root@stapp01 tony]#   docker exec ubuntu_latest basename /tmp/nautilus.txt.gpg
nautilus.txt.gpg # Output of the above command

# Behavior - *basename*: Strips directory path, leaving just the filename (nautilus.txt.gpg).

[root@stapp01 tony]# docker exec ubuntu_latest ls /tmp/
nautilus.txt.gpg

# Above is the correect command

```

-------------------------------------
Copying Encrypted File to Container
To copy the encrypted file /tmp/nautilus.txt.gpg from the Docker host to the ubuntu_latest container at /tmp/ without modifying it, use the docker cp command.

Steps
1. Identify container ID or name: Ensure you know the container name (ubuntu_latest).
2. Run the copy command:

bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/tmp/


Outcome
- The file nautilus.txt.gpg is copied to /tmp/ in the ubuntu_latest container.
- The file is not modified during the copy operation.

In the command:

bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/tmp/

- *ubuntu_latest* is the name or ID of the container.
- It specifies the container where the file is being copied to.


*Use of : in docker cp*
In the command:

bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/tmp/

- The *:* separates the container name from the path inside the container.
- Syntax: container_name:path_inside_container

Meaning
- ubuntu_latest:/tmp/ means: copy to path /tmp/ inside the container named ubuntu_latest.


### Steps to Check File Copy Success
To verify that the file /tmp/nautilus.txt.gpg was successfully copied to the ubuntu_latest container:

Steps
1. Exec into the container:

bash
docker exec -it ubuntu_latest bash

2. Check for the file:

bash
ls /tmp/

- Look for nautilus.txt.gpg in the output.

Alternative
- Use docker exec with a command to check directly:

bash
docker exec ubuntu_latest ls /tmp/nautilus.txt.gpg

- If the file exists, you'll see the path output.

Do you need help with:
- *Using docker exec or interacting with containers*?
- Checking file existence or permissions in containers?
- Something else related to Docker or containers?

---------------------------------------
