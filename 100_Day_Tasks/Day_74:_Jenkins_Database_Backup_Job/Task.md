### <ins>Task : Day 74: Jenkins Database Backup Job</ins>

There is a requirement to create a Jenkins job to automate the database backup. Below you can find more details to accomplish this task:

Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

Create a Jenkins job named database-backup.

Configure it to take a database dump of the kodekloud_db01 database present on the Database server in Stratos Datacenter, the database user is kodekloud_roy and password is asdfgdsd.

The dump should be named in db_$(date +%F).sql format, where date +%F is the current date.

Copy the db_$(date +%F).sql dump to the Backup Server under location /home/clint/db_backups.

Further, schedule this job to run periodically at */10 * * * * (please use this exact schedule format).

Note:

You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case please make sure to refresh the UI page.

Please make sure to define you cron expression like this */10 * * * * (this is just an example to run job every 10 minutes).

For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

### What I Did

Jenkins Database Backup Job Documentation

Table of Contents

- #prerequisites
- #step-1-install-required-plugins
- #step-2-create-remote-host-credentials
- #step-3-configure-ssh-remote-host-connection
- #step-4-establish-passwordless-authentication
- #step-5-create-a-jenkins-job
- #step-6-configure-build-periodically
- #step-7-configure-build-steps
- #step-8-build-and-test-the-job

Prerequisites

- Jenkins installed and running
- Database server and backup server set up

 #### Step 1: Install Required Plugins <ins>text</ins>

- Go to Manage Jenkins > Plugins > Available Plugins
- Search for "SSH" and install the following plugins:
    - SSH
    - SSH Credentials
    - SSH Build Agents
    - SSH Agents
    - Publish Over SSH
 
  <br><br>
<img width="1920" height="1080" alt="Screenshot (350)" src="https://github.com/user-attachments/assets/e13fa075-f32d-4a96-abce-15b951817321" />

  <br><br>
<br><br>
<img width="1920" height="1080" alt="Screenshot (351)" src="https://github.com/user-attachments/assets/5e517175-ff66-40e7-8d1e-89fd7f5171d3" />

<br><br>

#### Step 2: Create Remote Host Credentials

1. Go to Manage Jenkins > Credentials > System > Global credentials
2. Click Add Credentials
3. Select Username with password as the credential type
4. Fill in the details:
    - Username: Enter the username for your storage server (e.g., peter)
    - Password: Enter the password for the username
    - ID: Give a unique ID to the credential (optional but recommended)
5. Click OK to save the credential
<br><br>

<br><br>
#### Step 3: Configure SSH Remote Host Connection

1. Go to Manage Jenkins > System
2. Scroll down to "SSH remote hosts"
3. Click on Add
    - Host Name: stdb01.stratos.xfusioncorp.com/IP Address
    - Port: 22
    - Credentials: Select the credential name from the dropdown arrow (e.g., peter)
4. Click on the "Check Connection" button to confirm connection is established
<br><br>
<img width="1920" height="1080" alt="Screenshot (352)" src="https://github.com/user-attachments/assets/283ddf53-b689-4ce0-b0d4-18f615d34ea4" />
<br><br>


#### Step 4: Establish Passwordless Authentication between Database Server and Backup Server

To enable passwordless authentication between the Database Server and Backup Server, follow these steps:

Step 4.1: Access the Database Server
1. Login to the Jumphost: Open a terminal on the Jumphost server.
2. SSH into the Database Server: Run the command ssh peter@stdb01 to access the Database Server.

Step 4.2: Generate SSH Keys
1. Create SSH keys: Run the command ssh-keygen to generate a new SSH key pair on the Database Server.
    - Press Enter to accept the default file location and name for the key pair.
    - You can choose to enter a passphrase or leave it blank.

Step 4.3: Copy the Public Key to the Backup Server
1. Copy the public key: Run the command ssh-copy-id clint@stbkp01 to copy the public key to the Backup Server.
    - You will be prompted to enter the password for the Backup Server.

Step 4.4: Verify Passwordless Authentication
1. Test the connection: Run the command ssh clint@stbkp01 to connect to the Backup Server from the Database Server.
2. Verify passwordless login: If the public key has been successfully copied, you should be logged in to the Backup Server without being prompted for a password.
    - If you are prompted for a password, the key copy may not have been successful. Repeat the steps above to troubleshoot the issue.

By completing these steps, you have successfully established passwordless authentication between the Database Server and Backup Server.<br><br>
<img width="1920" height="1080" alt="Screenshot (348)" src="https://github.com/user-attachments/assets/ebbd5a12-5364-4bf1-bd52-96ae7ae878bf" />
<br><br>

#### Step 5: Create a Jenkins Job

1. Go to your Jenkins dashboard and click on New Item
2. Choose Freestyle project and name your job (e.g., "database-backup")
3. Click OK to create the job

#### Step 6: Configure Build Periodically

1. Go to the Job > Configure
2. Go to Triggers
3. Select Build periodically and enter "*/10 * * * *" in the Schedule box

<br><br>
<img width="1920" height="1080" alt="Screenshot (358)" src="https://github.com/user-attachments/assets/bfffe17f-2c48-4e8f-be2f-f61c749d2ab7" />
<br><br>

#### Step 7: Configure Build Steps

1. Select Execute shell script on remote host using ssh option
2. Configure SSH site: "peter@stdb01.stratos.xfusioncorp.com:22"
3. Enter the command: mysqldump -u kodekloud_roy -p'asdfgdsd' kodekloud_db01 > db_$(date +%F).sql scp -o StrictHostKeyChecking=no db_$(date +%F).sql clint@stbkp01:/home/clint/db_backups/
4. Save
<br><br>
<img width="1920" height="1080" alt="Screenshot (359)" src="https://github.com/user-attachments/assets/e3531c7c-5f63-4ac6-a792-6bcc51656aea" />
<br><br>

#### Step 8: Build and Test the Job

1. Go back to the Jenkins Job and click on "Build"
<br><br>
<img width="1920" height="1080" alt="Screenshot (356)" src="https://github.com/user-attachments/assets/1be70a09-a4bc-4afc-b303-6992056c1745" />
<br><br>

#### Verify the backup file creation:

1. Login to the Backup server: Access the terminal of the Backup server (stbkp01).
2. Navigate to the backup directory: Run the command cd /home/clint/db_backups/ to change into the directory where the backup files are stored.
3. List the files: Run the command ls to list the files in the directory.
4. Check for the backup file: Verify that a file with a name like db_<date>.sql (e.g., db_2024-10-04.sql) is present in the list.

By doing this, you can confirm that the Jenkins job successfully created a backup file on the Backup server.

If you want to test the job again:

1. Remove the existing backup file: Run the command rm db_<date>.sql (replace <date> with the actual date) to delete the existing backup file.
2. Trigger the Jenkins job again: Go back to the Jenkins dashboard and click on "Build" to run the job again.
3. Verify the new backup file: After the job completes, repeat the steps above to verify that a new backup file has been created.
