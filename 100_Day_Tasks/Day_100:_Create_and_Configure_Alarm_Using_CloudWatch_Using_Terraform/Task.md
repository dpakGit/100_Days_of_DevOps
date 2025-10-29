### Task : Day_100:_Create_and_Configure_Alarm_Using_CloudWatch_Using_Terraform

The Nautilus DevOps team has been tasked with setting up an EC2 instance for their application. To ensure the application performs optimally, they also need to create a CloudWatch alarm to monitor the instance's CPU utilization. The alarm should trigger if the CPU utilization exceeds 90% for one consecutive 5-minute period. To send notifications, use the SNS topic named devops-sns-topic, which is already created.

Launch EC2 Instance: Create an EC2 instance named devops-ec2 using any appropriate Ubuntu AMI (you can use AMI ami-0c02fb55956c7d316).

Create CloudWatch Alarm: Create a CloudWatch alarm named devops-alarm with the following specifications:

Statistic: Average
Metric: CPU Utilization
Threshold: >= 90% for 1 consecutive 5-minute period
Alarm Actions: Send a notification to the devops-sns-topic SNS topic.
Update the main.tf file (do not create a separate .tf file) to create a EC2 Instance and CloudWatch Alarm.

Create an outputs.tf file to output the following values:

KKE_instance_name for the EC2 instance name.
KKE_alarm_name for the CloudWatch alarm name.

Notes:

The Terraform working directory is /home/bob/terraform.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.

### What I Did


To accomplish this task, we'll create the necessary Terraform configuration files. Here's how you can do it:

main.tf

```
provider "aws" {
  region = "us-east-1" # Replace with your region
}

# Create EC2 instance
resource "aws_instance" "devops_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "devops-ec2"
  }
}

# Create CloudWatch alarm
resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name                = "devops-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "Alarm when CPU utilization exceeds 90%"
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.devops_sns_topic.arn]
  insufficient_data_actions = []
  ok_actions                = []
  dimensions = {
    InstanceId = aws_instance.devops_ec2.id
  }
}

# Get the ARN of the existing SNS topic
data "aws_sns_topic" "devops_sns_topic" {
  name = "devops-sns-topic"
}
```

If you already have the SNS topic created in your Terraform configuration, like this:

This was already existing in the main.tf file
```
resource "aws_sns_topic" "sns_topic" {
  name = "devops-sns-topic"
}
```

Then you can reference the ARN of this topic in your CloudWatch alarm like this:


```
alarm_actions = [aws_sns_topic.sns_topic.arn]
```

So your CloudWatch alarm resource would look like this:


```
resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name                = "devops-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "Alarm when CPU utilization exceeds 90%"
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.sns_topic.arn] # ARN referenced here
  insufficient_data_actions = []
  ok_actions                = []
  dimensions = {
    InstanceId = aws_instance.devops_ec2.id
  }
}

```

However, if the SNS topic is already created outside of this Terraform configuration (i.e., it was created manually or in a different Terraform configuration), you would use a data source to get the ARN of the existing SNS topic:


```
data "aws_sns_topic" "devops_sns_topic" {
  name = "devops-sns-topic"
}
```

And then reference it in your CloudWatch alarm like this:


```
alarm_actions = [data.aws_sns_topic.devops_sns_topic.arn]
```

Make sure to adjust your configuration according to how your SNS topic was created.


Final main.tf file
```
resource "aws_sns_topic" "sns_topic" {
  name = "devops-sns-topic"
}

# Create EC2 instance
resource "aws_instance" "devops_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "devops-ec2"
  }
}

# Create CloudWatch alarm
resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name                = "devops-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "Alarm when CPU utilization exceeds 90%"
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.sns_topic.arn]
  insufficient_data_actions = []
  ok_actions                = []
  dimensions = {
    InstanceId = aws_instance.devops_ec2.id
  }
}
```

outputs.tf

```
output "KKE_instance_name" {
  value = aws_instance.devops_ec2.tags.Name
}

output "KKE_alarm_name" {
  value = aws_cloudwatch_metric_alarm.devops_alarm.alarm_name
}
```

Here's what we've done:

1. In main.tf, we've defined the AWS provider and created an EC2 instance with the specified AMI.

2. We've also created a CloudWatch alarm that triggers when the CPU utilization exceeds 90% for 1 consecutive 5-minute period. The alarm sends a notification to the specified SNS topic.

3. In outputs.tf, we've defined outputs for the EC2 instance name and the CloudWatch alarm name.

To verify that everything is working correctly, run the following commands in your Terraform working directory:

1. terraform init to initialize the Terraform working directory.
2. terraform plan to see the execution plan. Ensure that it returns "No changes" or the expected changes.
3. terraform apply to apply the configuration.

After applying the configuration, your EC2 instance and CloudWatch alarm should be created, and the alarm should trigger when the CPU utilization exceeds 90% for 1 consecutive 5-minute period.
