### Task : 
Data protection and recovery are fundamental aspects of data management. It's essential to have systems in place to ensure that data can be recovered in case of accidental deletion or corruption. The DevOps team has received a requirement for implementing such measures for one of the S3 buckets they are managing.

The S3 bucket name is nautilus-s3-24456, enable versioning for this bucket using Terraform.

The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a different .tf file) to accomplish this task.

### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
ls
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_s3_bucket.s3_ran_bucket: Refreshing state... [id=nautilus-s3-24456]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket_acl.s3_ran_bucket_acl will be created
  + resource "aws_s3_bucket_acl" "s3_ran_bucket_acl" {
      + acl    = "private"
      + bucket = "nautilus-s3-24456"
      + id     = (known after apply)

      + access_control_policy (known after apply)
    }

  # aws_s3_bucket_versioning.s3_ran_bucket_versioning will be created
  + resource "aws_s3_bucket_versioning" "s3_ran_bucket_versioning" {
      + bucket = "nautilus-s3-24456"
      + id     = (known after apply)

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
aws_s3_bucket_versioning.s3_ran_bucket_versioning: Creating...
aws_s3_bucket_acl.s3_ran_bucket_acl: Creating...
aws_s3_bucket_acl.s3_ran_bucket_acl: Creation complete after 0s [id=nautilus-s3-24456,private]
aws_s3_bucket_versioning.s3_ran_bucket_versioning: Creation complete after 1s [id=nautilus-s3-24456]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_s3_bucket.s3_ran_bucket
aws_s3_bucket_acl.s3_ran_bucket_acl
aws_s3_bucket_versioning.s3_ran_bucket_versioning

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "nautilus-s3-24456"

  tags = {
    Name = "nautilus-s3-24456"
  }
}

resource "aws_s3_bucket_acl" "s3_ran_bucket_acl" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_ran_bucket_versioning" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
```
