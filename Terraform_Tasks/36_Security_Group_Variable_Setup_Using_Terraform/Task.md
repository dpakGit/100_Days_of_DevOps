### Task : Security Group Variable Setup Using Terraform

The Nautilus DevOps team is enhancing infrastructure automation and needs to provision a Security Group using Terraform with specific configurations.

For this task, create an AWS Security Group using Terraform with the following requirements:

The Security Group name datacenter-sg should be stored in a variable named KKE_sg.
Note:

1. The configuration values should be stored in a variables.tf file.

2. The Terraform script should be structured with a main.tf file referencing variables.tf.
The Terraform working directory is /home/bob/terraform.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi variables.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_security_group" "example" {
  name        = "datacenter-sg"
  description = "Security Group for datacenter"

  # Add your security group rules here
}


bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
terraformSuccess! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.example will be created
  + resource "aws_security_group" "example" {
      + arn                    = (known after apply)
      + description            = "Security Group for datacenter"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "datacenter-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_security_group.example: Creating...
aws_security_group.example: Creation complete after 2s [id=sg-c6f0f7416cbdd8dc1]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_security_group.example


bob@iac-server ~/terraform via 💠 default ➜  cat variables.tf 
variable "KKE_sg" {
  type        = string
  default     = "datacenter-sg"
  description = "Name of the Security Group"
}

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_security_group" "example" {
  name        = "datacenter-sg"
  description = "Security Group for datacenter"

  # Add your security group rules here
}

```
