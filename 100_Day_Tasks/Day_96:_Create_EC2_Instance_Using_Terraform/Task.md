### Tssk : Day 96: Create EC2 Instance Using Terraform

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

For this task, create an EC2 instance using Terraform with the following requirements:

The name of the instance must be datacenter-ec2.

Use the Amazon Linux ami-0c101f26f147fa7fd to launch this instance.

The Instance type must be t2.micro.

Create a new RSA key named datacenter-kp.

Attach the default (available by default) security group.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to provision the instance.

### What I Did

Here's the main.tf file that creates an EC2 instance with the specified requirements:

```
terraform
provider "aws" {
  region = "us-west-2" # You can change this to your desired region
}

resource "aws_key_pair" "datacenter_kp" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.datacenter_kp.public_key_openssh
}

resource "tls_private_key" "datacenter_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.datacenter_kp.private_key_pem
  filename        = "${path.module}/datacenter-kp.pem"
  file_permission = "0600"
}

resource "aws_instance" "datacenter_ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.datacenter_kp.key_name

  tags = {
    Name = "datacenter-ec2"
  }

  vpc_security_group_ids = [aws_default_security_group.default.id]
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id
}

resource "aws_default_vpc" "default" {
}
```

However, it's generally not recommended to use the default security group and VPC for production environments. Consider creating your own security group and VPC with specific rules.

To create the resources, navigate to the /home/bob/terraform directory and run the following commands:


bash

terraform init

terraform apply


After running terraform apply, Terraform will create the EC2 instance and other resources. Make sure you have the necessary AWS credentials configured on your machine.

Note that the private key will be saved to a file named datacenter-kp.pem in the /home/bob/terraform directory. You can use this key to SSH into your EC2 instance. The public key is attached to the instance.

Please be aware that storing sensitive data like private keys in plain text can be a security risk. Consider using a secrets manager or other secure storage solutions in production environments.
