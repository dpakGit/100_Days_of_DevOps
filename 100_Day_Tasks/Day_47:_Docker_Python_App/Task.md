### Task:

A python app needed to be Dockerized, and then it needs to be deployed on App Server 1. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 1. Further complete this task as per details mentioned below:

Create a Dockerfile under /python_app directory:

- Use any python image as the base image.

- Install the dependencies using requirements.txt file.

- Expose the port 5003.

- Run the server.py script using CMD.

- Build an image named nautilus/python-app using this Dockerfile.

- Once image is built, create a container named pythonapp_nautilus:

- Map port 5003 of the container to the host port 8093.

- Once deployed, you can test the app using curl command on App Server 1.

curl http://localhost:8093/

--------------------------------------------------------------------------

### What I Did

thor@jumphost ~$ ssh tony@stapp01

[tony@stapp01 ~]$ sudo -s

[root@stapp01 tony]# ls

[root@stapp01 tony]# pwd
/home/tony

[root@stapp01 tony]# cd /python_app/src/

[root@stapp01 src]# pwd
/python_app/src

[root@stapp01 src]# ls
requirements.txt  server.py

[root@stapp01 src]# cat requirements.txt 
flask

[root@stapp01 src]# cat server.py 

# Following is the python code inside the file server.py
from flask import Flask

# the all-important app variable:
app = Flask(__name__)

@app.route("/")
def hello():
    return "Welcome to xFusionCorp Industries!"

if __name__ == "__main__":
        app.config['TEMPLATES_AUTO_RELOAD'] = True
        app.run(host='0.0.0.0', debug=True, port=5003)
        
        
[root@stapp01 src]# pwd
/python_app/src

[root@stapp01 src]# cd ..

[root@stapp01 python_app]# pwd
/python_app

[root@stapp01 python_app]# vi Dockerfile

[root@stapp01 python_app]# docker build -t nautilus/python-app .
[+] Building 190.6s (10/10) FINISHED                      docker:default
 => [internal] load build definition from Dockerfile                0.0s
 => => transferring dockerfile: 479B                                0.0s
 => [internal] load metadata for docker.io/library/python:3.9-sl  121.5s
 => [internal] load .dockerignore                                   0.0s
 => => transferring context: 2B                                     0.0s
 => [1/5] FROM docker.io/library/python:3.9-slim@sha256:914169c7c  61.3s
 => => resolve docker.io/library/python:3.9-slim@sha256:914169c7c8  0.0s
 => => sha256:396b1da7636e2dcd10565cb4f2f952cbb 29.77MB / 29.77MB  30.5s
 => => sha256:0219e1e5e6ef3ef9d91f78826576a112b1c 1.29MB / 1.29MB  30.6s
 => => sha256:5ec99fe17015e703c289d110b020e4e36 13.37MB / 13.37MB  30.9s
 => => sha256:914169c7c8398b1b90c0b0ff921c802744 10.36kB / 10.36kB  0.0s
 => => sha256:213766eae7e1ad5da6140428e7f15db89f2c 1.74kB / 1.74kB  0.0s
 => => sha256:28f8802246faa922c08dd76e3ec467e3cb42 5.30kB / 5.30kB  0.0s
 => => extracting sha256:396b1da7636e2dcd10565cb4f2f952cbb4a8a38b5  2.0s
 => => sha256:ea3499df304f0a84e9f076a05f0cfe2a64d8fcb 249B / 249B  60.8s
 => => extracting sha256:0219e1e5e6ef3ef9d91f78826576a112b1c20622c  0.4s
 => => extracting sha256:5ec99fe17015e703c289d110b020e4e362d5b425b  1.1s
 => => extracting sha256:ea3499df304f0a84e9f076a05f0cfe2a64d8fcb88  0.4s
 => [internal] load build context                                   0.0s
 => => transferring context: 401B                                   0.0s
 => [2/5] WORKDIR /app                                              0.4s
 => [3/5] COPY src/requirements.txt .                               0.6s
 => [4/5] RUN pip install -r requirements.txt                       4.9s
 => [5/5] COPY src/ /app/                                           0.8s
 => exporting to image                                              1.1s
 => => exporting layers                                             1.1s
 => => writing image sha256:c7c4437ed52ddcbc1a7e5fc1d5900f920fdfda  0.0s
 => => naming to docker.io/nautilus/python-app                      0.0s
[root@stapp01 python_app]# docker images
REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
nautilus/python-app   latest    c7c4437ed52d   14 seconds ago   132MB
[root@stapp01 python_app]# docker run -d --name pythonapp_nautilus -p 8093:5003 nautilus/python-app
7a225968f1b052b9ea752023f185c3668c564991aae5422322472129baa71c77
[root@stapp01 python_app]# docker ps -a
CONTAINER ID   IMAGE                 COMMAND              CREATED         STATUS         PORTS                    NAMES
7a225968f1b0   nautilus/python-app   "python server.py"   8 seconds ago   Up 6 seconds   0.0.0.0:8093->5003/tcp   pythonapp_nautilus
[root@stapp01 python_app]# curl http://localhost:8093/
Welcome to xFusionCorp Industries![root@stapp01 python_app]# 
[root@stapp01 python_app]# 
[root@stapp01 python_app]# 
[root@stapp01 python_app]# curl http://localhost:8093/
Welcome to xFusionCorp Industries![root@stapp01 python_app]# 
[root@stapp01 python_app]# History | cut -c 8-
bash: History: command not found
[root@stapp01 python_app]# history | cut -c 8-
ls
pwd
cd /python_app/src/
ls
cat requirements.txt 
cat requirements.txt 
vi requirements.txt 
cat server.py 
pwd
cd ..
pwd
vi Dockerfile
docker build -t nautilus/python-app .
docker images
docker run -d --name pythonapp_nautilus -p 8093:5003 nautilus/python-app
docker ps -a
curl http://localhost:8093/
curl http://localhost:8093/
History | cut -c 8-
history | cut -c 8-
[root@stapp01 python_app]# 
