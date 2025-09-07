### Let's break down the task and provide the steps and commands required to accomplish it.

Task Overview

The task is to create a Docker Compose file on App Server 3 in Stratos Datacenter to deploy a containerized stack with two services: web and DB. The web service will use a PHP image with Apache, and the DB service will use a MariaDB image. The containers will be configured to map specific ports and volumes, and environment variables will be set for the DB service.

Step 1: Create the Docker Compose file

Create a file named docker-compose.yml in the /opt/devops directory with the following contents:
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
Let's explain each section:

- version: Specifies the version of the Docker Compose file format.
- services: Defines the services (containers) to be created.
- web: Defines the php_web service.
    - container_name: Specifies the name of the container.
    - image: Specifies the Docker image to use (PHP with Apache).
    - ports: Maps port 3000 on the host machine to port 80 on the container.
    - volumes: Maps the /var/www/html volume on the host machine to the same path on the container.
- db: Defines the mysql_web service.
    - container_name: Specifies the name of the container.
    - image: Specifies the Docker image to use (MariaDB).
    - ports: Maps port 3306 on the host machine to port 3306 on the container.
    - volumes: Maps the /var/lib/mysql volume on the host machine to the same path on the container.
    - environment: Sets environment variables for the container, including the database name, user, password, and root password.

Step 2: Run the Docker Compose file

Run the following command to start the containers:

docker-compose up -d

This command will start the containers in detached mode.

Step 3: Verify the deployment

You can verify the deployment by accessing the app using the curl command:

curl <server-ip or hostname>:3000/

Replace <server-ip or hostname> with the IP address or hostname of App Server 3.

Use Cases

- The docker-compose.yml file defines a containerized stack with two services: web and DB.
- The web service uses a PHP image with Apache and maps port 3000 on the host machine to port 80 on the container.
- The DB service uses a MariaDB image and maps port 3306 on the host machine to port 3306 on the container.
- Environment variables are set for the DB service to configure the database name, user, password, and root password.
- The containers are configured to persist data using volumes.

By following these steps and using the provided docker-compose.yml file, you should be able to deploy a containerized stack with two services: web and DB.


### Explain the following " Set MYSQL_DATABASE=database_web and use any custom user ( except root ) with some complex password for DB connections."

### Setting MYSQL_DATABASE=database_web

- MYSQL_DATABASE is an environment variable that specifies the name of the database to be created in the MySQL/MariaDB container.
- In this case, the database name is set to database_web.
- This means that when the container starts, it will create a database named database_web and make it available for use.

Using a custom user (except root) with a complex password for DB connections

- This requirement specifies that you should create a custom user account for database connections, rather than using the default root user.
- The custom user should have a complex password, which is a password that is difficult to guess or crack.
- This is a security best practice, as using a custom user with a complex password reduces the risk of unauthorized access to the database.

To implement this requirement, you would set the following environment variables in the docker-compose.yml file:

- MYSQL_USER: specifies the custom user account to be created.
- MYSQL_PASSWORD: specifies the password for the custom user account.

For example:

environment:
  MYSQL_DATABASE: database_web
  MYSQL_USER: customuser
  MYSQL_PASSWORD: complexpassword123

In this example:

- customuser is the custom user account that will be created.
- complexpassword123 is the password for the custom user account.

By setting these environment variables, you are creating a custom user account with a complex password, which will be used for database connections.

Why not use the root user?

- Using the root user account for database connections is not recommended, as it has full privileges and access to all databases.
- If the root user account is compromised, it could lead to serious security issues, such as data breaches or unauthorized modifications to the database.
- By creating a custom user account with limited privileges, you can reduce the risk of security breaches and ensure that only authorized users have access to the database.

Best practices

- Use a strong and unique password for the custom user account.
- Limit the privileges of the custom user account to only what is necessary for the application.
- Use environment variables to store sensitive information, such as passwords, rather than hardcoding them in the docker-compose.yml file.

