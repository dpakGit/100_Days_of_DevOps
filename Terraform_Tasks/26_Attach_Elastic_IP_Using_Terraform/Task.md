### Task : Attach Elastic IP Using Terraform

The Nautilus DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

There is an instance named xfusion-ec2 and an elastic-ip named xfusion-ec2-eip in us-east-1 region. Attach the xfusion-ec2-eip elastic-ip to the xfusion-ec2 instance using Terraform only. The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to attach the specified Elastic IP to the instance.


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_eip.ec2_eip
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-fb9007fd735fa74f7"
  vpc_security_group_ids = [
    "sg-35d8340ec24ab9480"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "xfusion-ec2-eip"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 
 
bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform plan
aws_eip.ec2_eip: Refreshing state... [id=eipalloc-c743d3293e0600826]
aws_instance.ec2: Refreshing state... [id=i-318e32235eea5a530]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip_association.eip_assoc will be created
  + resource "aws_eip_association" "eip_assoc" {
      + allocation_id        = "eipalloc-c743d3293e0600826"
      + id                   = (known after apply)
      + instance_id          = "i-318e32235eea5a530"
      + network_interface_id = (known after apply)
      + private_ip_address   = (known after apply)
      + public_ip            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan,
so Terraform can't guarantee to take exactly these
actions if you run "terraform apply" now.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_eip.ec2_eip: Refreshing state... [id=eipalloc-c743d3293e0600826]
aws_instance.ec2: Refreshing state... [id=i-318e32235eea5a530]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip_association.eip_assoc will be created
  + resource "aws_eip_association" "eip_assoc" {
      + allocation_id        = "eipalloc-c743d3293e0600826"
      + id                   = (known after apply)
      + instance_id          = "i-318e32235eea5a530"
      + network_interface_id = (known after apply)
      + private_ip_address   = (known after apply)
      + public_ip            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_eip_association.eip_assoc: Creating...
aws_eip_association.eip_assoc: Creation complete after 0s [id=eipassoc-5f58cb54b476b5f58]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_eip.ec2_eip
aws_eip_association.eip_assoc
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-fb9007fd735fa74f7"
  vpc_security_group_ids = [
    "sg-35d8340ec24ab9480"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "xfusion-ec2-eip"
  }
}


# Associate Elastic IP with EC2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}
```

💠history | cut -c 8-
```
pwd
ls
terraform state list
cat main.tf 
vi main.tf 
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
cat main.tf 
history | cut -c 8-
```
