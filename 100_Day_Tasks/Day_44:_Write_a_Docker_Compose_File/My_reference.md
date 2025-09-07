### Here's a step-by-step guide to accomplish the task:

Task: Set up an environment to host a static website on an httpd web server using a containerized platform.

Step 1: Create a Docker Compose file

Create a file named docker-compose.yml in the /opt/docker directory with the following content:

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

Step 2: Run the Docker Compose file

Navigate to the /opt/docker directory and run the following command:

bash
docker-compose up -d

This command starts the container in detached mode.

Let's break down the command:

- docker-compose: The command to manage Docker Compose files.
- up: Starts the containers defined in the Docker Compose file.
- -d: Runs the containers in detached mode (in the background).

Step 3: Verify the container

Use the following command to verify that the container is running:

bash
docker ps

This command lists all the running containers on the system. You should see the httpd container in the list.

Use case:

In this task, we're using Docker Compose to create a containerized environment for hosting a static website on an httpd web server. The Docker Compose file defines the configuration for the container, including the image, port mapping, and volume mapping. By running the Docker Compose file, we can easily create and manage the containerized environment.

Benefits:

- Containerization provides a lightweight and portable way to deploy applications.
- Docker Compose simplifies the process of defining and managing multi-container environments.
- Volume mapping allows us to persist data between container restarts.

By following these steps, you've successfully set up an environment to host a static website on an httpd web server using a containerized platform. You can now access the website by visiting http://localhost:5000 in your web browser.


### The difference between the two commands lies in how Docker Compose locates the docker-compose.yml file:

1. docker-compose up -d:
    - This command tells Docker Compose to look for a file named docker-compose.yml in the current working directory.
    - If the file is found, Docker Compose will use it to create and start the containers in detached mode.

2. docker compose -f docker-compose.yml up -d:
    - This command uses the -f flag to specify the path to the Docker Compose file.
    - You can use this flag to specify a different file name or location for the Docker Compose file.
    - In this case, Docker Compose will use the specified file (docker-compose.yml) to create and start the containers in detached mode.

In your case, since the Docker Compose file is located at /opt/docker/docker-compose.yml, you would need to use the following command:

bash
docker-compose -f /opt/docker/docker-compose.yml up -d

Or, if you want to run the command from within the /opt/docker directory:

bash
cd /opt/docker
docker-compose up -d

Both approaches achieve the same result, but the first one provides more flexibility in terms of specifying the file location.

Also, note the difference between docker compose (with a space) and docker-compose (with a hyphen). docker compose is the new command format, while docker-compose is the older format. Both should work, but docker compose is recommended for newer versions of Docker.



### The docker ps command doesn't accept container names as arguments. Instead, you can use the -f flag to filter the output by container name:

bash
docker ps -f name=httpd

This will show you the running container with the name httpd.

If you want to see all containers (running and stopped) with the name httpd, you can add the -a flag:

bash
docker ps -a -f name=httpd

Alternatively, you can use docker container ls instead of docker ps. The usage is similar:

bash
docker container ls -f name=httpd

or

bash
docker container ls -a -f name=httpd



### What is a volume?
A volume is a way to share files between your computer (the Docker host) and a container. Think of it like a shared folder.

What needs to be done?
We need to map (or connect) a folder inside the container to a folder on our computer (the Docker host).

The folders:

1. Container folder: /usr/local/apache2/htdocs
This is a folder inside the container where the website files (like HTML, images, etc.) are stored. This is a default folder for the Apache web server (httpd) to serve files from.
2. Docker host folder: /opt/devops
This is a folder on our computer (the Docker host) that already exists. It likely contains the website files that we want to serve.

What does mapping mean?
When we map these two folders, it means that whatever files are in the /opt/devops folder on our computer will be available in the /usr/local/apache2/htdocs folder inside the container. Any changes made to files in /opt/devops on our computer will be reflected inside the container, and vice versa.

Why do we need this?
By mapping these folders, we can:

- Serve the website files from our computer's /opt/devops folder without having to copy them into the container.
- Make changes to the website files on our computer, and the changes will be reflected in the container without needing to rebuild the container.

In the Docker Compose file, this mapping is achieved using the volumes directive:

volumes:
  - /opt/devops:/usr/local/apache2/htdocs

This line tells Docker to map the /opt/devops folder on our computer to the /usr/local/apache2/htdocs folder inside the container.
