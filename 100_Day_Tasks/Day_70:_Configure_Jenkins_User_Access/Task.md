<img width="1920" height="1080" alt="Screenshot (289)" src="https://github.com/user-attachments/assets/4efcc31c-76e9-4e5d-aefc-ad13465e2337" />### Task : Day 70: Configure Jenkins User Access

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

<img width="1920" height="1080" alt="Screenshot (251)" src="https://github.com/user-attachments/assets/4dfb93e4-2fdb-4a1b-adbd-a0c189f99ab7" />

<img width="1920" height="1080" alt="Screenshot (268)" src="https://github.com/user-attachments/assets/89df325a-3ece-4fb3-b7c6-d19331cae503" />

<img width="1920" height="1080" alt="Screenshot (269)" src="https://github.com/user-attachments/assets/ac09051c-a0c2-45c8-bf5a-b76af116ab5f" />

<img width="1920" height="1080" alt="Screenshot (270)" src="https://github.com/user-attachments/assets/c8ea6e1b-d92d-455c-9ab4-afa3436837f2" />

<img width="1920" height="1080" alt="Screenshot (271)" src="https://github.com/user-attachments/assets/53696606-ef03-44f8-a423-a307e3bc51b5" />

<img width="1920" height="1080" alt="Screenshot (272)" src="https://github.com/user-attachments/assets/bce58150-2cfa-4f2e-a6a5-70b50b4cb428" />

<img width="1920" height="1080" alt="Screenshot (286)" src="https://github.com/user-attachments/assets/26912901-2360-43ef-8244-3c10bb3d6f90" />

<img width="1920" height="1080" alt="Screenshot (287)" src="https://github.com/user-attachments/assets/d3446107-6f23-41ad-b7d6-3226a170deed" />

<img width="1920" height="1080" alt="Screenshot (288)" src="https://github.com/user-attachments/assets/2d67f146-e622-4455-a145-6dcaede52b77" />





