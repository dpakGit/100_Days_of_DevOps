### Task : Copy Data to S3 Using Terraform

The Nautilus DevOps team is presently immersed in data migrations, transferring data from on-premise storage systems to AWS S3 buckets. They have recently received some data that they intend to copy to one of the S3 buckets.

S3 bucket named xfusion-cp-16046 already exists. Copy the file /tmp/xfusion.txt to s3 bucket xfusion-cp-16046 using Terraform. The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to accomplish this task.

### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "xfusion-cp-16046"
  acl    = "private"

  tags = {
    Name        = "xfusion-cp-16046"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
main.tf
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
╷
│ Warning: Argument is deprecated
│ 
│   with aws_s3_bucket.my_bucket,
│   on main.tf line 3, in resource "aws_s3_bucket" "my_bucket":
│    3:   acl    = "private"
│ 
│ acl is deprecated. Use the aws_s3_bucket_acl resource instead.
╵
Success! The configuration is valid, but there were some validation warnings as shown above.


bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_s3_bucket.my_bucket: Refreshing state... [id=xfusion-cp-16046]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_object.xfusion_object will be created
  + resource "aws_s3_object" "xfusion_object" {
      + acl                    = (known after apply)
      + arn                    = (known after apply)
      + bucket                 = "xfusion-cp-16046"
      + bucket_key_enabled     = (known after apply)
      + checksum_crc32         = (known after apply)
      + checksum_crc32c        = (known after apply)
      + checksum_crc64nvme     = (known after apply)
      + checksum_sha1          = (known after apply)
      + checksum_sha256        = (known after apply)
      + content_type           = (known after apply)
      + etag                   = (known after apply)
      + force_destroy          = false
      + id                     = (known after apply)
      + key                    = "xfusion.txt"
      + kms_key_id             = (known after apply)
      + server_side_encryption = (known after apply)
      + source                 = "/tmp/xfusion.txt"
      + storage_class          = (known after apply)
      + tags_all               = (known after apply)
      + version_id             = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_s3_object.xfusion_object: Creating...
aws_s3_object.xfusion_object: Creation complete after 0s [id=xfusion.txt]
╷
│ Warning: Argument is deprecated
│ 
│   with aws_s3_bucket.my_bucket,
│   on main.tf line 3, in resource "aws_s3_bucket" "my_bucket":
│    3:   acl    = "private"
│ 
│ acl is deprecated. Use the aws_s3_bucket_acl resource instead.
│ 
│ (and one more similar warning elsewhere)
╵

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_s3_bucket.my_bucket
aws_s3_object.xfusion_object

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "xfusion-cp-16046"
  acl    = "private"

  tags = {
    Name = "xfusion-cp-16046"
  }
}

resource "aws_s3_object" "xfusion_object" {
  bucket = aws_s3_bucket.my_bucket.bucket # References the existing bucket's name
  key    = "xfusion.txt"                  # The name the file will have in S3
  source = "/tmp/xfusion.txt"             # The local path to the file
}

```

#### See the Warning part inside the apply command :

This is a common and important warning from recent versions of Terraform and the AWS provider.

The solution you provided is functionally correct for the task (it will upload the file), but you are encountering a warning because of a deprecation in the AWS provider.

⚠️ Deprecation Warning Explanation
The warning: acl is deprecated. Use the aws_s3_bucket_acl resource instead. means that the AWS provider for Terraform is moving towards a model where access control lists (ACLs) should be managed using a separate resource rather than directly within the aws_s3_bucket resource block.

This change encourages the use of the new S3 recommended practice of setting Bucket Ownership Controls and relying on IAM policies for access, but if ACLs are still required, they must be managed distinctly.

🛠️ How to Fix the Warning
To eliminate the warning, you should remove the acl = "private" line from the aws_s3_bucket resource and define the ACL using a new aws_s3_bucket_acl resource, keeping the ACL setting of "private" as required by the existing configuration.

Here is the updated, clean main.tf file:

```
resource "aws_s3_bucket" "my_bucket" {
  bucket = "xfusion-cp-16046"
  # acl = "private"  <-- REMOVED THIS LINE
  
  tags = {
    Name = "xfusion-cp-16046"
  }
}

# ADDED new resource to manage the ACL separately
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

resource "aws_s3_object" "xfusion_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "xfusion.txt"
  source = "/tmp/xfusion.txt"
}
```
By making this change, you address the deprecation warning while ensuring the bucket is still configured as "private," and the primary task (uploading the file) remains correct.
