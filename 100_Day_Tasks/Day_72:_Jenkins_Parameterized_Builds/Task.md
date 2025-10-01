### Task :Day 72: Jenkins Parameterized Builds

A new DevOps Engineer has joined the team and he will be assigned some Jenkins related tasks. Before that, the team wanted to test a simple parameterized job to understand basic functionality of parameterized builds. He is given a simple parameterized job to build in Jenkins. Please find more details below:



Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.


1. Create a parameterized job which should be named as parameterized-job


2. Add a string parameter named Stage; its default value should be Build.


3. Add a choice parameter named env; its choices should be Development, Staging and Production.


4. Configure job to execute a shell command, which should echo both parameter values (you are passing in the job).


5. Build the Jenkins job at least once with choice parameter value Development to make sure it passes.


Note:

1. You might need to install some plugins and restart Jenkins service. So, we recommend clicking on Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre. Also, Jenkins UI sometimes gets stuck when Jenkins service restarts in the back end. In this case, please make sure to refresh the UI page.


2. For these kind of scenarios requiring changes to be done in a web UI, please take screenshots so that you can share it with us for review in case your task is marked incomplete. You may also consider using a screen recording software such as loom.com to record and share your work.


### What I Did

To create a parameterized job in Jenkins, follow these steps:

Step 1: Access Jenkins UI and Login

- Click on the Jenkins button on the top bar to access the Jenkins UI.
- Login using username admin and password Adm!n321.

Step 2: Create a Parameterized Job

- Click on New Item in the Jenkins dashboard.
- Enter parameterized-job as the job name and select Freestyle project.
- Click OK to create the job.

Step 3: Add String Parameter

- In the job configuration page, click on This project is parameterized.
- Click on Add Parameter and select String Parameter.
- Enter `Stage` as the parameter name and `Build` as the default value.

<img width="1920" height="1080" alt="Screenshot (296)" src="https://github.com/user-attachments/assets/1533fb43-dd84-428b-8f4a-8e2dbeacade1" />



Step 4: Add Choice Parameter

- Click on Add Parameter and select Choice Parameter.
- Enter env as the parameter name.
- Enter the following choices:
    - Development
    - Staging
    - Production
 
  <img width="1920" height="1080" alt="Screenshot (297)" src="https://github.com/user-attachments/assets/6b18f345-5b6c-4418-a495-6372ff0c7436" />


Step 5: Configure Shell Command

- In the job configuration page, scroll down to the Build section.
- Click on Add build step and select Execute shell.
- Enter the following shell command: echo "Stage: $Stage" && echo "Environment: $env"

<img width="1920" height="1080" alt="Screenshot (298)" src="https://github.com/user-attachments/assets/89e5efc0-d3c0-4226-839e-b00e0345b0ca" />


Step 6: Build the Job

- Click on Save to save the job configuration.
- Click on Build with Parameters to build the job.
- Select Development as the environment value and click Build.

Make sure to take screenshots or record your work using a screen recording software like loom.com for review purposes. If you encounter any issues with plugins, restart Jenkins and refresh the UI page.

<img width="1920" height="1080" alt="Screenshot (292)" src="https://github.com/user-attachments/assets/e98bfcf5-71cc-42b8-aa56-d0694adc7d23" />


<img width="1920" height="1080" alt="Screenshot (293)" src="https://github.com/user-attachments/assets/3bb49c05-ccd5-460c-b307-e09e33ddb08d" />

<img width="1920" height="1080" alt="Screenshot (294)" src="https://github.com/user-attachments/assets/3e3f2e93-373e-4c4c-b3df-e2dc99b7bb77" />

