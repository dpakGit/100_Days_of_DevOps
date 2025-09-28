### Day 69: Install Jenkins Plugins

The Nautilus DevOps team has recently setup a Jenkins server, which they want to use for some CI/CD jobs. Before that they want to install some plugins which will be used in most of the jobs. Please find below more details about the task



1. Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and Adm!n321 password.


2. Once logged in, install the Git and GitLab plugins. Note that you may need to restart Jenkins service to complete the plugins installation, If required, opt to Restart Jenkins when installation is complete and no jobs are running on plugin installation/update page i.e update centre.

Note:

1. After restarting the Jenkins service, wait for the Jenkins login page to reappear before proceeding.

2. For tasks involving web UI changes, capture screenshots to share for review or consider using screen recording software like loom.com for documentation and sharing.



### What I Did

To get started with Jenkins for CI/CD jobs, follow these steps:

Step 1: Access Jenkins UI and Login

- Click the Jenkins button on the top bar to access the Jenkins UI.
- Log in with the username "admin" and password "Adm!n321".

Step 2: Install Required Plugins

- Install the Git and GitLab plugins, which are essential for most CI/CD jobs.
- If prompted, opt to restart Jenkins after installation is complete and no jobs are running.

Additional Notes

- After restarting Jenkins, wait for the login page to reappear before proceeding.
- For tasks involving web UI changes, consider capturing screenshots or using screen recording software like (link unavailable) for documentation and sharing.

By following these steps, you'll have the necessary plugins installed and be ready to set up your CI/CD jobs.


### How to check installed plugins

Yes, you can check if plugins are installed in Jenkins using the Jenkins CLI or by checking the plugin directory. Here are a few ways to do it:

Method 1: Jenkins CLI

You can use the Jenkins CLI to list installed plugins. Here's an example command:

java -jar jenkins-cli.jar -s http://localhost:8080 list-plugins

Replace http://localhost:8080 with your Jenkins server URL.

Method 2: Plugin Directory

You can also check the plugin directory on the Jenkins server. The plugins are typically installed in the plugins directory of the Jenkins home directory.

For example, on a Linux system, you can check the plugins directory like this:

bash
ls /var/lib/jenkins/plugins

Look for the plugin files (e.g., git.hpi, gitlab.hpi) to verify if the plugins are installed.

Method 3: Jenkins Script Console

You can also use the Jenkins Script Console to list installed plugins. Here's an example script:

Jenkins.instance.pluginManager.plugins.each { plugin ->
    println "${plugin.shortName} ${plugin.version}"
}

Run this script in the Jenkins Script Console (available at http://your-jenkins-server/script) to list all installed plugins.

These methods can help you verify if the Git and GitLab plugins are installed correctly.
