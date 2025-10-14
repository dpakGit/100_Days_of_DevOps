Project Nautilus:Overview clicking on the wiki button o the L.H.S menu list will take you to this page containing IP , Username, Password,etc of all servers.
https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus#project-nautilus

Decouple application configuration from code, making it easier to manage and update values without changing the code.

### Points To Note :

Suppose we want to clone a git repo using a Jenkins job named Myjob and the job must be build on a slave node slave1. Then once the job is build where will we find the folders in the working directory of slave or master?

When you run a Jenkins job on a slave node, the workspace (working directory) is created on the slave node itself. So, in your case:

- Job Name: Myjob
- Slave Node: slave1

When you run the job on slave1, the Git repository will be cloned into the workspace directory on the slave node (slave1).

The workspace directory is usually located under the root directory specified in the slave node's configuration. By default, it's often something like /var/lib/jenkins/workspace/ or C:\Jenkins\workspace\ on Windows, but it can vary depending on your Jenkins configuration.

After the job completes, the cloned repository will be present in the workspace directory on the slave node (slave1), not on the master node.

Here's a rough outline of where you might find the cloned repository:

- Slave Node (slave1): /var/lib/jenkins/workspace/Myjob/ (or similar path)

Note that the workspace directory is usually cleaned up or reused between job runs, depending on your Jenkins configuration. If you need to persist the cloned repository or any other files, you might want to consider archiving them as part of the job or copying them to a different location.

The master node only stores the job configuration, build history, and other metadata. The actual workspace and build execution happen on the slave node.

### URL format for Webhook : <Jenkins URL>/buildByToken/build?job=<Job_Name>&token=<Token>
