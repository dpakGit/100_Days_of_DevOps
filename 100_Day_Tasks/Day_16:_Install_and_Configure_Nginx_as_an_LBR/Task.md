## Task:
#### Day by day traffic is increasing on one of the websites managed by the Nautilus production support team. Therefore, the team has observed a degradation in website performance. Following discussions about this issue, the team has decided to deploy this application on a high availability stack i.e on Nautilus infra in Stratos DC. They started the migration last month and it is almost done, as only the LBR server configuration is pending. Configure LBR server as per the information given below:



a. Install nginx on LBR (load balancer) server.


b. Configure load-balancing with the an http context making use of all App Servers. Ensure that you update only the main Nginx configuration file located at /etc/nginx/nginx.conf.


c. Make sure you do not update the apache port that is already defined in the apache configuration on all app servers, also make sure apache service is up and running on all app servers.


d. Once done, you can access the website using StaticApp button on the top bar.

-------------------------------
https://tundedamian.medium.com/day-16-of-100-days-of-devops-nginx-load-balancer-setup-in-a-high-availability-environment-b2080969d6be

---------------------------------

### What I Did

```
[loki@stlb01 ~]$ 

sudo yum install -y nginx

sudo systemctl enable nginx

sudo systemctl start nginx

sudo systemctl status nginx

sudo vi /etc/nginx/nginx.conf

sudo nginx -t

sudo systemctl reload nginx

curl http://stapp01

curl http://stapp01:3002

curl http://stapp02:3002

curl http://stapp03:3002

[loki@stlb01 ~]$ cat  /etc/nginx/nginx.conf

------------------------------------------------------------
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

# -------------------- New Configuration added ----------------------------
    upstream app_servers {
server stapp01.stratos.xfusioncorp.com:3002; # Change this port to the one on which Apache is running in all the three App Servers
server stapp02.stratos.xfusioncorp.com:3002;
server stapp03.stratos.xfusioncorp.com:3002;
}
server {
listen 80; # "Avoid using a port that conflicts with other ports in the configuration file by changing it to a unique port number."
listen [::]:80;
server_name _;
location / {
proxy_pass http://app_servers;
}
error_page 404 /404.html;
location = /404.html {}
error_page 500 502 503 504 /50x.html;
location = /50x.html {}
}
# ---------------------------------------------------------
# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}

```

#### Note: I removed the default configuration completely and in that place added the new one

```
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

### Screenshots:

Clicking on the StaticApp button redirects to the below page with the following message:

<img width="1920" height="1080" alt="Screenshot (93)" src="https://github.com/user-attachments/assets/3879d425-4abf-41ec-8467-b183a07cc1bf" />





