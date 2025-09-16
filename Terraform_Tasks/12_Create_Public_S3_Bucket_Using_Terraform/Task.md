### Task : Create Public S3 Bucket Using Terraform

As part of the data migration process, the Nautilus DevOps team is actively creating several S3 buckets on AWS. They plan to utilize both private and public S3 buckets to store the relevant data. Given the ongoing migration of other infrastructure to AWS, it is logical to consolidate data storage within the AWS environment as well.

Create a public S3 bucket named xfusion-s3-7892 using Terraform.

Ensure the bucket is accessible publicly once created by setting the proper ACL.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Notes:

Create the resources only in the us-east-1 region.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

The name of the S3 bucket should be based on xfusion-s3-7892.

You can use the ACL settings to ensure the bucket is publicly accessible.



### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.xfusion_s3 will be created
  + resource "aws_s3_bucket" "xfusion_s3" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "xfusion-s3-7892"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket_acl.xfusion_acl will be created
  + resource "aws_s3_bucket_acl" "xfusion_acl" {
      + acl    = "public-read"
      + bucket = (known after apply)
      + id     = (known after apply)

      + access_control_policy (known after apply)
    }

  # aws_s3_bucket_public_access_block.block_public_access will be created
  + resource "aws_s3_bucket_public_access_block" "block_public_access" {
      + block_public_acls       = false
      + block_public_policy     = false
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = false
      + restrict_public_buckets = false
    }

Plan: 3 to add, 0 to change, 0 to destroy.
aws_s3_bucket.xfusion_s3: Creating...
aws_s3_bucket.xfusion_s3: Creation complete after 1s [id=xfusion-s3-7892]
aws_s3_bucket_public_access_block.block_public_access: Creating...
aws_s3_bucket_public_access_block.block_public_access: Creation complete after 0s [id=xfusion-s3-7892]
aws_s3_bucket_acl.xfusion_acl: Creating...
aws_s3_bucket_acl.xfusion_acl: Creation complete after 0s [id=xfusion-s3-7892,public-read]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_s3_bucket.xfusion_s3
aws_s3_bucket_acl.xfusion_acl
aws_s3_bucket_public_access_block.block_public_access
```

### # main.tf
```
resource "aws_s3_bucket" "xfusion_s3" {
  bucket = "xfusion-s3-7892"
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.xfusion_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "xfusion_acl" {
  depends_on = [aws_s3_bucket_public_access_block.block_public_access]

  bucket = aws_s3_bucket.xfusion_s3.id
  acl    = "public-read"
}
```

```
bob@iac-server ~/terraform via 💠 default ➜  history
    1  pwd
    2  ls
    3  vi main.tf
    4  terraform init
    5  terraform fmt
    6  terraform validate
    7  terraform apply -auto-approve
    8  terraform state list
    9  history
```












