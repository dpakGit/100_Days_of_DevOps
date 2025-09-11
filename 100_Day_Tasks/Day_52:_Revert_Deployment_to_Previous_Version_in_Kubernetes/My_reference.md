### To roll back the nginx-deployment to the previous revision, follow these steps:

Step 1: Check the Deployment History
Run the following command to view the deployment history:

bash
kubectl rollout history deployment/nginx-deployment

This command will display a list of revisions for the nginx-deployment, allowing you to see the current revision and the previous revisions.

Purpose: This step helps you understand the deployment history and identify the revision you want to roll back to.

Step 2: Roll Back to the Previous Revision
Use the following command to roll back to the previous revision:

bash
kubectl rollout undo deployment/nginx-deployment

By default, this command will roll back to the previous revision.

Purpose: This step initiates the rollback process, reverting the deployment to the previous revision.

Step 3: Verify the Rollback
After initiating the rollback, you can verify the status of the deployment using:

bash
kubectl rollout status deployment/nginx-deployment

This command will display the status of the rollout, indicating whether the rollback was successful.

Purpose: This step ensures that the rollback was successful and the deployment is in a stable state.

Step 4: Check the Current Revision
To confirm that the rollback was successful, you can check the current revision again:

bash
kubectl rollout history deployment/nginx-deployment

Compare the current revision with the previous output to verify that the rollback was successful.

Purpose: This step confirms that the deployment has been rolled back to the previous revision.

By following these steps, you should be able to successfully roll back the nginx-deployment to the previous revision.


### The "CHANGE-CAUSE" field in the output of the kubectl rollout history command refers to the reason or description for a particular revision of a deployment. It's essentially a way to track what changes were made in each revision.

By default, the "CHANGE-CAUSE" field might be empty or display <none> if no specific annotation is provided. However, you can annotate your deployment with kubernetes.io/change-cause to include a meaningful description of the changes made in each revision.

For example, running kubectl annotate deployment/myapp-deployment kubernetes.io/change-cause="update image version from 3.16 to 3.17" would update the "CHANGE-CAUSE" field for that revision to reflect the change ¹.

To include the change cause automatically, you can use the --record flag when applying changes or setting images, like this: kubectl set image deployment/nginx nginx=nginx:1.11.5 --record. This way, the "CHANGE-CAUSE" field will be populated with the command that triggered the change ².

The "CHANGE-CAUSE" field helps with :
- Tracking changes: Understanding what changes were made in each revision.
- Debugging: Identifying the cause of issues or errors in a deployment.
- Auditing: Maintaining a record of all changes made to a deployment.


[11-Sep-25 9:46 AM] Meta AI: https://www.baeldung.com/ops/deployment-rollout-kubernetes
[11-Sep-25 9:46 AM] Meta AI: https://tachingchen.com/blog/kubernetes-rolling-update-with-deployment/
[11-Sep-25 9:46 AM] Meta AI: https://linuxcloudservers.com/rollback-kubernetes-deployments/


### Running the following command will update the CHANGE-CAUSE field of the last rollout to the message passed with the --record flag or through annotation:


bash
kubectl annotate deployment/nginx-deployment kubernetes.io/change-cause="rollback to previous version" --overwrite


This command specifically updates the CHANGE-CAUSE annotation for the deployment, making it easier to track the reason for the rollback in the rollout history.

However, if you want the CHANGE-CAUSE to be automatically populated when you perform a rollout undo, you can use the --record flag when initially updating or rolling out changes to your deployment. For example:


bash
kubectl set image deployment/nginx nginx=nginx:1.9.1 --record


The --record flag automatically annotates the deployment with the command that triggered the change, which is then reflected in the CHANGE-CAUSE field of the rollout history.

In the case of a rollback, if you want to manually specify the CHANGE-CAUSE for the rollback action, the annotate command is the way to go.

### To pass a message for the CHANGE-CAUSE field with the --record option during a rollout undo, you can use the following command:


bash
kubectl rollout undo deployment/nginx-deployment --record=true --to-revision=<revision-number> --dry-run=client -o yaml | kubectl apply -f -


However, the --record flag doesn't directly support passing a custom message. Instead, it records the command that triggered the change.

If you want to specify a custom message for the CHANGE-CAUSE field during a rollback, you can annotate the deployment after the rollback:


bash
kubectl rollout undo deployment/nginx-deployment
kubectl annotate deployment/nginx-deployment kubernetes.io/change-cause="rollback to previous version for bug fix" --overwrite


This way, you can specify a meaningful message for the CHANGE-CAUSE field.

If you want to combine the rollback and annotation into a single command, you can use a script or a one-liner:


bash
kubectl rollout undo deployment/nginx-deployment && kubectl annotate deployment/nginx-deployment kubernetes.io/change-cause="rollback to previous version for bug fix" --overwrite



### The --overwrite flag is used with the kubectl annotate command to update an existing annotation on a resource.

When you use kubectl annotate without --overwrite, it will fail if the annotation already exists on the resource. By adding --overwrite, you're telling Kubernetes to update the existing annotation with the new value.

In the context of the previous command:

bash
kubectl annotate deployment/nginx-deployment kubernetes.io/change-cause="rollback to previous version for bug fix" --overwrite

The --overwrite flag ensures that if the kubernetes.io/change-cause annotation already exists on the nginx-deployment, its value will be updated to "rollback to previous version for bug fix". Without --overwrite, the command would fail if the annotation already exists.


### - The two commands provide different information:

##### 1. kubectl get deploy nginx-deployment -o wide :
   
- This command displays detailed information about the deployment, including the current image version being used by the deployment.
- The output will show the image name and tag, which indicates the current version of the image running in the deployment.

##### 2. kubectl rollout history deploy nginx-deployment :

- This command shows the rollout history of the deployment, including all revisions and the associated change causes (if annotated).
- It doesn't directly display the current image version but shows the history of changes, including rollouts and rollbacks.

To get the current image version from the rollout history, you'd need to look at the most recent revision and infer the image version from the change cause or other annotations, if available.

In summary:

- kubectl get deploy nginx-deployment -o wide directly shows the current image version.
- kubectl rollout history deploy nginx-deployment shows the deployment history, which can indirectly help identify image versions used in different revisions.
