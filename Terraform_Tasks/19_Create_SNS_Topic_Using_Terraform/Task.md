### Task : Create SNS Topic Using Terraform

The Nautilus DevOps team needs to set up an SNS topic for sending notifications. They need to create an SNS topic with the following specifications:

1) The topic name should be devops-notifications.

Use Terraform to create this SNS topic. The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi  main.tf
 
bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_sns_topic.devops_notifications will be created
  + resource "aws_sns_topic" "devops_notifications" {
      + arn                         = (known after apply)
      + beginning_archive_time      = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "devops-notifications"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + signature_version           = (known after apply)
      + tags_all                    = (known after apply)
      + tracing_config              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_sns_topic.devops_notifications: Creating...
aws_sns_topic.devops_notifications: Creation complete after 0s [id=arn:aws:sns:us-east-1:000000000000:devops-notifications]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_sns_topic.devops_notifications

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate
```
### #💠 main.tf 

```
# Create an SNS topic
resource "aws_sns_topic" "devops_notifications" {
  name = "devops-notifications"
}
```

```
bob@iac-server ~/terraform via 💠 default ➜  history
    1  pwd
    2  ls
    3  vi  main.tf
    4  terraform fmt
    5  terraform init
    6  terraform validate
    7  terraform apply -auto-approve
    8  terraform state list
    9  ls
```
