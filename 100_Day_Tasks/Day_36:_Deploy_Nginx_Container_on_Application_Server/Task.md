### Task

The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on Application Server 2. Complete the task with the following instructions:

On Application Server 2 create a container named nginx_2 using the nginx image with the alpine tag. Ensure container is in a running state.

Task Explanation:
Deploying Nginx Container on Application Server 2
- Use Docker to create and run a container named nginx_2 using the nginx:alpine image on Application Server 2.


-------------------------------------------------------------------------

### What I did

```
thor@jumphost ~$ ssh steve@stapp02

[root@stapp02 steve]# docker # To check if docker is installed or not

[root@stapp02 steve]# docker ps 

CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

[root@stapp02 steve]# docker ps -a

CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

[root@stapp02 steve]# docker run -d --name nginx_2 nginx:alpine

Unable to find image 'nginx:alpine' locally
alpine: Pulling from library/nginx
9824c27679d3: Pull complete 
6bc572a340ec: Pull complete 
403e3f251637: Pull complete 
9adfbae99cb7: Pull complete 
7a8a46741e18: Pull complete 
c9ebe2ff2d2c: Pull complete 
a992fbc61ecc: Pull complete 
cb1ff4086f82: Pull complete 
Digest: sha256:42a516af16b852e33b7682d5ef8acbd5d13fe08fecadc7ed98605ba5e3b26ab8
Status: Downloaded newer image for nginx:alpine
666a1f0dfc2804c05862ab121be9a5e25e8417bf6b8e85f20279aded38efc6a8

[root@stapp02 steve]# docker ps 

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
666a1f0dfc28   nginx:alpine   "/docker-entrypoint.…"   28 seconds ago   Up 26 seconds   80/tcp    nginx_2

[root@stapp02 steve]# docker ps -a

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
666a1f0dfc28   nginx:alpine   "/docker-entrypoint.…"   37 seconds ago   Up 35 seconds   80/tcp    nginx_2

[root@stapp02 steve]# docker ps | grep nginx_2

666a1f0dfc28   nginx:alpine   "/docker-entrypoint.…"   About a minute ago   Up About a minute   80/tcp    nginx_2

```
