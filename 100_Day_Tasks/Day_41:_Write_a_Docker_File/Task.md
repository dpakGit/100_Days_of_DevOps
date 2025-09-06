### Task:
As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file /opt/docker/Dockerfile (please keep D capital of Dockerfile) on App server 2 in Stratos DC and configure to build an image with the following requirements:

a. Use ubuntu:24.04 as the base image.

b. Install apache2 and configure it to work on 3004 port. (do not update any other Apache configuration settings like document root etc).

-------------------------------------------


### What I Did

```
thor@jumphost ~$ ssh steve@stapp02

[steve@stapp02 ~]$ sudo -s

[root@stapp02 steve]# cd /opt/docker/

[root@stapp02 docker]# ls

[root@stapp02 docker]# vi Dockerfile

-------------------------------------------------------------------------------------------
Here's a Dockerfile that meets the requirements:

bash
# Use ubuntu:24.04 as the base image

  FROM ubuntu:24.04

# Install apache2

  RUN apt update && apt install -y apache2

# Configure Apache to listen on port 3004

  RUN sed -i 's/Listen 80/Listen 3004/g' /etc/apache2/ports.conf

# Expose port 3004
  
  EXPOSE 3004

# Start Apache when the container starts

  CMD ["apache2ctl", "-D", "FOREGROUND"]


Let me explain what each line does:

1. FROM ubuntu:24.04: Uses the ubuntu:24.04 image as the base.

2. RUN apt update && apt install -y apache2: Installs Apache2 using apt.

3. RUN sed -i 's/Listen 80/Listen 3004/g' /etc/apache2/ports.conf: Replaces the Listen 80 directive with Listen 3004 in the ports.conf file.

4. EXPOSE 3004: Exposes port 3004 to the host machine.

5. CMD ["apache2ctl", "-D", "FOREGROUND"]: Starts Apache in the foreground when the container starts.

-----------------------------------------------------------------------------------------------

# To build the Docker image, navigate to the directory where the Dockerfile is located (/opt/docker) and run:

[root@stapp02 docker]# docker build -t custom-apache-image .

# This will create a Docker image with the name custom-apache-image. You can then run a container from this image :

[root@stapp02 docker]# docker images                                     
REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
custom-apache-image   latest    1f6e1fadaeba   59 seconds ago   246MB
ubuntu                24.04     602eb6fb314b   4 months ago     78.1MB


# The following  will start a container and map port 3004 on the host machine to port 3004 in the container.

[root@stapp02 docker]# docker run -d -p 3004:3004 custom-apache-image

6a7a403364c32a69dda59a59778c3ca2bade585a33cfc46a264bd6c244ee13d3

[root@stapp02 docker]# docker ps -a
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS         PORTS                    NAMES
6a7a403364c3   custom-apache-image   "apache2ctl -D FOREG…"   18 seconds ago   Up 5 seconds   0.0.0.0:3004->3004/tcp   elated_goldwasser
```
