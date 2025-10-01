### Task : Attach Policy Using Terraform

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

An IAM user named iamuser_mariyam and a policy named iampolicy_mariyam already exists. Use Terraform to attach the IAM policy iampolicy_mariyam to the IAM user iamuser_mariyam. The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to attach the specified IAM policy to the IAM user.


### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 

# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_mariyam"

  tags = {
    Name = "iamuser_mariyam"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_mariyam"
  description = "IAM policy allowing EC2 read actions for mariyam"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}


bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 
 
bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform plan
aws_iam_policy.policy: Refreshing state... [id=arn:aws:iam::000000000000:policy/iampolicy_mariyam]
aws_iam_user.user: Refreshing state... [id=iamuser_mariyam]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user_policy_attachment.attach_policy will be created
  + resource "aws_iam_user_policy_attachment" "attach_policy" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::000000000000:policy/iampolicy_mariyam"
      + user       = "iamuser_mariyam"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions
if you run "terraform apply" now.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_iam_policy.policy: Refreshing state... [id=arn:aws:iam::000000000000:policy/iampolicy_mariyam]
aws_iam_user.user: Refreshing state... [id=iamuser_mariyam]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_user_policy_attachment.attach_policy will be created
  + resource "aws_iam_user_policy_attachment" "attach_policy" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::000000000000:policy/iampolicy_mariyam"
      + user       = "iamuser_mariyam"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user_policy_attachment.attach_policy: Creating...
aws_iam_user_policy_attachment.attach_policy: Creation complete after 0s [id=iamuser_mariyam-20251001050315080200000001]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_iam_policy.policy
aws_iam_user.user
aws_iam_user_policy_attachment.attach_policy

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 

# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_mariyam"

  tags = {
    Name = "iamuser_mariyam"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_mariyam"
  description = "IAM policy allowing EC2 read actions for mariyam"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
```

💠 default ➜  history | cut -c 8-

```
pwd
ls
cat main.tf 
vi main.tf 
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
cat main.tf 
history | cut -c 8-
```
