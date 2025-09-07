### Setting Up WordPress Hosting on xFusionCorp Industries Infra
To accomplish the task of hosting a WordPress website on xFusionCorp Industries infra in Stratos Datacenter:

a. Install httpd, php, and dependencies on all app hosts

bash
 Install Apache (httpd), PHP, and necessary dependencies
```
sudo yum install httpd php php-mysqlnd -y
```

b. Configure Apache to serve on port 8089
- Edit Apache config to listen on port 8089:

bash
Edit /etc/httpd/conf/httpd.conf
```
sudo sed -i 's/Listen 80/Listen 8089/g' /etc/httpd/conf/httpd.conf
```
- Start and enable Apache:

bash
```
sudo systemctl start httpd
sudo systemctl enable httpd
```

c. Install/Configure MariaDB server on DB Server

```
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

d. Create database and user in MariaDB

Run MariaDB secure installation if needed
```
sudo mysql_secure_installation
```
Connect to MariaDB
```
sudo mysql -u root
```
Create database and user, grant privileges
```
CREATE DATABASE kodekloud_db5;
CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
FLUSH PRIVILEGES;
```

e. Verify Access via LBR link
- Ensure WordPress is configured to connect to kodekloud_db5 using user kodekloud_roy.
- Access the website via the LBR link by clicking the App button. You should see a message indicating the app can connect to the database using user kodekloud_roy.

Do you need help with:
- *Configuring WordPress to use kodekloud_db5*?
- Testing database connectivity?
- Troubleshooting Apache or MariaDB issues?

### Task Explanation: Setting Up WordPress Hosting on xFusionCorp Industries Infra
The task involves setting up the infrastructure for hosting a WordPress website on xFusionCorp Industries infra in Stratos Datacenter. The requirements are:

- Pre-requisite: Infrastructure configuration is done. A shared directory /var/www/html on the storage server is mounted on each app host under /var/www/html.
- Task requirements:
    - a. Install httpd, php, and dependencies: Install Apache (httpd), PHP, and necessary dependencies on all app hosts.
    - b. Configure Apache: Apache should serve on port 8089 on the app hosts.
    - c. Install/Configure MariaDB: Install and configure MariaDB server on the DB Server.
    - d. Create database and user: Create a database named kodekloud_db5, create a user named kodekloud_roy with password BruCStnMT5, and grant all privileges on kodekloud_db5 to kodekloud_roy.
    - e. Verify access: Access the website via the LBR link by clicking the App button. You should see a message indicating the app can connect to the database using user kodekloud_roy.

Commands and Use Cases
a. Install httpd, php, and dependencies on all app hosts
- Command: Run on each app host.

bash
sudo yum install httpd php php-mysqlnd -y

- Use case: Installs Apache, PHP, and PHP-MySQL module for database connectivity.

b. Configure Apache to serve on port 8089
- Commands:

bash
Edit Apache config
bash
sudo sed -i 's/Listen 80/Listen 8089/g' /etc/httpd/conf/httpd.conf
sudo systemctl start httpd
sudo systemctl enable httpd

- Use case: Configures Apache to listen on port 8089 instead of default 80, starts, and enables Apache.

c. Install/Configure MariaDB server on DB Server
- Commands:

bash
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

- Use case: Installs MariaDB, starts, and enables the service on the DB Server.

d. Create database and user in MariaDB
- Commands: Run on the DB Server.

bash
sudo mysql -u root

Then in MariaDB prompt:

CREATE DATABASE kodekloud_db5;
CREATE USER 'kodekloud_roy'@'%' IDENTIFIED BY 'BruCStnMT5';
GRANT ALL PRIVILEGES ON kodekloud_db5.* TO 'kodekloud_roy'@'%';
FLUSH PRIVILEGES;

- Use case: Creates database kodekloud_db5, user kodekloud_roy, grants all privileges on the database to the user.

e. Verify Access via LBR link
- Use case: After setup, clicking the App button on the top bar via LBR link should show a message like "App is able to connect to the database using user kodekloud_roy".

Do you need help with:
- *Configuring WordPress to connect to kodekloud_db5*?
- Testing the database connection?
- Troubleshooting issues with Apache or MariaDB?

### Repeat steps a and b on each app server.

- Step a: Install httpd, php, and dependencies on each app host to ensure they can serve the WordPress website.
- Step b: Configure Apache to listen on port 8089 on each app host for consistent configuration.

Why on each app server?
Since the shared /var/www/html is mounted on each app host, repeating these steps ensures each app server is configured correctly to serve the website.

Do you need help with:
- *Configuring WordPress on the shared /var/www/html*?
- Testing the website on each app server?
- Load balancing or further configuration?

### Ensuring App Servers Can Serve the WordPress Website
To ensure each app server can serve the WordPress website:

Steps
1. WordPress files in shared directory: Place WordPress files in the shared /var/www/html directory on the storage server. Since this is mounted on each app host under /var/www/html, all app servers will have access to the same WordPress files.
2. Database connection configuration: In WordPress's wp-config.php file (in /var/www/html), configure database connection details to use:
    - Database name: kodekloud_db5
    - Database user: kodekloud_roy
    - Database password: BruCStnMT5
    - Database host: DB Server's IP/hostname
3. Apache serving: With Apache configured on port 8089 on each app server, the website should be accessible via the app servers' IPs on port 8089.

Verification
- Access the WordPress site via an app server's IP on port 8089 (e.g., http://<app-server-ip>:8089).
- Verify WordPress connects to the database using kodekloud_roy.

Do you need help with:
- Configuring wp-config.php for WordPress?
- Testing WordPress connectivity to the database?
- Troubleshooting WordPress or Apache issues?

### Running Step c and d
You should run:
- Step c: Install and configure MariaDB on the DB Server.
- Step d: Create the database (kodekloud_db5), user (kodekloud_roy), and grant privileges on the DB Server using MariaDB.

Location
Both step c and step d commands are executed on the DB Server.

Do you need help with:
- Configuring MariaDB security on the DB Server?
- Testing database connectivity from an app server?
- Further WordPress configuration?

### Checking MariaDB Installation
To check if MariaDB is installed and its status:

Commands
- Check if MariaDB is installed:

bash
rpm -qa | grep mariadb

- Check MariaDB service status:

bash
sudo systemctl status mariadb


Expected Output
- If installed, you'll see MariaDB packages listed with rpm -qa.
- systemctl status will show if the MariaDB service is running or not.

Do you need help with:
- Starting MariaDB if not running?
- Troubleshooting MariaDB issues?
- MariaDB configuration?
