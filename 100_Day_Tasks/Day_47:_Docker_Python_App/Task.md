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

```
thor@jumphost ~$ ssh tony@stapp01

[tony@stapp01 ~]$ sudo -s

[root@stapp01 tony]# pwd
/home/tony

[root@stapp01 tony]# ls

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

[root@stapp01 python_app]# docker images

REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
nautilus/python-app   latest    c7c4437ed52d   14 seconds ago   132MB


[root@stapp01 python_app]# docker run -d --name pythonapp_nautilus -p 8093:5003 nautilus/python-app

7a225968f1b052b9ea752023f185c3668c564991aae5422322472129baa71c77

[root@stapp01 python_app]# docker ps -a

CONTAINER ID   IMAGE                 COMMAND              CREATED         STATUS         PORTS                    NAMES
7a225968f1b0   nautilus/python-app   "python server.py"   8 seconds ago   Up 6 seconds   0.0.0.0:8093->5003/tcp   pythonapp_nautilus

[root@stapp01 python_app]# curl http://localhost:8093/

Welcome to xFusionCorp Industries
```

### # File server.py
```
from flask import Flask

# the all-important app variable:
app = Flask(__name__)

@app.route("/")
def hello():
    return "Welcome to xFusionCorp Industries!"

if __name__ == "__main__":
        app.config['TEMPLATES_AUTO_RELOAD'] = True
        app.run(host='0.0.0.0', debug=True, port=5003)
```

### # Dockerfile 

```
# Use an official Python image as the base image
FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY src/requirements.txt .

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the application code to the working directory
COPY src/ /app/

# Expose port 5003
EXPOSE 5003

# Run the server.py script using CMD
CMD ["python", "server.py"]
```

```
[root@stapp01 python_app]# history | cut -c 8-
ls
pwd
cd /python_app/src/
ls
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
```