By following these best practices and implementing a custom user account with a complex password, you can improve the security of your database and reduce the risk of security breaches.


#### When setting environment variables for a MySQL or MariaDB container in a docker-compose.yml file, you typically use the following format:

environment:
  - MYSQL_DATABASE=database_web
  - MYSQL_USER=customuser
  - MYSQL_PASSWORD=complexpassword123
  - MYSQL_ROOT_PASSWORD=complexrootpassword123

Or, in a more concise format:

environment:
  MYSQL_DATABASE: database_web
  MYSQL_USER: customuser
  MYSQL_PASSWORD: complexpassword123
  MYSQL_ROOT_PASSWORD: complexrootpassword123

Both formats are valid, but the second one is more commonly used in docker-compose.yml files.

Make sure to include MYSQL_ROOT_PASSWORD as well, as it's required for the MySQL/MariaDB container to set up the root user account.

With these environment variables, the container will:

- Create a database named database_web
- Create a user account with the username customuser and password complexpassword123
- Set the root password to complexrootpassword123

This way, you can easily configure your database container with the desired settings.


No, the name of the container is not passed as an environment variable. Instead, the container name is specified in the container_name directive in the docker-compose.yml file.

The environment variables in this case are used to configure the MariaDB database container. Specifically, the environment variables MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, and MYSQL_ROOT_PASSWORD are used to:

- Create a database with the specified name (database_web)
- Create a user account with the specified username and password (customuser and complexpassword123)
- Set the root password for the database (complexrootpassword123)

These environment variables are specific to the MariaDB image and are used to configure the database when the container starts.

Here's a breakdown:

- Container name: container_name: mysql_web (specified in the docker-compose.yml file)
- Environment variables:
    - MYSQL_DATABASE: database_web
    - MYSQL_USER: customuser
    - MYSQL_PASSWORD: complexpassword123
    - MYSQL_ROOT_PASSWORD: complexrootpassword123
 
Q: Why Environmental Variables are used ?

Think of environment variables like settings for a program. They're used to tell the program how to behave or what values to use.

In the case of the MariaDB container, environment variables are used to configure the database settings, such as:

- What database to create
- What username and password to use
- Other settings that affect how the database works

Using environment variables makes it easy to:

- Change settings without modifying the code
- Keep sensitive information (like passwords) secure
- Make the container more flexible and reusable

It's like having a control panel for your program, where you can adjust settings without having to dig into the code.




- What are environment variables?

Environment variables are like labeled boxes where you can store values that can be used by a program or a container. These values can be things like database names, usernames, passwords, or other settings that the program needs to work properly.

- Why use environment variables?

Imagine you're building a LEGO castle. You don't want to hardcode the color of the castle's bricks into the instructions. Instead, you want to be able to use different colors depending on the situation. Environment variables are like those colors. You can set them to different values depending on the situation, and the program will use the values you set.

In the case of the MariaDB container, environment variables are used to configure the database settings, such as the database name, username, and password. By using environment variables, you can:

- Keep sensitive information (like passwords) separate from the code
- Easily change the settings without modifying the code
- Make the container more flexible and reusable

- How do environment variables work?

When you set an environment variable, you're essentially telling the program to look for a specific value in a specific box. When the program starts, it checks the box for the value and uses it accordingly.

In the docker-compose.yml file, you set environment variables like this:

environment:
  MYSQL_DATABASE: database_web
  MYSQL_USER: customuser
  MYSQL_PASSWORD: complexpassword123

When the MariaDB container starts, it will use these values to configure the database.

Benefits

Using environment variables provides several benefits, including:

- Flexibility: You can easily change the settings without modifying the code.
- Security: You can keep sensitive information separate from the code.
- Reusability: You can use the same container with different settings.

In summary, environment variables are like labeled boxes that store values used by a program or container. They provide flexibility, security, and reusability, making it easier to manage and configure your applications.
