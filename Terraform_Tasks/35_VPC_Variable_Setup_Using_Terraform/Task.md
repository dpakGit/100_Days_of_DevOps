### Task : VPC Variable Setup Using Terraform

The Nautilus DevOps team is automating VPC creation using Terraform to manage networking efficiently. As part of this task, they need to create a VPC with specific requirements.

For this task, create an AWS VPC using Terraform with the following requirements:

1. The VPC name xfusion-vpc should be stored in a variable named KKE_vpc.

2. The VPC should have a CIDR block of 10.0.0.0/16.

Note:

The configuration values should be stored in a variables.tf file.

The Terraform script should be structured with a main.tf file referencing variables.tf.

The Terraform working directory is /home/bob/terraform.

### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi variables.tf

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

  # aws_vpc.xfusion_vpc will be created
  + resource "aws_vpc" "xfusion_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "xfusion-vpc"
        }
      + tags_all                             = {
          + "Name" = "xfusion-vpc"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_vpc.xfusion_vpc: Creating...
aws_vpc.xfusion_vpc: Creation complete after 3s [id=vpc-e40453e4c08c087f9]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_vpc.xfusion_vpc

bob@iac-server ~/terraform via 💠 default ➜  cat variables.tf 
variable "KKE_vpc" {
  type        = string
  default     = "xfusion-vpc"
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 

resource "aws_vpc" "xfusion_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.KKE_vpc
  }
}
```
