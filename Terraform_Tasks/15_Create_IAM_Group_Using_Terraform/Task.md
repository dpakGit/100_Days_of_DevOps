### Task :


### What I Did


bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "5.91.0"...
- Installing hashicorp/aws v5.91.0...
- Installed hashicorp/aws v5.91.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_group.siva_group will be created
  + resource "aws_iam_group" "siva_group" {
      + arn       = (known after apply)
      + id        = (known after apply)
      + name      = "iamgroup_siva"
      + path      = "/"
      + unique_id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_iam_group.siva_group: Creating...
aws_iam_group.siva_group: Creation complete after 1s [id=iamgroup_siva]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_iam_group.siva_group

bob@iac-server ~/terraform via 💠 default ➜  history
    1  pwd
    2  ls
    3  vi main.tf
    4  terraform fmt
    5  terraform init
    6  terraform validate
    7  terraform apply -auto-approve
    8  terraform state list
    9  history

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_iam_group" "siva_group" {
  name = "iamgroup_siva"
}


bob@iac-server ~/terraform via 💠 default ➜  
