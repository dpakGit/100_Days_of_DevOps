## Task:
#### Breakdown the following task pointwise - Give me a clear and elaborate explanation of the steps to be performed to accomplish the following task - The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 3 in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:

1. Install and configure nginx on App Server 2.

2. On App Server 3 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.

3. Create an index.html file with content Welcome! under Nginx document root.

4. For final testing try to access the App Server 3 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.

------------------------------------------------

- https://tundedamian.medium.com/day-15-of-100-days-of-devops-securing-web-access-with-nginx-and-ssl-a14bf3a32acb

----------------------------


#### Task Breakdown:

✅ Task Overview

SSH to App Server 2

Install and configure NGINX on a remote server.

Deploy a self-signed SSL certificate and key for secure access.

Set up a secure server block to serve a simple HTML page.

Validate HTTPS access from a jump host.


### What I Did
----------------------------------------
thor@jumphost ~$ ssh steve@stapp02

[steve@stapp02 conf.d]$ 
```
sudo yum install -y nginx
sudo systemctl enable --now nginx
systemctl list-units --type=service | grep nginx
sudo systemctl start nginx
sudo systemctl status nginx
sudo mkdir -p /etc/nginx/ssl
sudo mv /tmp/nautilus.crt /etc/nginx/ssl/
sudo mv /tmp/nautilus.key /etc/nginx/ssl/
ls /etc/nginx/
cd /etc/nginx/
ls
cd conf.d/
ls
# This folder or directory conf.d is empty

sudo tee /etc/nginx/conf.d/nautilus.conf << 'EOF'
server {
    listen 443 ssl;
    server_name _;
    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF


ls /etc/nginx/conf.d/
cat /etc/nginx/conf.d/nautilus.conf 
echo 'Welcome!' | sudo tee /usr/share/nginx/html/index.html
sudo nginx -t
sudo systemctl reload nginx
history |cut -c 8-
```
[steve@stapp02 conf.d]$ 

thor@jumphost ~$ curl -Ik https://172.16.238.11/
Output of the curl command:
```
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Wed, 13 Aug 2025 05:33:21 GMT
Content-Type: text/html
Content-Length: 9
Last-Modified: Wed, 13 Aug 2025 05:28:25 GMT
Connection: keep-alive
ETag: "689c2279-9"
Accept-Ranges: bytes
```

**Note:** V.V Important

##### Where to Write the Nginx Server Config

Changing Nginx Config Files
- Main config file: /etc/nginx/nginx.conf.
- Default site config: Often in /etc/nginx/sites-available/default or configs in /etc/nginx/conf.d/.
- Recommendation:
    - Add custom configs in /etc/nginx/conf.d/ (like nautilus.conf).
    - Avoid editing nginx.conf unless you need to change main Nginx settings.

*Why Use /etc/nginx/conf.d/*
- Easier to manage separate config files per site/app.
- Nginx includes all .conf files in conf.d/ by default.

Do you need help with:
- Creating configs in conf.d/?
- Managing multiple Nginx sites?
- Testing Nginx configs for errors?

- Best place: Write the config in a file under /etc/nginx/conf.d/ (e.g., nautilus.conf).

```
bash
sudo tee /etc/nginx/conf.d/nautilus.conf << 'EOF'
server {
    listen 443 ssl;
    server_name _;
    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF
```
- Why:
    - /etc/nginx/conf.d/ is for custom configs.
    - Keeps nginx.conf clean for main settings.

Other Files
- nginx.conf: Main Nginx config. Avoid editing unless needed.
- nginx.conf.default: Likely a backup or example. Don't use for active config.

--------------------------------------------

#### MetaAI

#### Steps to Prepare App Server 3 for Application Deployment

The task involves preparing App Server 3 in Stratos Datacenter for deploying a new application by installing and configuring Nginx with a self-signed SSL certificate.

Step 1: Install and Configure Nginx on App Server 3
- SSH into App Server 3.
- Install Nginx using the package manager (e.g., yum install nginx or apt install nginx).
- Start and enable Nginx (systemctl start nginx, systemctl enable nginx).

Step 2: Move SSL Certificate and Key and Deploy in Nginx
- Move the self-signed SSL certificate and key to a standard location like /etc/nginx/ssl/:

bash
mkdir -p /etc/nginx/ssl/
mv /tmp/nautilus.crt /etc/nginx/ssl/
mv /tmp/nautilus.key /etc/nginx/ssl/

**Moving SSL Certificate and Key to Nginx SSL Directory**
The commands:

- Create the /etc/nginx/ssl/ directory if it doesn't exist.

- Move the self-signed SSL certificate (nautilus.crt) and key (nautilus.key) from /tmp/ to /etc/nginx/ssl/.

- Purpose
- This makes the certificate and key available for configuring Nginx to use SSL/TLS on App Server 3.

### Using the Nginx Configuration Snippet
- Configure Nginx to use these SSL files in the Nginx configuration (/etc/nginx/nginx.conf or a site-specific config).
- Example SSL config in Nginx:

- Configures Nginx to:
    - Listen on port 443 with SSL enabled.
    - Use the self-signed SSL certificate and key from /etc/nginx/ssl/.
    - Serve files from the document root /usr/share/nginx/html.
    - Serve index.html by default.


nginx
server {
    listen 443 ssl;
    server_name _;
    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}


*Step 3: Create index.html Under Nginx Document Root*
- Create index.html with content "Welcome!" in the Nginx document root (often /usr/share/nginx/html):

bash
echo "Welcome!" > /usr/share/nginx/html/index.html


Step 4: Test Access from Jump Host
- From the jump host, use curl to test access to App Server 3 via HTTPS:

bash
curl -Ik https://<app-server-3-ip>/

- Should show HTTP response headers indicating a successful HTTPS connection.


**Note:**

#### SSL Certificate and Key Being Moved and Deployed in Nginx
In the given task description, we are moving and deploying the SSL certificate (nautilus.crt) and key (nautilus.key) that are present on App Server 3 at location:
- /tmp/nautilus.crt (certificate)
- /tmp/nautilus.key (key)

We are moving these to /etc/nginx/ssl/ and configuring Nginx on App Server 3 to use them for SSL/TLS.


--------------------------------------------------

##### Note:

*Using sudo tee to Create Nginx Config*
- sudo tee /etc/nginx/conf.d/nautilus.conf << 'EOF':
    - Creates a new file /etc/nginx/conf.d/nautilus.conf.
    - Writes content between EOF markers to this file with sudo privileges.
- Common way to create config files in protected directories like /etc/nginx.

Example Usage
You'd follow this with the config content, like:

bash
sudo tee /etc/nginx/conf.d/nautilus.conf << 'EOF'
server {
    listen 443 ssl;
    server_name _;
    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;
    root /usr/share/nginx/html;
    index index.html;
}
EOF



*Use of EOF in tee Command*
- *EOF* (End Of File):
    - Used in a heredoc (<< 'EOF') to mark the beginning and end of input.
    - Everything between << 'EOF' and EOF is treated as input to the command (tee here).
- Allows you to write multiline content to a file without needing to escape characters or use multiple echo commands.

Example

bash
sudo tee /etc/nginx/conf.d/nautilus.conf << 'EOF'
server {
    listen 443 ssl;
    server_name _;
}
EOF

- Writes the server block to /etc/nginx/conf.d/nautilus.conf.

Do you need help with:
- Using heredocs for other commands?
- Writing complex configs to files?
- Working with multiline strings in bash?


