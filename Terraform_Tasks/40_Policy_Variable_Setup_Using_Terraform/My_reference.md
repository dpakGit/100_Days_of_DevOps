Here's how you can create an AWS IAM policy using Terraform with the specified requirements:

variables.tf
```
terraform
variable "KKE_iampolicy" {
  type        = string
  default     = "iampolicy_javed"
}

```
main.tf
```
terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_iam_policy" "iam_policy" {
  name        = var.KKE_iampolicy
  description = "IAM policy created using Terraform"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          # Add the required actions here, for example:
          "ec2:DescribeInstances",
          "s3:ListBuckets",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
```

Explanation:

- In variables.tf, we define a variable KKE_iampolicy with a default value of iampolicy_javed.
- In main.tf, we specify the AWS provider and the region where you want to create the IAM policy.
- We use the aws_iam_policy resource to create an IAM policy with the name specified in the KKE_iampolicy variable.
- In the policy attribute, we define the policy document using JSON. You should add the required actions and resources according to your needs.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the IAM policy. Also, ensure you have the necessary AWS credentials configured on your system.

Note that you should update the Action and Resource fields in the policy document to match your specific requirements. The example above grants permissions to describe EC2 instances and list S3 buckets.
