
## Day 6: Create a Cron Job

### The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:

### a. Install cronie package on all Nautilus app servers and start crond service.
### b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user.

Solution:

#### Let's break down the task into simpler terms:

Task: Set up a test cron job on all app servers in Stratos DC.

Step 1: Install cronie package and start crond service

- What: Install a package called "cronie" on all app servers.
- Why: Cronie is a package that helps run scheduled tasks (cron jobs) on the servers.
- How: Run a command to install cronie and start the crond service.

 # Install cronie package
sudo yum install -y cronie

# Start crond service
sudo systemctl start crond

# Enable crond service to start on boot
sudo systemctl enable crond


Step 2: Add a sample cron job

- What: Create a cron job that runs every 5 minutes.
- Why: This is a test to ensure the cron job system is working correctly.
- How: Add a specific command to the root user's cron table:
- */5 * * * * means "run every 5 minutes".
- echo hello > /tmp/cron_text means "output the word 'hello' to a file called /tmp/cron_text".


To add a cron job for the root user, you can use the crontab command with sudo to edit the root's crontab:

bash
sudo crontab -e

This will open the root user's crontab file in an editor. Add the following line to schedule a job that runs every 5 minutes:

bash
*/5 * * * * echo hello > /tmp/cron_text

Save and exit the editor. The cron daemon will automatically pick up the new job.

Verification
After setting up the cron job, you can verify that it's working by checking the /tmp/cron_text file every 5 minutes or so. The content of the file should update with "hello" as per the cron job's schedule:

bash
cat /tmp/cron_text


If you want to check the cron job logs for any issues or confirmations, you can usually find them in /var/log/cron or /var/log/syslog, depending on your system configuration:


bash
sudo tail /var/log/cron


This setup should meet the requirements for testing the functionality with a sample cron job on all Nautilus app servers.


In simple terms:

1. Install a package on all app servers that helps run scheduled tasks.
2. Start the service that runs these scheduled tasks.
3. Set up a test task that runs every 5 minutes and writes "hello" to a file.

This task is a test to ensure the cron job system is working correctly before deploying actual scripts to automate day-to-day tasks.

