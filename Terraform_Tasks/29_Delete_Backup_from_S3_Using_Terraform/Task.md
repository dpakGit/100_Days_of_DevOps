### Task : Delete Backup from S3 Using Terraform

The Nautilus DevOps team is currently engaged in a cleanup process, focusing on removing unnecessary data and services from their AWS account. As part of the migration process, several resources were created for one-time use only, necessitating a cleanup effort to optimize their AWS environment.

A S3 bucket named nautilus-bck-11477 already exists.

1) Copy the contents of nautilus-bck-11477 S3 bucket to /opt/s3-backup/ directory on terraform-client host (the landing host once you load this lab).

2) Delete the S3 bucket nautilus-bck-11477.

3) Use the AWS CLI through Terraform to accomplish this task—for example, by running AWS CLI commands within Terraform. The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to accomplish this task.

### What i did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Add your code below
bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.copy_s3_bucket will be created
  + resource "null_resource" "copy_s3_bucket" {
      + id = (known after apply)
    }

  # null_resource.delete_s3_bucket will be created
  + resource "null_resource" "delete_s3_bucket" {
      + id = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
null_resource.copy_s3_bucket: Creating...
null_resource.copy_s3_bucket: Provisioning with 'local-exec'...
null_resource.copy_s3_bucket (local-exec): Executing: ["/bin/sh" "-c" "aws s3 cp s3://nautilus-bck-11477 /opt/s3-backup/ --recursive"]
null_resource.copy_s3_bucket (local-exec): Completed 27 Bytes/27 Bytes (2.5 KiB/s) with 1 file(s) remaining
null_resource.copy_s3_bucket (local-exec): download: s3://nautilus-bck-11477/nautilus.txt to ../../../opt/s3-backup/nautilus.txt
null_resource.copy_s3_bucket: Creation complete after 0s [id=309913359753680840]
null_resource.delete_s3_bucket: Creating...
null_resource.delete_s3_bucket: Provisioning with 'local-exec'...
null_resource.delete_s3_bucket (local-exec): Executing: ["/bin/sh" "-c" "aws s3 rb s3://nautilus-bck-11477 --force"]
null_resource.delete_s3_bucket (local-exec): delete: s3://nautilus-bck-11477/nautilus.txt
null_resource.delete_s3_bucket (local-exec): remove_bucket: nautilus-bck-11477
null_resource.delete_s3_bucket: Creation complete after 1s [id=924379287046818540]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
null_resource.copy_s3_bucket
null_resource.delete_s3_bucket

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Add your code below
resource "null_resource" "copy_s3_bucket" {
  provisioner "local-exec" {
    command = "aws s3 cp s3://nautilus-bck-11477 /opt/s3-backup/ --recursive"
  }
}

resource "null_resource" "delete_s3_bucket" {
  provisioner "local-exec" {
    command = "aws s3 rb s3://nautilus-bck-11477 --force"
  }
  depends_on = [null_resource.copy_s3_bucket]
}
```

```
💠 default ➜  history | cut -c 8-
pwd
ls
cat main.tf 
vi main.tf 
terraform fmt
terraform init
terraform validate
terraform state list
ls
terraform apply -auto-approve
terraform state list
```
