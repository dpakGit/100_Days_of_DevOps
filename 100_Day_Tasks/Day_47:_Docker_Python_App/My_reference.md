### Let's break down the task into steps and commands to complete it.

Task: Dockerize a Python app and deploy it on App Server 1.

Step 1: Create a Dockerfile

- Location: /python_app directory
- Command: vi Dockerfile (or use any text editor to create a new file named Dockerfile)

Dockerfile contents:
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
Let's explain what each line does:

- FROM python:3.9-slim: Uses the official Python 3.9 image as the base image.

- WORKDIR /app: Sets the working directory to /app in the container.

- COPY src/requirements.txt .: Copies the requirements.txt file from the src directory on the host machine to the working directory in the container.

- RUN pip install -r requirements.txt: Installs the dependencies listed in the requirements.txt file.

- COPY src/ /app/: Copies the application code from the src directory on the host machine to the working directory in the container.

- EXPOSE 5003: Exposes port 5003 from the container to the host machine.

- CMD ["python", "server.py"]: Runs the server.py script using the python command when the container starts.

Step 2: Build the Docker image

- Location: /python_app directory

- Command: docker build -t nautilus/python-app .

This command builds a Docker image named nautilus/python-app using the Dockerfile in the current directory.

Step 3: Create a Docker container

- Location: /python_app directory

- Command: docker run -d --name pythonapp_nautilus -p 8093:5003 nautilus/python-app

This command creates a Docker container named pythonapp_nautilus from the nautilus/python-app image and maps port 5003 of the container to port 8093 on the host machine. The -d flag runs the container in detached mode.

Step 4: Test the app

- Location: App Server 1

- Command: curl http://localhost:8093/

This command tests the app by sending a request to http://localhost:8093/ and displays the response.

That's it! You've successfully Dockerized the Python app and deployed it on App Server 1.


### Working Directory - WORKDIR 

In this case, you're copying files directly to the /app directory, and you're also running the server.py script from the same directory. So, setting the working directory using WORKDIR /app is not strictly necessary.

However, using WORKDIR /app provides a few benefits:

1. Avoids cluttering the root directory: By setting the working directory to /app, you ensure that any files or directories created during the build process or runtime are contained within the /app directory, rather than cluttering the root directory.
2. Simplifies file paths: When you set the working directory, you can use relative paths (e.g., COPY . .) instead of absolute paths (e.g., COPY . /app), which makes the Dockerfile easier to read and maintain.
3. Improves readability and maintainability: By explicitly setting the working directory, you make it clear to anyone reading the Dockerfile where the application code is located and where the container will be running.

If you prefer not to use WORKDIR /app, you can modify the Dockerfile to use absolute paths instead:

FROM python:3.9-slim

COPY src/requirements.txt /app/
RUN pip install -r /app/requirements.txt

COPY src/ /app/

EXPOSE 5003

CMD ["python", "/app/server.py"]

In this version, you're copying files directly to the /app directory and running the server.py script from the same directory.

Ultimately, whether to use WORKDIR /app or not depends on your personal preference and the specific requirements of your project. Both approaches are valid, and the Dockerfile will work either way.


### When you use WORKDIR /app in the Dockerfile, /app becomes the current working directory.

Any subsequent commands that use . as a reference will use /app as the directory.

So, in the Dockerfile:

WORKDIR /app
COPY src/requirements.txt .

The . in the COPY command refers to /app, which is the current working directory set by WORKDIR /app.

This means the requirements.txt file will be copied to /app in the container.

Here are some examples to illustrate this:

- WORKDIR /app sets the working directory to /app.
- COPY src/requirements.txt . copies requirements.txt to /app/requirements.txt.
- RUN ls . would list the files in /app.
- CMD ["python", "./server.py"] would run server.py from the /app directory.

By setting the working directory with WORKDIR, you can use relative paths (like .) in subsequent commands, which makes the Dockerfile more readable and easier to maintain.


### If you write WORKDIR . instead of WORKDIR /app, it will set the working directory to the root directory of the container (/).

In this case, the . refers to the current directory, which is the root directory (/) of the container's filesystem.

So, if you use WORKDIR ., your subsequent COPY commands would copy files to the root directory (/) instead of /app.

For example:

WORKDIR .
COPY src/requirements.txt .

This would copy requirements.txt to the root directory (/) of the container, instead of /app.

