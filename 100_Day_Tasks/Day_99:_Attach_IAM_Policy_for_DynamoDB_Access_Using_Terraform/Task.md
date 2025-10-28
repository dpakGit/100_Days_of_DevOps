### Task : Day 99: Attach IAM Policy for DynamoDB Access Using Terraform

The DevOps team has been tasked with creating a secure DynamoDB table and enforcing fine-grained access control using IAM. This setup will allow secure and restricted access to the table from trusted AWS services only.

As a member of the Nautilus DevOps Team, your task is to perform the following using Terraform:

Create a DynamoDB Table: Create a table named devops-table with minimal configuration.

Create an IAM Role: Create an IAM role named devops-role that will be allowed to access the table.

Create an IAM Policy: Create a policy named devops-readonly-policy that should grant read-only access (GetItem, Scan, Query) to the specific DynamoDB table and attach it to the role.

Create the main.tf file (do not create a separate .tf file) to provision the table, role, and policy.

Create the variables.tf file with the following variables:

KKE_TABLE_NAME: name of the DynamoDB table
KKE_ROLE_NAME: name of the IAM role
KKE_POLICY_NAME: name of the IAM policy
Create the outputs.tf file with the following outputs:

kke_dynamodb_table: name of the DynamoDB table
kke_iam_role_name: name of the IAM role
kke_iam_policy_name: name of the IAM policy
Define the actual values for these variables in the terraform.tfvars file.

Ensure that the IAM policy allows only read access and restricts it to the specific DynamoDB table created.


Notes:

The Terraform working directory is /home/bob/terraform.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.


### What I Did

Here's the Terraform configuration to create a DynamoDB table, IAM role, and policy:

variables.tf

```
variable "KKE_TABLE_NAME" {
  type = string
}

variable "KKE_ROLE_NAME" {
  type = string
}

variable "KKE_POLICY_NAME" {
  type = string
}
```

terraform.tfvars

```
KKE_TABLE_NAME = "devops-table"
KKE_ROLE_NAME  = "devops-role"
KKE_POLICY_NAME = "devops-readonly-policy"
```

main.tf

```
# Create DynamoDB table
resource "aws_dynamodb_table" "devops_table" {
  name         = var.KKE_TABLE_NAME
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# Create IAM role
resource "aws_iam_role" "devops_role" {
  name        = var.KKE_ROLE_NAME
  description = "Role for accessing DynamoDB table"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
      },
    ]
  })
}

# Create IAM policy
resource "aws_iam_policy" "devops_readonly_policy" {
  name        = var.KKE_POLICY_NAME
  description = "Policy for read-only access to DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.devops_table.arn
      },
    ]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "devops_role_policy_attachment" {
  role       = aws_iam_role.devops_role.name
  policy_arn = aws_iam_policy.devops_readonly_policy.arn
}
```

outputs.tf

```
output "kke_dynamodb_table" {
  value = aws_dynamodb_table.devops_table.name
}

output "kke_iam_role_name" {
  value = aws_iam_role.devops_role.name
}

output "kke_iam_policy_name" {
  value = aws_iam_policy.devops_readonly_policy.name
}
```

To apply this configuration, navigate to the Terraform working directory and run the following commands:


bash

cd /home/bob/terraform

terraform init

terraform plan

terraform apply


After applying the configuration, verify that the DynamoDB table, IAM role, and policy have been created successfully. Make sure to run terraform plan again to ensure that there are no changes.

