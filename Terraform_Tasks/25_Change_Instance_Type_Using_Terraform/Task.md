### Task : Change Instance Type Using Terraform

During the migration process, the Nautilus DevOps team created several EC2 instances in different regions. They are currently in the process of identifying the correct resources and utilization and are making continuous changes to ensure optimal resource utilization. Recently, they discovered that one of the EC2 instances was underutilized, prompting them to decide to change the instance type. Please make sure the Status check is completed (if it's still in Initializing state) before making any changes to the instance.

Change the instance type from t2.micro to t2.nano for datacenter-ec2 instance using terraform.

Make sure the EC2 instance datacenter-ec2 is in running state after the change.

The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to change the instance type.


### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate


bob@iac-server ~/terraform via 💠 default ✖ terraform state list
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-66282c1cb060deb9a"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform plan
aws_instance.ec2: Refreshing state... [id=i-735d4690491240840]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_instance.ec2 will be updated in-place
  ~ resource "aws_instance" "ec2" {
        id                                   = "i-735d4690491240840"
      ~ instance_type                        = "t2.micro" -> "t2.nano"
      ~ public_dns                           = "ec2-54-214-172-69.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "54.214.172.69" -> (known after apply)
        tags                                 = {
            "Name" = "datacenter-ec2"
        }
        # (34 unchanged attributes hidden)

        # (2 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions
if you run "terraform apply" now.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_instance.ec2: Refreshing state... [id=i-735d4690491240840]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_instance.ec2 will be updated in-place
  ~ resource "aws_instance" "ec2" {
        id                                   = "i-735d4690491240840"
      ~ instance_type                        = "t2.micro" -> "t2.nano"
      ~ public_dns                           = "ec2-54-214-172-69.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                            = "54.214.172.69" -> (known after apply)
        tags                                 = {
            "Name" = "datacenter-ec2"
        }
        # (34 unchanged attributes hidden)

        # (2 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.
aws_instance.ec2: Modifying... [id=i-735d4690491240840]
aws_instance.ec2: Still modifying... [id=i-735d4690491240840, 10s elapsed]
aws_instance.ec2: Still modifying... [id=i-735d4690491240840, 20s elapsed]
aws_instance.ec2: Modifications complete after 20s [id=i-735d4690491240840]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_instance.ec2


bob@iac-server ~/terraform via 💠 default ➜  cat main.tf
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-66282c1cb060deb9a"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
```

```
bob@iac-server ~/terraform via 💠 default ➜  history |cut -c 8-
pwd
ls
terraform stae list
terraform state list
cat main.tf 
vi main.tf 
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
```
