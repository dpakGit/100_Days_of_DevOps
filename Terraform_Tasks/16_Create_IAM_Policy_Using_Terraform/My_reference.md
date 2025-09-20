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

Terraform Code

Here's an example Terraform code that meets the requirements:
```
terraform
provider "aws" {
  region = "us-east-1"
}

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
```
Steps to Deploy

1. Save the Terraform code in a file named main.tf.
2. Run terraform init to initialize the Terraform working directory.
3. Run terraform apply to create the IAM policy.

Once the policy is created, you can attach it to IAM users, groups, or roles to grant them read-only access to the EC2 console.

### Here's an example Terraform code to create an IAM policy named iampolicy_rose in the us-east-1 region that allows read-only access to the EC2 console:

```
terraform
provider "aws" {
  region = "us-east-1"
}

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
```
Explanation

- The provider "aws" block specifies the AWS region where the IAM policy will be created.
- The resource "aws_iam_policy" block defines the IAM policy named iampolicy_rose.
- The policy attribute defines the policy document in JSON format.
- The Version attribute specifies the version of the policy language.
- The Statement attribute defines a single statement that allows read-only access to EC2 resources.
- The Effect attribute specifies that the statement allows the specified actions.
- The Action attribute specifies the actions that are allowed, which in this case are:
    - ec2:DescribeInstances: allows viewing instances
    - ec2:DescribeImages: allows viewing AMIs
    - ec2:DescribeSnapshots: allows viewing snapshots
- The Resource attribute specifies that the policy applies to all resources (*).

To apply this Terraform code

1. Save this code in a file named main.tf.
2. Initialize the Terraform working directory by running terraform init.
3. Apply the Terraform configuration by running terraform apply.

This will create the IAM policy named iampolicy_rose in the us-east-1 region. You can then attach this policy to IAM users, groups, or roles to grant them read-only access to the EC2 console.


### The part of the code that makes it read-only access is the Action section within the Statement block:

```
terraform
Action = [
  "ec2:DescribeInstances",
  "ec2:DescribeImages",
  "ec2:DescribeSnapshots",
]
```

These actions are all "read-only" because they start with the prefix Describe, which is a convention in AWS IAM for read-only actions. These actions allow the policy to:

- ec2:DescribeInstances: View EC2 instances
- ec2:DescribeImages: View Amazon Machine Images (AMIs)
- ec2:DescribeSnapshots: View EC2 snapshots

By only including Describe actions and not including any actions that start with Create, Update, Delete, or Modify, this policy ensures that users can only view EC2 resources and cannot make any changes to them.

Additionally, the Effect attribute is set to Allow, which means that the policy allows the specified actions:


terraform
Effect = "Allow"


If the Effect were set to Deny, it would prevent the specified actions from being performed. However, in this case, Allow is used to grant read-only access to the specified EC2 resources.


### To grant read-write access to EC2 resources, you'll need to include actions that allow creating, updating, and deleting resources, in addition to the Describe actions.

Here's an example code that grants read-write access to EC2 instances, AMIs, and snapshots:

```
terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy" "iampolicy_john" {
  name        = "iampolicy_john"
  description = "Read-write access to EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          # Read-only actions
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",

          # Read-write actions
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:CreateImage",
          "ec2:DeleteSnapshot",
          "ec2:DeregisterImage",
          "ec2:CreateSnapshot",
          "ec2:ModifyInstanceAttribute",
        ]
        Resource = "*"
      },
    ]
  })
}
```

In this example, the policy includes both Describe actions for read-only access and additional actions for read-write access, such as:

- ec2:RunInstances: Launch new instances
- ec2:StartInstances, ec2:StopInstances, and ec2:TerminateInstances: Manage instance state
- ec2:CreateImage and ec2:DeregisterImage: Create and delete AMIs
- ec2:CreateSnapshot and ec2:DeleteSnapshot: Create and delete snapshots
- ec2:ModifyInstanceAttribute: Modify instance attributes

By including these actions, the policy grants read-write access to EC2 resources, allowing users to perform a range of actions beyond just viewing resources.


### In AWS IAM, there are two main options for the Effect attribute:

1. Allow: Grants permission to perform the specified actions.
2. Deny: Denies permission to perform the specified actions.

When it comes to access levels, you can think of it in terms of:

1. Read-only: Allows users to view resources, but not modify them. (e.g., ec2:DescribeInstances)
2. Read-write: Allows users to view and modify resources. (e.g., ec2:DescribeInstances, ec2:RunInstances, ec2:TerminateInstances)
3. Admin: Grants full access to resources, including creating, modifying, and deleting them. (e.g., all EC2 actions, including ec2:*)
4. Deny all: Denies all actions on resources.

In terms of specific actions, AWS IAM provides a wide range of options, including:

- Create: Create new resources (e.g., ec2:RunInstances)
- Read: View resources (e.g., ec2:DescribeInstances)
- Update: Modify existing resources (e.g., ec2:ModifyInstanceAttribute)
- Delete: Delete resources (e.g., ec2:TerminateInstances)

When crafting IAM policies, you can combine these actions to grant specific permissions to users, groups, or roles.


### To grant full access to EC2 resources, including creating, modifying, and deleting them, you can use a policy that allows all EC2 actions. Here's an example code:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_policy" "iampolicy_john" {
  name        = "iampolicy_john"
  description = "Full access to EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ec2:*"
        Resource = "*"
      },
    ]
  })
}


In this code:

- ec2:* is a wildcard that matches all EC2 actions, granting full access to EC2 resources.
- Resource = "*" specifies that the policy applies to all resources.

By using ec2:*, you're granting permission to perform any action on any EC2 resource, including:

- Creating instances, images, and snapshots
- Modifying instance attributes, images, and snapshots
- Deleting instances, images, and snapshots
- Viewing instances, images, and snapshots

This policy effectively grants administrative access to EC2 resources.

Note: Be cautious when granting full access to resources, as it can potentially lead to unintended consequences or security risks if not properly managed.


### It's generally a good practice to run terraform fmt before terraform init, but it's not strictly necessary.

terraform fmt is a command that formats your Terraform configuration files to a consistent style and canonical format. Running terraform fmt before terraform init can help ensure that your configuration files are properly formatted and easier to read.

However, terraform init will still work even if your configuration files are not formatted correctly. terraform init is responsible for initializing the Terraform working directory, including downloading providers and modules, and it doesn't care about the formatting of your configuration files.

So, while running terraform fmt before terraform init is a good practice, it's not a requirement. You can run terraform fmt at any time, and it's often a good idea to run it as part of your development workflow to keep your configuration files tidy and consistent.

Here's a suggested workflow:

1. Write your Terraform configuration files.
2. Run terraform fmt to format your configuration files.
3. Run terraform init to initialize the Terraform working directory.
4. Run terraform plan and terraform apply to deploy your infrastructure.

By following this workflow, you can ensure that your Terraform configuration files are properly formatted and easy to manage.
