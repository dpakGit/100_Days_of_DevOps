
### Task
The Nautilus Application development team recently finished development of one of the apps that they want to deploy on a containerized platform. The Nautilus Application development and DevOps teams met to discuss some of the basic pre-requisites and requirements to complete the deployment. The team wants to test the deployment on one of the app servers before going live and set up a complete containerized stack using a docker compose fie. Below are the details of the task:

On App Server 3 in Stratos Datacenter create a docker compose file /opt/devops/docker-compose.yml (should be named exactly).

The compose should deploy two services (web and DB), and each service should deploy a container as per details below:

For web service:

a. Container name must be php_web.

b. Use image php with any apache tag. Check here for more details.

c. Map php_web container's port 80 with host port 3000

d. Map php_web container's /var/www/html volume with host volume /var/www/html.

For DB service:

a. Container name must be mysql_web.

b. Use image mariadb with any tag (preferably latest). Check here for more details.

c. Map mysql_web container's port 3306 with host port 3306

d. Map mysql_web container's /var/lib/mysql volume with host volume /var/lib/mysql.

e. Set MYSQL_DATABASE=database_web and use any custom user ( except root ) with some complex password for DB connections.

After running docker-compose up you can access the app with curl command curl <server-ip or hostname>:3000/

For more details check here.


Note: Once you click on FINISH button, all currently running/stopped containers will be destroyed and stack will be deployed again using your compose file.


----------------------------------------------------------


- Task Overview

The task is to create a Docker Compose file on App Server 3 in Stratos Datacenter to deploy a containerized stack with two services: web and DB. The web service will use a PHP image with Apache, and the DB service will use a MariaDB image. The containers will be configured to map specific ports and volumes, and environment variables will be set for the DB service.


### What I Did

```
thor@jumphost ~$ ssh banner@stapp03

[banner@stapp03 ~]$ sudo -s

[root@stapp03 banner]# cd /opt/devops/

[root@stapp03 devops]# vi docker-compose.yml

[root@stapp03 devops]# docker compose -f docker-compose.yml up -d

WARN[0000] /opt/devops/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 25/2
 ✔ web Pulled                                                                                                             39.4s 
 ✔ db Pulled                                                                                                              21.8s 
[+] Running 3/3
 ✔ Network devops_default  Created                                                                                         0.1s 
 ✔ Container php_web       Started                                                                                         8.9s 
 ✔ Container mysql_web     Started                                                                                         8.9s 

[root@stapp03 devops]# docker images

REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
php          apache    fea94ecdc70e   7 days ago    511MB
mariadb      latest    b443cc897ca5   3 weeks ago   330MB

[root@stapp03 devops]# docker ps -a

CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                    NAMES
8fce5d04e621   php:apache       "docker-php-entrypoi…"   26 seconds ago   Up 17 seconds   0.0.0.0:3000->80/tcp     php_web
f8011793c8dc   mariadb:latest   "docker-entrypoint.s…"   26 seconds ago   Up 17 seconds   0.0.0.0:3306->3306/tcp   mysql_web

[root@stapp03 devops]# curl 172.16.238.12:3000  
<html>
    <head>
        <title>Welcome to xFusionCorp Industries!</title>
    </head>

    <body>
        Welcome to xFusionCorp Industries!    </body>
```

#### # docker-compose.yml 

```
version: '3'
services:
  web:
    container_name: php_web
    image: php:apache
    ports:
      - "3000:80"
    volumes:
      - /var/www/html:/var/www/html

  db:
    container_name: mysql_web
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: database_web
      MYSQL_USER: customuser
      MYSQL_PASSWORD: complexpassword123
      MYSQL_ROOT_PASSWORD: complexrootpassword123

```

#### # docker-compose.yml using depends_on option

To ensure that the web container is created only after the db container is created, you can use the depends_on option in the docker-compose.yml file. Here's the modified file:
```
version: '3'
services:
  web:
    container_name: php_web
    image: php:apache
    ports:
      - "3000:80"
    volumes:
      - /var/www/html:/var/www/html
    depends_on:
      - db

  db:
    container_name: mysql_web
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: database_web
      MYSQL_USER: customuser
      MYSQL_PASSWORD: complexpassword123
      MYSQL_ROOT_PASSWORD: complexrootpassword123
```

The depends_on option specifies that the web service depends on the db service, which means that Docker Compose will start the db container before starting the web container.

Note that depends_on only ensures that the containers are started in the correct order, but it does not guarantee that the database is fully initialized and ready to accept connections when the web container starts. If you need to ensure that the web container only starts after the database is fully initialized, you may need to use a more advanced solution, such as a health check or a wait script.

#### # docker-compose.yml using links keyword

The links keyword is another way to specify dependencies between containers in a docker-compose.yml file.

Here's an example of how you can use links to achieve the same result as depends_on:
```
version: '3'
services:
  web:
    container_name: php_web
    image: php:apache
    ports:
      - "3000:80"
    volumes:
      - /var/www/html:/var/www/html
    links:
      - db

  db:
    container_name: mysql_web
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: database_web
      MYSQL_USER: customuser
      MYSQL_PASSWORD: complexpassword123
      MYSQL_ROOT_PASSWORD: complexrootpassword123
```
The links keyword establishes a connection between the web container and the db container, allowing the web container to access the db container.

However, there are some key differences between links and depends_on:

- links is a legacy feature that was used in older versions of Docker Compose. While it still works, it's recommended to use depends_on instead.
- links not only specifies dependencies but also allows containers to communicate with each other using the linked container's name as a hostname.
- depends_on only specifies dependencies and does not enable automatic hostname resolution between containers.

In general, depends_on is a more modern and flexible way to specify dependencies between containers, and it's recommended to use it instead of links unless you have a specific reason to use links.
