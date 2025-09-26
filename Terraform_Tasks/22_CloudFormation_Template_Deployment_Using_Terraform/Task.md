### Task : CloudFormation Template Deployment Using Terraform

The Nautilus DevOps team is working on automating infrastructure deployment using AWS CloudFormation. As part of this effort, they need to create a CloudFormation stack that provisions an S3 bucket with versioning enabled.

Create a CloudFormation stack named devops-stack using Terraform. This stack should contain an S3 bucket named devops-bucket-27378 as a resource, and the bucket must have versioning enabled. The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

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

  # aws_cloudformation_stack.devops_stack will be created
  + resource "aws_cloudformation_stack" "devops_stack" {
      + id            = (known after apply)
      + name          = "devops-stack"
      + outputs       = (known after apply)
      + parameters    = (known after apply)
      + policy_body   = (known after apply)
      + tags_all      = (known after apply)
      + template_body = jsonencode(
            {
              + AWSTemplateFormatVersion = "2010-09-09"
              + Resources                = {
                  + S3Bucket = {
                      + Properties = {
                          + BucketName              = "devops-bucket-27378"
                          + VersioningConfiguration = {
                              + Status = "Enabled"
                            }
                        }
                      + Type       = "AWS::S3::Bucket"
                    }
                }
            }
        )
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_cloudformation_stack.devops_stack: Creating...
aws_cloudformation_stack.devops_stack: Still creating... [10s elapsed]
aws_cloudformation_stack.devops_stack: Creation complete after 11s [id=arn:aws:cloudformation:us-east-1:000000000000:stack/devops-stack/c6a9486b-f5f1-40fd-a785-8d987a333bb5]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_cloudformation_stack.devops_stack
```

```
history | c
ut -c 8-
pwd
ls
vi main.tf
terraform init
terraform fmt
terraform validate
terraform apply -auto-approve
terraform state list
history | cut -c 8-
```

### # 💠 main.tf
```
resource "aws_cloudformation_stack" "devops_stack" {
  name = "devops-stack"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Resources = {
      S3Bucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = "devops-bucket-27378"
          VersioningConfiguration = {
            Status = "Enabled"
          }
        }
      }
    }
  })
}
```


