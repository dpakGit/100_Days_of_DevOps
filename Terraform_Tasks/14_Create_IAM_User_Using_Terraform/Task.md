### Task : Create IAM User Using Terraform



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

  # aws_iam_user.iamuser_kirsty will be created
  + resource "aws_iam_user" "iamuser_kirsty" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "iamuser_kirsty"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_user.iamuser_kirsty: Creating...
aws_iam_user.iamuser_kirsty: Creation complete after 0s [id=iamuser_kirsty]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

```
💠 default ➜  history
    1  pwd
    2  ls
    3  vi main.tf
    4  terraform fmt
    5  terraform init
    6  terraform validate
    7  terraform apply -auto-approve
    8  history
```

### # main.tf 
```
# Configure the AWS Provider
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

# Create an IAM user
resource "aws_iam_user" "iamuser_kirsty" {
  name = "iamuser_kirsty"
}
```
 