If you want to use a specific directory like /app, it's better to explicitly set it using WORKDIR /app. Using WORKDIR . would require you to use absolute paths for all subsequent commands, which can be less readable and more prone to errors.

In your case, since you're copying files to /app and running a script from /app, it's better to stick with WORKDIR /app to ensure that your files and script are in the correct location.


### When you set WORKDIR /app in a Dockerfile:

1. All subsequent commands will run in the /app directory.
2. Files copied using COPY or ADD will be copied to the /app directory (unless you specify a different destination).
3. Executable files (like scripts or binaries) should be placed inside the /app directory if you want to run them using relative paths.

By setting WORKDIR /app, you're essentially making /app the working directory for your container. This means:

- When you run CMD ["python", "server.py"], Docker will look for server.py in the /app directory.
- When you copy files using COPY src/ ., the files will be copied to the /app directory.

It's not strictly necessary to put all executable files inside /app, but it's a good practice to keep related files and scripts organized within a single directory. This makes it easier to manage and maintain your container.

Some benefits of using WORKDIR /app include:

- Simplified file paths: You can use relative paths (like .) instead of absolute paths (like /app).
- Better organization: Your application files and scripts are contained within a single directory.
- Easier maintenance: It's clear where your application files are located, making it easier to update or modify them.

By setting WORKDIR /app, you're creating a clear and organized structure for your container, which can make it easier to manage and maintain your application.


### When I said "All subsequent commands will run in the /app directory", I meant that all subsequent commands in the Dockerfile will run in the /app directory.

This includes commands like:

- RUN
- COPY
- CMD

When you set WORKDIR /app in the Dockerfile, it affects the build process. During the build process, Docker will execute the commands in the Dockerfile, and the working directory will be /app for all subsequent commands.

However, when the container is running, the working directory is still /app, and any commands specified in the CMD or ENTRYPOINT instructions will run in the /app directory.

So, to clarify:

- During the build process (when running docker build), WORKDIR /app sets the working directory for subsequent commands in the Dockerfile.
- When the container is running (after docker run), the working directory is still /app, and any commands specified in CMD or ENTRYPOINT will run in /app.


### If you write WORKDIR . instead of WORKDIR /app, it will set the working directory to the root directory of the container (/).

In this case, the . refers to the current directory, which is the root directory (/) of the container's filesystem.

So, if you use WORKDIR ., your subsequent COPY commands would copy files to the root directory (/) instead of /app.

For example:

WORKDIR .
COPY src/requirements.txt .

This would copy requirements.txt to the root directory (/) of the container, instead of /app.

If you want to use a specific directory like /app, it's better to explicitly set it using WORKDIR /app. Using WORKDIR . would require you to use absolute paths for all subsequent commands, which can be less readable and more prone to errors.

In your case, since you're copying files to /app and running a script from /app, it's better to stick with WORKDIR /app to ensure that your files and script are in the correct location.


### "." and Copy command

### In the COPY command:

COPY src/requirements.txt .

The . refers to the current working directory in the container.

When you use WORKDIR /app earlier in the Dockerfile:

WORKDIR /app

You're setting the current working directory to /app.

So, when you use COPY src/requirements.txt ., it means:

