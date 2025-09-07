### Task: Day 2: Temporary User Setup with Expiry 

#### As part of the temporary assignment to the Nautilus project, a developer named ammar requires access for a limited duration. To ensure smooth access management, a temporary user account with an expiry date is needed. Here's what you need to do:

#### Create a user named ammar on App Server 2 in Stratos Datacenter. Set the expiry date to 2024-02-17, ensuring the user is created in lowercase as per standard protocol.

#### Solution:
**What I did :**
```
1 #  Connect to App Server 2: SSH into App Server 2 using ssh username@<IP_of_App_Server_2>
   
  ssh steve@172.16.238.11 # Ths is the command

[steve@stapp02 ~]$ # Now we are inside App Server 2
    1  # Create user ammar with expiry date
   
    2  sudo useradd -e 2024-02-17 ammar
    3  cut -d: -f1 /etc/passwd
    4  sudo chage -l ammar
    
Output of command no. "4" : Line no. 4 shows the account expire date
[steve@stapp02 ~]$ sudo chage -l ammar

Last password change                                    : Jul 24, 2025
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : Feb 17, 2024 
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```
**Meta AI Solution:**

*Creating Temporary User ammar on App Server 2*
To create a temporary user ammar with an expiry date on App Server 2 in Stratos Datacenter:

Steps:
1. Connect to App Server 2: SSH into App Server 2 using ssh username@<IP_of_App_Server_2>, replacing <IP_of_App_Server_2> with the actual IP address.
2. *Create user ammar with expiry date*:

bash
sudo useradd -e 2024-02-17 ammar

-e 2024-02-17 sets the account expiry date to February 17, 2024.

*Meaning of -e*
In the useradd command, *-e stands for "expire"*.

Context
- *-e <date>*: Sets the account expiry date for the user.
- Format for the date is typically YYYY-MM-DD (e.g., 2024-02-17).


3. Verify user creation and expiry:

bash
sudo chage -l ammar

- This shows account expiry information for ammar.

4. Exit SSH session: Use exit to return to the original user.

Notes
- Ensure the username ammar is in lowercase as required.
- You need a valid username, IP address of App Server 2, and credentials to SSH into App Server 2.

Do you need help with executing these steps, managing user accounts, or something else regarding App Server 2?
