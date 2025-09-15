### Task  : Create Alarm Using Terraform / Create a CloudWatch alarm

The Nautilus DevOps team is setting up monitoring in their AWS account. As part of this, they need to create a CloudWatch alarm.

Using Terraform, perform the following:

Task Details:
Create a CloudWatch alarm named nautilus-alarm.
The alarm should monitor CPU utilization of an EC2 instance.
Trigger the alarm when CPU utilization exceeds 80%.
Set the evaluation period to 5 minutes.
Use a single evaluation period.
Ensure that the entire configuration is implemented using Terraform. The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

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

  # aws_cloudwatch_metric_alarm.nautilus-alarm will be created
  + resource "aws_cloudwatch_metric_alarm" "nautilus-alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "Alarm when CPU utilization exceeds 80%"
      + alarm_name                            = "nautilus-alarm"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanThreshold"
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "CPUUtilization"
      + namespace                             = "AWS/EC2"
      + period                                = 300
      + statistic                             = "Average"
      + tags_all                              = (known after apply)
      + threshold                             = 80
      + treat_missing_data                    = "missing"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_cloudwatch_metric_alarm.nautilus-alarm: Creating...
aws_cloudwatch_metric_alarm.nautilus-alarm: Creation complete after 1s [id=nautilus-alarm]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

### # main.tf
```
resource "aws_cloudwatch_metric_alarm" "nautilus-alarm" {
  alarm_name                = "nautilus-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Alarm when CPU utilization exceeds 80%"
  insufficient_data_actions = []
  alarm_actions             = []
  ok_actions                = []
}
```
```
bob@iac-server ~/terraform via 💠 default ➜  history | cut -c 8-
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
terraform apply -auto-approve
cat main.tf
history | cut -c 8-
```
