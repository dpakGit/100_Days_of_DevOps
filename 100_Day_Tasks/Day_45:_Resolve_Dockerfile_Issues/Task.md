### Task:
The Nautilus DevOps team is working to create new images per requirements shared by the development team. One of the team members is working to create a Dockerfile on App Server 3 in Stratos DC. While working on it she ran into issues in which the docker build is failing and displaying errors. Look into the issue and fix it to build an image as per details mentioned below:

a. The Dockerfile is placed on App Server 3 under /opt/docker directory.

b. Fix the issues with this file and make sure it is able to build the image.

c. Do not change base image, any other valid configuration within Dockerfile, or any of the data been used — for example, index.html.

Note: Please note that once you click on FINISH button all existing images, the containers will be destroyed and new image will be built from your Dockerfile.

---------------------------------------------------------

### What is the Task and how to accomplish it ?

### Task: Fix a Dockerfile on App Server 3 in Stratos DC to build a Docker image successfully.

Given details:

- The Dockerfile is located in the /opt/docker directory on App Server 3.
- The base image, other configurations, and data (e.g., index.html) should not be changed.

Steps to accomplish the task:

1. Investigate the issue:
    - Check the Dockerfile for any syntax errors or potential issues.
    - Run the docker build command to see the error messages:

bash

cd /opt/docker

docker build -t my-image .

- Analyze the error messages to identify the problem.

2. Fix the issues:
    - Based on the error messages, fix the issues in the Dockerfile. Common issues might include:
        - Incorrect syntax or formatting.
        - Missing or incorrect dependencies.
        - Inaccessible files or directories.
    - Make sure to only fix the issues and do not change the base image or other valid configurations.

3. Verify the Dockerfile:
    - Once you've fixed the issues, verify that the Dockerfile is correct and should build the image successfully.
    - You can use the docker build command again to test the Dockerfile:

bash

docker build -t my-image .


4. Build the image:
   
- If the Dockerfile is correct, build the image using the docker build command:

bash

docker build -t my-image .

- This command will create a Docker image with the name my-image.

Commands and their use cases:

- cd /opt/docker: Changes the directory to /opt/docker, where the Dockerfile is located.
- docker build -t my-image .: Builds a Docker image using the Dockerfile in the current directory and tags it with the name my-image.
- docker build: This command is used to build Docker images from a Dockerfile.

### Important tips and best practices:

- Always verify the Dockerfile syntax and formatting before building the image.
- Use the docker build command with the -t flag to specify a tag for the image.
- Make sure to test the Dockerfile and image after making changes to ensure they work as expected.




### What I Did
```
thor@jumphost ~$ ssh banner@stapp03

[root@stapp03 banner]# cd /opt/docker/

[root@stapp03 docker]# ls

Dockerfile  certs  html

[root@stapp03 docker]# vi Dockerfile
```

### Faulty Dockerfile

