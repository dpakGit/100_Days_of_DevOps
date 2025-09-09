### Task


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

  # aws_eip.nautilus_eip will be created
  + resource "aws_eip" "nautilus_eip" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + ipam_pool_id         = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "Name" = "nautilus-eip"
        }
      + tags_all             = {
          + "Name" = "nautilus-eip"
        }
      + vpc                  = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_eip.nautilus_eip: Creating...
aws_eip.nautilus_eip: Creation complete after 2s [id=eipalloc-16db7ac578f710f02]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜ terraforn state list

bob@iac-server ~/terraform via 💠 default ➜ terraform state show .....

```
### # main.tf
```
resource "aws_eip" "nautilus_eip" {
  domain = "vpc"
  tags = {
    Name = "nautilus-eip"
  }
}

```
bob@iac-server ~/terraform via 💠 default ➜  history | cut -c 8-
ls
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
terraform apply -auto-approve
history | cut -c 8-
