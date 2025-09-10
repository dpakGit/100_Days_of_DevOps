### Task
The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

For this task, create an EC2 instance using Terraform with the following requirements:

The name of the instance must be nautilus-ec2.

Use the Amazon Linux ami-0c101f26f147fa7fd to launch this instance.

The Instance type must be t2.micro.

Create a new RSA key named nautilus-kp.

Attach the default (available by default) security group.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to provision the instance.



### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
main.tf
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init


bob@iac-server ~/terraform via 💠 default ✖ vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
╷
│ Error: Invalid function argument
│ 
│   on main.tf line 3, in resource "aws_key_pair" "nautilus_kp":
│    3:   public_key = file("/home/bob/.ssh/id_rsa.pub") 
│     ├────────────────
│     │ while calling file(path)
│ 
│ Invalid value for "path" parameter: no file exists at
│ "/home/bob/.ssh/id_rsa.pub"; this function works only
│ with files that are distributed as part of the
│ configuration source code, so if this file will be
│ created by a resource in this configuration you must
│ instead obtain this result from an attribute of that
│ resource.
╵

bob@iac-server ~/terraform via 💠 default ✖ vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
╷
│ Error: Missing required provider
│ 
│ This configuration requires provider registry.terraform.io/hashicorp/local, but that provider isn't available.
│ You may be able to install it automatically by running:
│   terraform init
╵
╷
│ Error: Missing required provider
│ 
│ This configuration requires provider registry.terraform.io/hashicorp/tls, but that provider isn't available. You
│ may be able to install it automatically by running:
│   terraform init
╵

bob@iac-server ~/terraform via 💠 default ✖ ls
README.MD  main.tf  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

# Note: Once you make some changes to the main.tf file after the terraform init command the again run the init command


bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ✖ terraform apply -auto-approve
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 2s [id=vpc-799af0574631e16b9]
data.aws_security_group.default: Reading...
data.aws_security_group.default: Read complete after 0s [id=sg-161847ffbe03f3f86]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.nautilus_ec2 will be created
  + resource "aws_instance" "nautilus_ec2" {
      + ami                                  = "ami-0c101f26f147fa7fd"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "nautilus-kp"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "nautilus-ec2"
        }
      + tags_all                             = {
          + "Name" = "nautilus-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = [
          + "sg-161847ffbe03f3f86",
        ]

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_key_pair.nautilus_kp will be created
  + resource "aws_key_pair" "nautilus_kp" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "nautilus-kp"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # local_file.private_key will be created
  + resource "local_file" "private_key" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "./nautilus-kp.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.nautilus_kp will be created
  + resource "tls_private_key" "nautilus_kp" {
      + algorithm                     = "RSA"
      + ecdsa_curve                   = "P224"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 4096
    }

Plan: 4 to add, 0 to change, 0 to destroy.
tls_private_key.nautilus_kp: Creating...
tls_private_key.nautilus_kp: Creation complete after 1s [id=6bb97ea537c1ce91e21854d71fa65b1a26a296f8]
local_file.private_key: Creating...
local_file.private_key: Creation complete after 0s [id=923f7e0f3b7fd81c0607868b1b2c5f9e2a9b5544]
aws_key_pair.nautilus_kp: Creating...
aws_key_pair.nautilus_kp: Creation complete after 0s [id=nautilus-kp]
aws_instance.nautilus_ec2: Creating...
aws_instance.nautilus_ec2: Still creating... [10s elapsed]
aws_instance.nautilus_ec2: Creation complete after 10s [id=i-e6a5962b8f9653973]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
data.aws_security_group.default
data.aws_vpc.default
aws_instance.nautilus_ec2
aws_key_pair.nautilus_kp
local_file.private_key
tls_private_key.nautilus_kp

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  nautilus-kp.pem  provider.tf  terraform.tfstate

# Above files nautilus-kp.pem and terraform.tfstate are cfreated after the apply command

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
```
### # main.tf

```
resource "tls_private_key" "nautilus_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_kp.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.nautilus_kp.private_key_pem
  filename        = "${path.module}/nautilus-kp.pem"
  file_permission = "0600"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "nautilus_ec2" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.nautilus_kp.key_name
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "nautilus-ec2"
  }
}
```

```
bob@iac-server ~/terraform via 💠 default ➜  history | cut -c 8-
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
vi main.tf
terraform validate
vi main.tf 
terraform fmt
terraform validate
ls
terraform init
terraform validate
terraform apply - auto-approve
terraform apply -auto-approve
terraform state list
history | cut -c 8-


```
### Troubleshoot


bob@iac-server ~/terraform via 💠 default ➜  terraform validate
╷
│ Error: Invalid function argument
│ 
│   on main.tf line 3, in resource "aws_key_pair" "nautilus_kp":
│    3:   public_key = file("~/.ssh/id_rsa.pub") # Use an existing public key or generate a new one
│     ├────────────────
│     │ while calling file(path)
│ 
│ Invalid value for "path" parameter: no file exists at
│ "~/.ssh/id_rsa.pub"; this function works only with
│ files that are distributed as part of the
│ configuration source code, so if this file will be
│ created by a resource in this configuration you must
│ instead obtain this result from an attribute of that
│ resource.
╵


Solution:

The error message indicates that Terraform is missing the required providers local and tls. To fix this, you can run terraform init, which will initialize the Terraform working directory and install the necessary providers.

Run the following command:


bash
terraform init


After running terraform init, you should be able to validate your Terraform configuration using:


bash
terraform validate


If you want to specify the required providers explicitly, you can add the following code to your provider.tf file:


terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0"
    }
  }
}


Then, run terraform init to install the providers.