```
FROM httpd:2.4.43

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

RUN sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' conf/httpd.conf

RUN sed -i '/LoadModule\ socache_shmcb_module modules\/mod_socache_shmcb.so/s/^#//g' conf/httpd.conf

RUN sed -i '/Include\ conf\/extra\/httpd-ssl.conf/s/^#//g' conf/httpd.conf

RUN cp certs/server.crt /usr/local/apache2/conf/server.crt

RUN cp certs/server.key /usr/local/apache2/conf/server.key

RUN cp html/index.html /usr/local/apache2/htdocs/
```
The above is a faulty Dockerfile already present at the location /opt/docker, lets see if we run the build command what is the output.
```
[root@stapp03 docker]# docker build -t myimage .


Error:
-------------------------------------------------------------------------------
[+] Building 189.0s (6/12)                                docker:default
 => [internal] load build definition from Dockerfile                0.0s
 => => transferring dockerfile: 564B                                0.0s
 => [internal] load metadata for docker.io/library/httpd:2.4.43   124.2s
 => [internal] load .dockerignore                                   0.0s
 => => transferring context: 2B                                     0.0s
 => [internal] load build context                                   0.0s
 => => transferring context: 3.19kB                                 0.0s
 => [1/8] FROM docker.io/library/httpd:2.4.43@sha256:cd88fee4eab3  63.7s
 => => resolve docker.io/library/httpd:2.4.43@sha256:cd88fee4eab37  0.0s
 => => sha256:b5fc3125d9129e4cdd43f496195cc8f39 10.37MB / 10.37MB  30.8s
 => => sha256:cd88fee4eab37f0d8cd04b06ef97285ca981 1.86kB / 1.86kB  0.0s
 => => sha256:53729354a74c9c146aa8726a8906e8337550 1.37kB / 1.37kB  0.0s
 => => sha256:f1455599cc2e008a4555f14451e590f07137 7.35kB / 7.35kB  0.0s
 => => sha256:bf59529304463f62efa7179fa1a32718a 27.09MB / 27.09MB  30.5s
 => => sha256:3d3fecf6569b94e406086a2b68a7c8930254490 146B / 146B  30.6s
 => => sha256:3c61041685c0f65e0b375bae6ae6bdeab 24.47MB / 24.47MB  61.3s
 => => extracting sha256:bf59529304463f62efa7179fa1a32718a611528cc  2.4s
 => => sha256:34b7e9053f76ca3c9dc574c5034679769256a59 298B / 298B  60.8s
 => => extracting sha256:3d3fecf6569b94e406086a2b68a7c8930254490b4  0.3s
 => => extracting sha256:b5fc3125d9129e4cdd43f496195cc8f39d43e9bad  0.9s
 => => extracting sha256:3c61041685c0f65e0b375bae6ae6bdeab9b6c2096  1.2s
 => => extracting sha256:34b7e9053f76ca3c9dc574c5034679769256a5960  0.7s
 => ERROR [2/8] RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/  1.1s
------
 > [2/8] RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf.d/httpd.conf:
1.052 sed: can't read /usr/local/apache2/conf.d/httpd.conf: No such file or directory
------
Dockerfile:3
--------------------
   1 |     FROM httpd:2.4.43
   2 |     
   3 | >>> RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf.d/httpd.conf
   4 |     
   5 |     RUN sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' conf.d/httpd.conf
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c sed -i \"s/Listen 80/Listen 8080/g\" /usr/local/apache2/conf.d/httpd.conf" did not complete successfully: exit code: 2
------------------------------------------------------------------------------------------------------------------
```

###  What is the error message and what to do ?

The error message indicates that the sed command in the Dockerfile is trying to modify a file that doesn't exist:

bash

sed: can't read /usr/local/apache2/conf.d/httpd.conf: No such file or directory

The issue seems to be with the path to the httpd.conf file. The correct path might be different.

Looking at the Dockerfile, the line causing the issue is:

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf.d/httpd.conf

Given the base image is httpd:2.4.43, the httpd.conf file is likely located at /usr/local/apache2/conf/httpd.conf.

Try updating the Dockerfile to use the correct path:

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

Also, check the next sed command in the Dockerfile and update its path accordingly:

RUN sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' /usr/local/apache2/conf/httpd.conf

Make these changes and try running the docker build command again:

bash

docker build -t myimage:1 .

- The httpd.conf file is not located in /usr/local/apache2/conf.d/, but rather in /usr/local/apache2/conf/.

- If you're still having issues with the Dockerfile, you might want to verify the location of the httpd.conf file in the httpd:2.4.43 image. You can do this by running a container from the image and checking the file system:

bash

docker run -it httpd:2.4.43 /bin/bash

- This will give you a shell prompt inside the container, where you can navigate the file system and find the location of the httpd.conf file.



### To locate the file path of httpd.conf in a running container or in a Docker image, you can use the following command:

- In my case:

To accurately determine the location of the httpd.conf file within the httpd:2.4.43 image , that is given in the Dockerfile, I will create a temporary Docker container from this image particular and access its interactive shell. 

This can be achieved by running the command ```docker run -it httpd:2.4.43 /bin/bash```, which launches a new container and provides a bash shell prompt inside the container. Once inside the container, I will utilize the find command, specifically ```find / -name httpd.conf```, to search the entire file system for the httpd.conf file and identify its exact path.

------------------------------------------------------------------------

```
docker run -it httpd:2.4.43 /bin/bash -c "find / -name httpd.conf"
```
This command will search for the httpd.conf file starting from the root directory (/) and print the path(s) where the file is found.


#### Alternatively, you can also use:

```
docker run -it httpd:2.4.43 /bin/bash
```

And then inside the container, run:

```
find / -name httpd.conf
```
This will give you an interactive shell where you can explore the file system and find the httpd.conf file.

In the case of the httpd:2.4.43 image, the httpd.conf file is likely located at /usr/local/apache2/conf/httpd.conf.


- After you know the location of the httpd.conf file, you can update your Dockerfile to use the correct path. For example, if you want to modify the httpd.conf file to change the port from 80 to 8080, you can use:

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

