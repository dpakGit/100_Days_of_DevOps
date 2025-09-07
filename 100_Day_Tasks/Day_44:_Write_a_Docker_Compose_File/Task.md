### Task:

Explain the following task clearly and elaborately,
give me the steps and commands required  to accomplish the task and 
explain each step and command and their use case - The Nautilus application development team shared static website content that needs to be hosted on the httpd web server using a containerised platform. The team has shared details with the DevOps team, and we need to set up an environment according to those guidelines. Below are the details:

a. On App Server 2 in Stratos DC create a container named httpd using a docker compose file /opt/docker/docker-compose.yml (please use the exact name for file).

b. Use httpd (preferably latest tag) image for container and make sure container is named as httpd; you can use any name for service.

c. Map 80 number port of container with port 5000 of docker host.

d. Map container's /usr/local/apache2/htdocs volume with /opt/devops volume of docker host which is already there. (please do not modify any data within these locations).


### What I Did

```
thor@jumphost ~$ ssh steve@stapp02

[steve@stapp02 ~]$ sudo -s

[root@stapp02 steve]# docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE

[root@stapp02 steve]# docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


# Note : Output of the commands docker images and docker ps -a, there is no images and container

[root@stapp02 steve]# docker compose

[root@stapp02 ~]# cd /opt/docker/

[root@stapp02 docker]# ls

[root@stapp02 docker]# pwd
/opt/docker

[root@stapp02 docker]# vi docker-compose.yml

----------------------------------
# Followig is the content of the file docker-compose.yml

version: '3'
services:
  web:
    image: httpd:latest
    container_name: httpd
    ports:
      - "5000:80"
    volumes:
      - /opt/devops:/usr/local/apache2/htdocs

Let's break down the Docker Compose file:

- version: Specifies the version of the Docker Compose format.
- services: Defines the services (containers) to be created.
- web: The name of the service (you can use any name).
- image: Specifies the Docker image to use (in this case, httpd:latest).
- container_name: Specifies the name of the container (in this case, httpd).
- ports: Maps port 5000 on the host machine to port 80 in the container.
- volumes: Maps the /opt/devops directory on the host machine to the /usr/local/apache2/htdocs directory in the container.

------------------------------------

# Run Docker Compose command:

[root@stapp02 docker]# docker compose -f docker-compose.yml up -d

[root@stapp02 docker]# docker images

REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
httpd        latest    199e3a035264   3 weeks ago   117MB

[root@stapp02 docker]# docker ps -a

CONTAINER ID   IMAGE          COMMAND              CREATED         STATUS         PORTS                  NAMES
c28e0aca1328   httpd:latest   "httpd-foreground"   2 minutes ago   Up 2 minutes   0.0.0.0:5000->80/tcp   httpd

[root@stapp02 docker]# docker ps -f name=httpd # OR this command also works

CONTAINER ID   IMAGE          COMMAND              CREATED         STATUS         PORTS                  NAMES
c28e0aca1328   httpd:latest   "httpd-foreground"   3 minutes ago   Up 3 minutes   0.0.0.0:5000->80/tcp   httpd
```

### docker-compose.yml
```
version: '3'
services:
  web:
    image: httpd:latest
    container_name: httpd
    ports:
      - "5000:80"
    volumes:
      - /opt/devops:/usr/local/apache2/htdocs
```
