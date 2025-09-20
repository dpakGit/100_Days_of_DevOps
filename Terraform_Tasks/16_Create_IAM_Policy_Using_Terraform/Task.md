### Task : Create IAM Policy Using Terraform

When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements.

Create an IAM policy named iampolicy_john in us-east-1 region using Terraform. It must allow read-only access to the EC2 console, i.e., this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.



### Task Explanation

The task requires creating an IAM policy named iampolicy_john in the us-east-1 region using Terraform. The policy should grant read-only access to the EC2 console, allowing users to view:

1. All instances
2. All Amazon Machine Images (AMIs)
3. All snapshots

What to Do

To accomplish this task, you'll need to:

1. Create a Terraform configuration file (e.g., main.tf) that defines the IAM policy.
2. Use the aws_iam_policy resource to create the policy.
3. Specify the policy name as iampolicy_john.
4. Define the policy document with the necessary permissions for read-only access to EC2 resources.
5. Use the ec2:Describe* actions to grant read-only access to EC2 instances, AMIs, and snapshots.



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

bob@iac-server ~/terraform via 💠 default ✖ vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_policy.iampolicy_john will be created
  + resource "aws_iam_policy" "iampolicy_john" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Read-only access to EC2 console"
      + id               = (known after apply)
      + name             = "iampolicy_john"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ec2:DescribeInstances",
                          + "ec2:DescribeImages",
                          + "ec2:DescribeSnapshots",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id        = (known after apply)
      + tags_all         = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_policy.iampolicy_john: Creating...
aws_iam_policy.iampolicy_john: Creation complete after 1s [id=arn:aws:iam::000000000000:policy/iampolicy_john]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_iam_policy.iampolicy_john
```

### # main.tf

```
resource "aws_iam_policy" "iampolicy_john" {
  name        = "iampolicy_john"
  description = "Read-only access to EC2 console"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
        ]
        Resource = "*"
      },
    ]
  })
}
````

```
💠 default ➜  history | cut -c 8-
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform apply -auto-approve
terraform state list
``