- The /usr/local/apache2/conf/httpd.conf file is the active configuration file used by Apache.

- When you make changes to the Apache configuration, you typically want to modify the active configuration file, which is /usr/local/apache2/conf/httpd.conf.

So, in your Dockerfile, you can use:

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.con

### Here are the commands to locate the httpd.conf file inside the container:

1. Find command:

```
find / -name httpd.conf
```
This command searches for files named httpd.conf starting from the root directory (/) and prints the path(s) where the file is found.

2. Locate command (if the locate database is updated):

```
locate httpd.conf
```
However, the locate command might not work if the database is not updated or if the file is not indexed.

3. Ls command (if you know the likely directory):

```
ls /usr/local/apache2/conf/httpd.conf
```
or

```
ls /etc/httpd/conf/httpd.conf
```
This command checks if the file exists in a specific directory. You can modify the path based on your knowledge of the container's file system.

You can run these commands inside the container using:

```
docker run -it httpd:2.4.43 bash
```
And then execute the command(s) you prefer.

- Note the above is not what we want as it states to change the configuration to change after the container is created, although it is correct our case is to modify the Dockerfile itself.


#### In the output of the following docker run command what is "/usr/local/apache2"

[root@stapp03 ~]# docker run -it httpd:2.4.43 bash
root@da8e8f65ce95:/usr/local/apache2#  #


- When you run the command:

bash

docker run -it httpd:2.4.43 bash

- You are starting a new container from the httpd:2.4.43 image and running a bash shell inside it.

- The /usr/local/apache2 is the working directory inside the container. This is because the httpd:2.4.43 image is configured to set the working directory to /usr/local/apache2 by default.

You can verify this by checking the WORKDIR instruction in the Dockerfile for the httpd:2.4.43 image. However, in this case, it's likely that the httpd process is designed to run from this directory, and it contains the necessary files and configuration for the Apache server.
Also it can be verified by running the docker inspect command

When you see the prompt:

bash

root@da8e8f65ce95:/usr/local/apache2#

It indicates that you are currently in the /usr/local/apache2 directory inside the container.

- You should replace the existing paths in your Dockerfile with /usr/local/apache2/conf/httpd.conf to match the actual location of the httpd.conf file in the httpd:2.4.43 image.

Specifically, you should update the RUN commands that modify the httpd.conf file to use the correct path:

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

- And any other RUN commands that reference the httpd.conf file should also be updated to use the correct path.

By doing so, you should be able to successfully build your Docker image and run the Apache server with the desired configuration.



Based on the standard directory structure of the httpd:2.4.43 image, it seems that the httpd.conf file is actually located at /usr/local/apache2/conf/httpd.conf, not /usr/local/apache2/conf.d/httpd.conf.

To fix the Dockerfile, you should update the paths to reference the correct location of the httpd.conf file. Here's the updated Dockerfile:


###  Modified Dockerfile
```
FROM httpd:2.4.43

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

RUN sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' /usr/local/apache2/conf/httpd.conf


RUN sed -i '/LoadModule\ socache_shmcb_module modules\/mod_socache_shmcb.so/s/^#//g' /usr/local/apache2/conf/httpd.conf


RUN sed -i '/Include\ conf\/extra\/httpd-ssl.conf/s/^#//g' /usr/local/apache2/conf/httpd.conf

COPY certs/server.crt /usr/local/apache2/conf/server.crt

COPY certs/server.key /usr/local/apache2/conf/server.key

COPY html/index.html /usr/local/apache2/htdocs/
```

```
[root@stapp03 docker]# vi Dockerfile # Modify the Dockerfile to the above configuration

[root@stapp03 docker]# docker build -t myimage .

[root@stapp03 docker]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
myimage      latest    79fbfb1bf74b   17 seconds ago   166MB

[root@stapp03 docker]# docker run -d --name mycontainer -p 8080:8080 myimage:latest
6a51270d68a96e0db3bd1261fa36ae87b55455513bbc51788f298e955a59f077

[root@stapp03 docker]# docker ps -a
CONTAINER ID   IMAGE            COMMAND              CREATED         STATUS         PORTS                            NAMES
6a51270d68a9   myimage:latest   "httpd-foreground"   7 seconds ago   Up 4 seconds   80/tcp, 0.0.0.0:8080->8080/tcp   mycontainer

[root@stapp03 docker]# curl localhost:8080
This Dockerfile works![root@stapp03 docker]# 
```

- Note : The output of the docker inspect command shows various details about the image, including:

