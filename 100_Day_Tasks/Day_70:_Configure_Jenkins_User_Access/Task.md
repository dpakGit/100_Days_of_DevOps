### Task : Day 70: Configure Jenkins User Access

The Nautilus team is integrating Jenkins into their CI/CD pipelines. After setting up a new Jenkins server, they're now configuring user access for the development team, Follow these steps:

1. Click on the Jenkins button on the top bar to access the Jenkins UI. Login with username admin and password Adm!n321.

2. Create a jenkins user named jim with the passwordYchZHRcLkL. Their full name should match Jim.

3. Utilize the Project-based Matrix Authorization Strategy to assign overall read permission to the jim user.

4. Remove all permissions for Anonymous users (if any) ensuring that the admin user retains overall Administer permissions.

5. For the existing job, grant jim user only read permissions, disregarding other permissions such as Agent, SCM etc.

Note:

1. You may need to install plugins and restart Jenkins service. After plugins installation, select Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page.


2. After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding. Avoid clicking Finish immediately after restarting the service.


3. Capture screenshots of your configuration for review purposes. Consider using screen recording software like loom.com for documentation and sharing.


### What I Did


Here's a detailed step-by-step guide to configuring user access for the development team in Jenkins:

Step 1: Access Jenkins UI and Login

1. Click on the Jenkins button on the top bar to access the Jenkins UI.
2. Enter the username admin and password Adm!n321 to log in to Jenkins.


<img width="1920" height="1080" alt="Screenshot (289)" src="https://github.com/user-attachments/assets/e79952fe-560d-445e-8fd6-4080aa10d0d8" />

<img width="1920" height="1080" alt="Screenshot (250)" src="https://github.com/user-attachments/assets/c3562d4e-78be-4c4f-b0ba-dd1b351318f7" />

Step 2: Create a New User - Anita

1. Click on Manage Jenkins on the left-hand side menu.
2. Click on Security.
3. Click on Users.
4. Click on Create User.
5. Enter the following details:
    - Username: anita
    - Password: TmPcZjtRQx
    - Full name: Anita
    - Email address: (optional)
6. Click Create User to create the new user.

<img width="1920" height="1080" alt="Screenshot (251)" src="https://github.com/user-attachments/assets/327f6755-524a-4a10-80ad-ab4cc7b8dee1" />


Step 3: Configure Project-based Matrix Authorization Strategy

1. Click on Manage Jenkins on the left-hand side menu.
2. Click on Security.
3. Look for the Authorization section.

 - Here in my case i could not find the "Project-based Matrix Authorization Strategy"  in the Authorisation box.
<img width="1920" height="1080" alt="Screenshot (268)" src="https://github.com/user-attachments/assets/818849c7-f6d3-48c7-8b3d-334c25482574" />

So went to the plugins section in the Manage Jenkins, 
Under Installed Plugins it was missing,so i went to the Available Plugins and in the serch bar searched for "Matrix Authorization Strategy",

<img width="1920" height="1080" alt="Screenshot (270)" src="https://github.com/user-attachments/assets/4c2198f0-2235-4837-9d12-c8628f86694e" />

checked the option and installed it.
After successful installation restarted jenkins.

Note : - The plugin name is "Matrix Authorization Strategy"

4. Again go to the security section and this time I found the option "Project-based Matrix Authorization Strategy"
<img width="1920" height="1080" alt="Screenshot (271)" src="https://github.com/user-attachments/assets/e155e9ec-20a6-4887-abcc-f42011d8e205" />

5. Select Project-based Matrix Authorization Strategy.

6. Click Add User and enter anita in the text box.
7. In the matrix, find the Overall section and check the box for Read permission for the anita user.
   Used Anita not Jim

<img width="1920" height="1080" alt="Screenshot (272)" src="https://github.com/user-attachments/assets/2a619307-1782-494f-ab40-f8abf94bb71f" />

8. Click Save to apply the changes.

Step 4: Remove Anonymous User Permissions

1. In the same Authorization section, find the Anonymous user.
2. Uncheck all permissions for the Anonymous user, except for any permissions that are required for your Jenkins instance.
3. Ensure that the admin user still has Overall Administer permissions.
4. Click Save to apply the changes.

<img width="1920" height="1080" alt="Screenshot (272)" src="https://github.com/user-attachments/assets/fe85bca8-24f7-45a4-b3fd-75c003d3424a" />

Removed all anonymous permissions

Step 5: Grant Read Permissions to Anita for Existing Job

Go back to the dashboard

1. Click on the job for which you want to grant read permissions to Anita.
2. Click on Configure.
3. Look for the Enable project-based security option in the General page and check it.. 

<img width="1920" height="1080" alt="Screenshot (286)" src="https://github.com/user-attachments/assets/b8db5834-aa68-4101-96db-3eafea75dca0" />

4. In the Permission Matrix, find the anita user and check the box for Read permission.

In my case I could not find user Anita so I added it and checked the box for Read permission:

<img width="1920" height="1080" alt="Screenshot (288)" src="https://github.com/user-attachments/assets/05a2f2e3-cae5-4456-bc32-d3661d322359" />

6. Make sure no other permissions (such as Build, Cancel, etc.) are checked for Anita.

7. Click Save to apply the changes.


Following steps ensure now I am able to configure user access for the development team in Jenkins and grant read permissions to the Anita user.

Additional Steps

- If prompted to install plugins, install them and restart the Jenkins service.
- After restarting the Jenkins service, wait for the login page to reappear before proceeding.
- Capture screenshots of your configuration for review purposes. Consider using screen recording software like (link unavailable) for documentation and sharing.

