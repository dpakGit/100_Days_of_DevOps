### Task:
### The Nautilus application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:

PostgreSQL database server is already installed on the Nautilus database server.


a. Create a database user kodekloud_joy and set its password to Rc5C9EyvbU.


b. Create a database kodekloud_db4 and grant full permissions to user kodekloud_joy on this database.


Note: Please do not try to restart PostgreSQL server service.

-----------------------------------
https://tundedamian.medium.com/day-17-of-100-days-of-devops-postgresql-database-user-permissions-setup-cf76e4ff874a
--------------------------------------

###  What i did

thor@jumphost ~$ peter@172.16.239.10

thor@jumphost ~$ ssh peter@172.16.239.10

[peter@stdb01 ~]$ sudo su - postgres

[postgres@stdb01 ~]$ psql
psql (13.14)
Type "help" for help.

postgres=# CREATE USER kodekloud_top WITH PASSWORD 'Rc5C9EyvbU';

CREATE ROLE

postgres=# CREATE DATABASE kodekloud_db7;

CREATE DATABASE

postgres=# GRANT ALL PRIVILEGES ON DATABASE kodekloud_db7 TO kodekloud_top;
GRANT

postgres=# exit
[postgres@stdb01 ~]$ 