- src/requirements.txt is the source file on the host machine (relative to the Dockerfile's location).
- . is the destination directory in the container, which is /app (because of the WORKDIR /app command).

Therefore, the COPY command copies the requirements.txt file from the src directory on the host machine to the /app directory in the container.

If you didn't use WORKDIR /app, you would need to specify the absolute path /app as the destination:

COPY src/requirements.txt /app/

But with WORKDIR /app, the . shorthand makes it easier to copy files to the current working directory.

### In the COPY command in a Dockerfile:

COPY src/requirements.txt .

The . represents the destination directory in the container.

In this case, the requirements.txt file will be copied from the src directory on the host machine to the current working directory (.) in the container.

If you've set the working directory using WORKDIR /app, then . would represent /app. If you haven't set a working directory, . would represent the root directory /.

So, to break it down:

- src/requirements.txt is the source file on the host machine.
- . is the destination directory in the container.

By using . as the destination, you're telling Docker to copy the file to the current working directory in the container.


### This COPY command copies the contents of the src/ directory on the host machine to the /app/ directory in the container.

Here's a breakdown:

- src/ is the source directory on the host machine, relative to the Dockerfile's location.
- /app/ is the destination directory in the container.

When you use this command, the contents of src/ will be copied to /app/, preserving the directory structure.

For example, if your src/ directory has the following structure:

src/
requirements.txt
server.py
utils/
helper.py

The /app/ directory in the container will have the same structure:

/app/
requirements.txt
server.py
utils/
helper.py

This command is useful for copying application code or other files into the container. Just make sure that the /app/ directory exists in the container or is created earlier in the Dockerfile (e.g., using WORKDIR /app).

In your case, since you've already set WORKDIR /app, you could also use:

COPY src/ .

This would achieve the same result, copying the contents of src/ to the current working directory (/app/).

### Q: which one to use - CMD ["python", "server.py"] or CMD ["python", "/app/server.py"] or CMD ["python", "./server.py"] ?

- The choice between these three CMD options depends on the working directory and the location of the server.py file in the container.

Let's assume you've set the working directory to /app using WORKDIR /app and the server.py file is located in the /app directory.

Here's what each option does:

1. CMD ["python", "server.py"]:
    - This will run python server.py in the current working directory (/app).
    - This is a good option if the server.py file is in the /app directory.
2. CMD ["python", "/app/server.py"]:
    - This will run python /app/server.py, specifying the absolute path to the server.py file.
    - This will work, but it's not necessary if you've already set the working directory to /app.
3. CMD ["python", "./server.py"]:
    - This will run python ./server.py in the current working directory (/app).
    - The ./ notation refers to the current working directory, so this is equivalent to CMD ["python", "server.py"].
    - This will work, and it's a good option if you want to explicitly specify that the server.py file is in the current working directory.

Based on this, I would recommend using:

CMD ["python", "server.py"]

This is a simple and straightforward option that takes advantage of the working directory set by WORKDIR /app. As long as the server.py file is in the /app directory, this will work as expected.


###  Let's break down the command: CMD ["python", "server.py"]

This is a Dockerfile command that specifies the default command to run when the container is started.

Here's what each part does:

- CMD: This is the Dockerfile instruction that sets the default command for the container.
- ["python", "server.py"]: This is the command to run, specified as a JSON array.
    - python: This is the executable to run, which in this case is the Python interpreter.
    - server.py: This is the argument passed to the python executable, which is the Python script to run.

When the container is started, Docker will run the command python server.py by default. This will execute the server.py script using the Python interpreter.

Using a JSON array ["python", "server.py"] instead of a string "python server.py" has some benefits:

- It allows Docker to pass the command and arguments to the container's entrypoint without shell interpretation.
- It makes it clear what the command and arguments are, without any potential shell escaping issues.

Overall, this CMD instruction tells Docker to run the server.py script using Python when the container is started.


### The line CMD ["python", "server.py"] is a Dockerfile instruction that specifies the default command to run when a container is started from the image.

Here's a breakdown:

- CMD: This is the instruction in the Dockerfile that sets the default command for the container.
- ["python", "server.py"]: This is the command to be executed, specified as a JSON array. The array contains two elements:
    1. python: This is the command to run, which is the Python interpreter.
    2. server.py: This is the argument passed to the python command, which is the Python script to execute.

When a container is started from the image, Docker will run the command python server.py by default. This will execute the server.py script using the Python interpreter.

Some key points about CMD:

- There can be only one CMD instruction in a Dockerfile. If there are multiple CMD instructions, only the last one will take effect.
- The CMD instruction can be overridden when running the container using the docker run command. For example: docker run myimage python another_script.py

The benefits of using the JSON array format ["python", "server.py"] instead of a string "python server.py" include:

- Avoiding shell processing and potential security issues
- Making it clear what the command and arguments are
- Allowing for easier modification of the command and arguments when running the container

Overall, CMD ["python", "server.py"] specifies the default command to run when a container is started, which in this case is executing the server.py script using Python.


### In the command CMD ["python", "server.py"], python is the executable or command that will be run.

In this case, python refers to the Python interpreter, which is a program that runs Python scripts. When the container is started, Docker will execute the python command and pass server.py as an argument to it.

The python executable will then:

1. Load the Python interpreter
2. Execute the server.py script

In other words, python is the program that will run the server.py script.

You can think of it like this:

- python is the command (the executable that runs Python)
- server.py is the argument (the script that will be executed by the Python interpreter)

By specifying python as the executable, you're telling Docker to use the Python interpreter to run the server.py script.


### 