- Config: Configuration settings for the image, such as environment variables, exposed ports, and the command to run when the container starts.

- WorkingDir: The working directory inside the container, which is /usr/local/apache2. This confirms what we previously discovered.


#### Note: Read the Dockerfile very carefully to find out errors and mistakes.




### Second Attempt

### Faulty Dockerfile
```
 IMAGE httpd:2.4.43

ADD sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

ADD sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' conf/httpd.conf

ADD sed -i '/LoadModule\ socache_shmcb_module modules\/mod_socache_shmcb.so/s/^#//g' conf/httpd.conf

ADD sed -i '/Include\ conf\/extra\/httpd-ssl.conf/s/^#//g' conf/httpd.conf

COPY certs/server.crt /usr/local/apache2/conf/server.crt

COPY certs/server.key /usr/local/apache2/conf/server.key

COPY html/index.html /usr/local/apache2/htdocs/
```

docker build -t myimage .
```
Error:
[+] Building 121.1s (2/2) FINISHED                        docker:default
 => [internal] load build definition from Dockerfile                0.0s
 => => transferring dockerfile: 557B                                0.0s
 => [internal] load metadata for docker.io/library/httpd:2.4.43   121.0s
Dockerfile:3
--------------------
   1 |     FROM httpd:2.4.43
   2 |     
   3 | >>> ADD sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf
   4 |     
   5 |     ADD sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' conf/httpd.conf
--------------------
ERROR: failed to build: failed to solve: failed to process "\"s/Listen": unexpected end of statement while looking for matching double-quote
```

- The issue here is that you're using the ADD instruction incorrectly. ADD is used to copy files from the local directory into the Docker image, whereas you're trying to use it to run sed commands.

- To run commands during the Docker build process, you should use the RUN instruction.

- Also updated the path in the sed commands to /usr/local/apache2/conf/httpd.conf.

- Modified Dockerfile is exactly same as the above

```
FROM httpd:2.4.43

RUN sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

RUN sed -i '/LoadModule\ ssl_module modules\/mod_ssl.so/s/^#//g' /usr/local/apache2/conf/httpd.conf


RUN sed -i '/LoadModule\ socache_shmcb_module modules\/mod_socache_shmcb.so/s/^#//g' /usr/local/apache2/conf/httpd.conf


RUN sed -i '/Include\ conf\/extra\/httpd-ssl.conf/s/^#//g' /usr/local/apache2/conf/httpd.conf

COPY certs/server.crt /usr/local/apache2/conf/server.crt

COPY certs/server.key /usr/local/apache2/conf/server.key

COPY html/index.html /usr/local/apache2/htdocs/
```

#### Note:

docker run -it httpd:2.4.43 /bin/bash and docker exec -it httpd:2.4.43 /bin/bash are two different commands that serve distinct purposes:

1. docker run -it httpd:2.4.43 /bin/bash:
    - This command creates a new container from the httpd:2.4.43 image and starts a new process (/bin/bash) inside it.
    - The -it flags allow interactive shell access to the container.
    - When you exit the shell, the container stops.

2. docker exec -it httpd:2.4.43 /bin/bash:
    - This command executes a new process (/bin/bash) inside an existing container named httpd:2.4.43.
    - The -it flags allow interactive shell access to the container.
    - When you exit the shell, the container continues running.

Key differences:

- docker run creates a new container, while docker exec operates on an existing container.
- docker run starts a new process, while docker exec executes a new process inside an existing container.

When to use each:

- Use docker run when you want to create a new container from an image and interact with it.
- Use docker exec when you want to access an existing container that is already running.

In the context of finding the httpd.conf file path, docker run -it httpd:2.4.43 /bin/bash is a suitable choice because you want to create a temporary container to inspect the file system. If you already have a running container, you could use docker exec -it <container_name> /bin/bash instead.

Let's break down the meaning of this line: "docker run starts a new process, while docker exec executes a new process inside an existing container."

- docker run starts a new process:
    - When you use docker run, you're creating a new container from an image.
    - This new container runs a single process (specified in the CMD instruction of the Dockerfile or overridden at runtime).
    - This process is the main process of the container, and when it exits, the container stops.
- docker exec executes a new process inside an existing container:
    - When you use docker exec, you're running a new command or process inside a container that already exists and is running.
    - This new process runs in addition to the main process of the container.
    - When the new process exits, the container continues running, as the main process is still active.

In summary, docker run creates a new container and starts a new process, while docker exec runs a new process inside an existing container that's already running.
