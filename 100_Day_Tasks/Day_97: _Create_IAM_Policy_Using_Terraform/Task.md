### Task : Day 97: Create IAM Policy Using Terraform

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements.

Create an IAM policy named iampolicy_ammar in us-east-1 region using Terraform. It must allow read-only access to the EC2 console, i.e., this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

### What I Did

Here's the Terraform configuration to create an IAM policy named "iampolicy_ammar" in the us-east-1 region that allows read-only access to the EC2 console:


```
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create IAM policy
resource "aws_iam_policy" "iampolicy_ammar" {
  name        = "iampolicy_ammar"
  description = "Policy for read-only access to EC2 console"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots"
        ]
        Resource = "*"
      }
    ]
  })
}
```

To create this policy using Terraform, follow these steps:

1. Navigate to the Terraform working directory: cd /home/bob/terraform
2. Create a file named main.tf and paste the above configuration into it.
3. Initialize the Terraform working directory: terraform init
4. Apply the configuration: terraform apply

This will create an IAM policy named "iampolicy_ammar" in the us-east-1 region with read-only access to the EC2 console.

Note that the policy allows the following actions:
```
- ec2:DescribeInstances: Allows users to view all instances in the EC2 console.
- ec2:DescribeImages: Allows users to view all AMIs in the EC2 console.
- ec2:DescribeSnapshots: Allows users to view all snapshots in the EC2 console.

The Resource = "*" line specifies that these actions can be performed on all resources.
```
