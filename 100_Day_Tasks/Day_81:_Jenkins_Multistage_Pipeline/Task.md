### Task : Jenkins Multistage Pipeline
The development team of xFusionCorp Industries is working on to develop a new static website and they are planning to deploy the same on Nautilus App Servers using Jenkins pipeline. They have shared their requirements with the DevOps team and accordingly we need to create a Jenkins pipeline job. Please find below more details about the task:



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.


Similarly, click on the Gitea button on the top bar to access the Gitea UI. Login using username sarah and password Sarah_pass123.


There is a repository named sarah/web in Gitea that is already cloned on Storage server under /var/www/html directory.


Update the content of the file index.html under the same repository to Welcome to xFusionCorp Industries and push the changes to the origin into the master branch.


Apache is already installed on all app Servers its running on port 8080.


Create a Jenkins pipeline job named deploy-job (it must not be a Multibranch pipeline job) and pipeline should have two stages Deploy and Test ( names are case sensitive ). Configure these stages as per details mentioned below.


a. The Deploy stage should deploy the code from web repository under /var/www/html on the Storage Server, as this location is already mounted to the document root /var/www/html of all app servers.


b. The Test stage should just test if the app is working fine and website is accessible. Its up to you how you design this stage to test it out, you can simply add a curl command as well to run a curl against the LBR URL (http://stlb01:8091) to see if the website is working or not. Make sure this stage fails in case the website/app is not working or if the Deploy stage fails.


Click on the App button on the top bar to see the latest changes you deployed. Please make sure the required content is loading on the main URL http://stlb01:8091 i.e there should not be a sub-directory like http://stlb01:8091/web etc.


Note:


You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case, please make sure to refresh the UI page.


For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.

### What i Did

### Jenkins Deployment Pipeline for xFusionCorp Static Website


This document details the configuration and pipeline code used to deploy a static website to Nautilus App Servers via a shared volume on the Storage Server, managed by a two-stage Jenkins pipeline.

**Note:-** The most robust and simplest solution relies entirely on setting up the Storage Server as an agent with the label ststor01, and then performing a local file copy in the pipeline.

🛠️ I. Pre-Deployment Setup (One-Time Steps)
These actions were performed before creating the Jenkins job.

1. Update Repository Content
The website content was updated directly on the Storage Server as it holds the local clone of the Git repository under the shared document root (/var/www/html).

Bash
```
# 1. SSH into the Storage Server (ststor01)
# User: natasha, Password: Bl@kW
ssh natasha@ststor01

cd /var/www/html

echo "Welcome to xFusionCorp Industries" > index.html
```
- Commit and push the changes to Gitea
```
git add index.html

git commit -am "Update welcome message for deployment"

# Credentials for push if required: sarah/Sarah_pass123

git push origin master
```
2. Jenkins Credentials Setup
3. 
The following Username/Password credentials were created in Jenkins:

Purpose         	  Username	  Password	        Recommended ID
Gitea Access	       sarah	   Sarah_pass123	 sarah
Storage Server SSH	   natasha	   Bl@kW	         storage_server


3. Configure Storage Server as Jenkins Agent or node
   
The Storage Server was set up as an agent (node) to allow the pipeline to execute shell commands directly on the server hosting the shared volume.

- Node Name: ststor01

- Labels: ststor01 (Crucial for the pipeline agent directive).

- Remote root directory: /home/natasha/jenkins_agent (Changed from /var/lib/jenkins to resolve permissions error).

- Launch Method: Launch agent via SSH.

- Credentials: Used the storage_server credential (natasha/Bl@kW).

⚠️ Agent Troubleshooting
Two main issues were resolved during agent setup:

Permission Denied: Resolved by changing the Remote root directory to a path owned by natasha (/home/natasha/jenkins_agent).


Java Not Found: Resolved by installing Java on the Storage Server (ststor01):
```
sudo yum install java-17-openjdk -y
```
Jenkins agents are Java applications and require the java command to be available for the connection to be established. 
The exit code 127 in the logs of launch Agent ,confirms that the shell could not find the executable (java).



4. Jenkins Pipeline Code (deploy-job)

A new Pipeline job named deploy-job was created with the following Declarative Pipeline script.

The pipeline uses the ststor01 agent and performs a local file copy (cp) to leverage the shared /var/www/html mount point, followed by a simple curl | grep test on the Load Balancer URL.

deploy-job Pipeline Script

```
pipeline {
    // Pipeline MUST run on the agent with the 'ststor01' label (Storage Server)
    agent { label 'ststor01' } 
    
    // Define environment variables
    environment {
        GITEA_CRED_ID = 'GITEA-SARAH' 
        INDEX_CONTENT = 'Welcome to xFusionCorp Industries'
    }
    
    stages {
        stage('Deploy') {
            steps {
                echo "1. Checking out code from Gitea into the workspace."
                
                // Checkout the latest master branch content
                git url: 'http://git.stratos.xfusioncorp.com/sarah/web.git',
                    credentialsId: env.GITEA_CRED_ID,
                    branch: 'master'
                
                echo "2. Copying files to the shared /var/www/html directory."
                // This local command copies files from the workspace to the document root, 
                // effectively deploying the code to ALL App Servers via the mount.
                sh 'cp -r * /var/www/html/'
            }
        }

        stage('Test') {
            steps {
                echo "Testing deployment via Load Balancer URL: http://stlb01:8091"
                
                // Curl the LBR URL and check for the required string.
                // The Load Balancer test confirms that the new content is being served
                // correctly by the App Servers.
                sh "curl -sS http://stlb01:8091 | grep -F \"\$INDEX_CONTENT\""
                
                echo "Test passed: New content is served successfully via LBR."
            }
        }
    }
}
```
📈 III. Verification
After running the pipeline:

Jenkins Result: The build job should show SUCCESS (green).

URL Verification: Accessing http://stlb01:8091 directly showed the required content:
Command : curl http://stlb01:8091
Output:
       Welcome to xFusionCorp Industries

This confirms that the website is accessible and serving the correct content through the Load Balancer URL http://stlb01:8091.

This Jenkins script is a **Declarative Pipeline** designed for a highly efficient Continuous Deployment (CD) workflow that leverages a **shared network volume**. The pipeline's logic is optimized to deploy code to multiple App Servers with a single file operation on a centralized **Storage Server**.


### Following is an elaborate explanation of each section and how the pipeline achieves the deployment goals.



## 1. Pipeline Foundation and Environment Setup
```
The top-level blocks define where and how the entire pipeline will run.

### `agent { label 'ststor01' }` (Execution Environment)

* **Function:** This directive instructs Jenkins to run the *entire* pipeline on a dedicated **Jenkins Agent** that has the label **`ststor01`** (the Storage Server).
* **Why it's crucial:** The task relies on the fact that all App Servers mount the **Storage Server's** `/var/www/html` directory. By running the job directly on `ststor01`, the script can access that `/var/www/html` directory locally, which is far simpler and faster than using remote $\text{SSH}/\text{SCP}$ commands.

### `environment { ... }` (Global Variables)

* **Function:** This section defines global, constant environment variables accessible throughout all stages of the pipeline.
* **`GITEA_CRED_ID = 'GITEA-SARAH'`:** Stores the ID of the Jenkins Credential (Username/Password for `sarah`) used to authenticate with the Git server (Gitea). This keeps sensitive information out of the main script body.
* **`INDEX_CONTENT = 'Welcome to xFusionCorp Industries'`:** Stores the exact string the website is expected to display. This variable is used in the `Test` stage for verification, making the test criteria clear and easy to modify.

---

## 2. Stage: `Deploy` (Code Transfer via Shared Volume)

This stage is responsible for fetching the latest website code and placing it into the live document root.

### `git url: ..., credentialsId: env.GITEA_CRED_ID, branch: 'master'`

* **Function:** This is the **Source Control Management (SCM)** step. It connects to the specified Gitea repository (`http://git.stratos.xfusioncorp.com/sarah/web.git`), authenticates using the stored credential ID (`env.GITEA_CRED_ID`), and checks out the latest commit from the **`master`** branch.
* **Location:** The code is downloaded and extracted into the Jenkins **workspace** on the `ststor01` agent (e.g., `/home/natasha/jenkins_agent/workspace/deploy-job`).

### `sh 'cp -r * /var/www/html/'` (The Deployment Action)

* **Function:** This is a **local shell command** (`sh`) that executes the core deployment logic.
* **Mechanism:** It copies (`cp -r`) all files (`*`) from the current directory (the Jenkins workspace) directly to the destination: **`/var/www/html/`**.
* **Result:** Because `/var/www/html` on the Storage Server is simultaneously mounted as the document root for all App Servers, **this single command instantly updates the website across the entire fleet.** This is the most efficient way to deploy in this specific architecture.

---

## 3. Stage: `Test` (Functional Verification)

This stage ensures the deployment was successful and the new content is live and accessible.

### `sh "curl -sS http://stlb01:8091 | grep -F \"\$INDEX_CONTENT\""`

* **Function:** This shell command verifies the application's availability and content integrity through the Load Balancer (LBR).
* **`curl -sS http://stlb01:8091`:** The `curl` command fetches the website content from the LBR's URL. The **`-sS`** flags are critical: **`-s`** makes the command quiet (silent), and **`-S`** ensures it still shows an error if the connection fails (e.g., LBR is down).
* **`| grep -F \"\$INDEX_CONTENT\"`:** The output of `curl` is piped to `grep`.
    * **`grep -F`** searches for the fixed string stored in the `INDEX_CONTENT` environment variable (`Welcome to xFusionCorp Industries`).
* **Failure Mechanism:** If the website is down, inaccessible, or serves incorrect content, the `grep` command will not find the required string and will exit with a **non-zero status code**. Jenkins interprets this non-zero exit code as a failure, causing the **entire `Test` stage, and thus the pipeline, to fail.** This fulfills the requirement that the stage must fail if the website isn't working correctly.
```








```
natasha@ststor01 ~]$ java --version
openjdk 17.0.16 2025-07-15 LTS
OpenJDK Runtime Environment (Red_Hat-17.0.16.0.8-1) (build 17.0.16+8-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-17.0.16.0.8-1) (build 17.0.16+8-LTS, mixed mode, sharing)
[natasha@ststor01 ~]$ history| cut -c 8-
# SSH into the Storage Server
ssh natasha@ststor01
cd /var/www/html
echo "Welcome to xFusionCorp Industries" > index.html
git add index.html
git commit -m "Updated index.html / Initial content update for deployment "
git push origin master
sudo mkdir -p /var/lib/jenkins
sudo chown natasha:natasha /var/lib/jenkins
cd~
cd ~
sudo mkdir -p /var/lib/jenkins
sudo chown natasha:natasha /var/lib/jenkins
sudo yum install java-17-openjdk -y
java --version
history| cut -c 8-
[natasha@ststor01 ~]$ 
```
