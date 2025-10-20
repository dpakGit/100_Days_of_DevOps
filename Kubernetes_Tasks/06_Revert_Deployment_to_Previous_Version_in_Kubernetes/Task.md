### Task : Revert Deployment to Previous Version in Kubernetes

Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.

There exists a deployment named nginx-deployment; initiate a rollback to the previous revision.

### what I Did

Same as Day- 52 KKE task
https://github.com/dpakGit/100_Days_of_DevOps/blob/main/100_Day_Tasks/Day_52%3A_Revert_Deployment_to_Previous_Version_in_Kubernetes/Task.md

To roll back the deployment to the previous revision, you can use the kubectl rollout history and kubectl rollout undo commands.

Here's how you can do it:

1. Check the rollout history:


bash
kubectl rollout history deployment/nginx-deployment


This command will show you the revision history of the deployment.

2. Roll back to the previous revision:


bash
kubectl rollout undo deployment/nginx-deployment


By default, this command will roll back to the previous revision. If you want to roll back to a specific revision, you can specify the --to-revision option followed by the revision number.

For example, if you want to roll back to revision 1, you can use the following command:


bash
kubectl rollout undo deployment/nginx-deployment --to-revision=1


After rolling back, you can verify the status of the deployment using:


bash
kubectl rollout status deployment/nginx-deployment


This will show you the status of the rollout. If the rollout is successful, you should see a message indicating that the deployment has been rolled back.
