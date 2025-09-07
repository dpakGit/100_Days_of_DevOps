### Task:

The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on Application Server 3 in Stratos Datacenter. Please perform the task as per details mentioned below:

a. Pull nginx:alpine-perl docker image on Application Server 3.

b. Create a container named ecommerce using the image you pulled.

c. Map host port 8082 to container port 80. Please keep the container in running state.


### What I Did


```
thor@jumphost ~$ ssh banner@stapp03

[banner@stapp03 ~]$ sudo -s

# Step 1: Pull the Nginx Docker image
# Use the following command to pull the nginx:alpine-perl Docker image:

[root@stapp03 banner]# docker pull nginx:alpine-perl

[root@stapp03 banner]# docker images

REPOSITORY   TAG           IMAGE ID       CREATED       SIZE

nginx        alpine-perl   a6dd63693915   2 weeks ago   90.9MB

# Step 2: Create and run the Nginx container

[root@stapp03 banner]# docker run -d --name ecommerce -p 8082:80 nginx:alpine-perl

567852eba8076fc0e0041c578eaaa2679c0cc2198cbe436945e7ea469ac8107d


# Step 3: Verify the container

[root@stapp03 banner]# docker ps -a

CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS                  NAMES
567852eba807   nginx:alpine-perl   "/docker-entrypoint.…"   8 seconds ago   Up 6 seconds   0.0.0.0:8082->80/tcp   ecommerce

# To verify that the port mapping is successful, you can use the following three commands:

[root@stapp03 banner]# docker port ecommerce
80/tcp -> 0.0.0.0:8082

[root@stapp03 banner]# docker ps -a --format "table {{.Names}}\t{{.Ports}}"
NAMES       PORTS
ecommerce   0.0.0.0:8082->80/tcp

[root@stapp03 banner]# ss -tlnp | grep 8082
LISTEN 0      4096         0.0.0.0:8082       0.0.0.0:*    users:(("docker-proxy",pid=2503,fd=4))


[root@stapp03 banner]# curl http://localhost:8082

```


```
[root@stapp03 banner]# history | cut -c 8-
docker pull nginx:alpine-perl
docker images
docker run -d --name ecommerce -p 8082:80 nginx:alpine-perl
docker ps -a
docker port ecommerce
docker ps -a --format "table {{.Names}}\t{{.Ports}}"
ss -tlnp | grep 8082
curl http://localhost:8082
```
