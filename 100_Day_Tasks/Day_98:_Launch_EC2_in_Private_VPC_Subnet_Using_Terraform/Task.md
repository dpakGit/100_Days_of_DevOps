### Task : Day_98:_Launch_EC2_in_Private_VPC_Subnet_Using_Terraform

The Nautilus DevOps team is expanding their AWS infrastructure and requires the setup of a private Virtual Private Cloud (VPC) along with a subnet. This VPC and subnet configuration will ensure that resources deployed within them remain isolated from external networks and can only communicate within the VPC. Additionally, the team needs to provision an EC2 instance under the newly created private VPC. This instance should be accessible only from within the VPC, allowing for secure communication and resource management within the AWS environment.

Create a VPC named xfusion-priv-vpc with the CIDR block 10.0.0.0/16.

Create a subnet named xfusion-priv-subnet inside the VPC with the CIDR block 10.0.1.0/24 and auto-assign IP option must not be enabled.

Create an EC2 instance named xfusion-priv-ec2 inside the subnet and instance type must be t2.micro.

Ensure the security group of the EC2 instance allows access only from within the VPC's CIDR block.

Create the main.tf file (do not create a separate .tf file) to provision the VPC, subnet and EC2 instance.

Use variables.tf file with the following variable names:

KKE_VPC_CIDR for the VPC CIDR block.
KKE_SUBNET_CIDR for the subnet CIDR block.
Use the outputs.tf file with the following variable names:

KKE_vpc_name for the name of the VPC.
KKE_subnet_name for the name of the subnet.
KKE_ec2_private for the name of the EC2 instance.

Notes:

The Terraform working directory is /home/bob/terraform.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.

### What I Did

Given your existing provider.tf file, you can create the VPC, subnet, and EC2 instance with the following configuration:

variables.tf

```
variable "KKE_VPC_CIDR" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "KKE_SUBNET_CIDR" {
  type        = string
  default     = "10.0.1.0/24"
}
```

main.tf

```
# Create VPC
resource "aws_vpc" "xfusion_priv_vpc" {
  cidr_block = var.KKE_VPC_CIDR
  tags = {
    Name = "xfusion-priv-vpc"
  }
}

# Create subnet
resource "aws_subnet" "xfusion_priv_subnet" {
  vpc_id            = aws_vpc.xfusion_priv_vpc.id
  cidr_block        = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false
  tags = {
    Name = "xfusion-priv-subnet"
  }
}

# Create security group
resource "aws_security_group" "xfusion_priv_sg" {
  vpc_id = aws_vpc.xfusion_priv_vpc.id
  name   = "xfusion-priv-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance
resource "aws_instance" "xfusion_priv_ec2" {
  ami           = "ami-12345678" # Replace with your desired AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.xfusion_priv_subnet.id
  vpc_security_group_ids = [aws_security_group.xfusion_priv_sg.id]
  tags = {
    Name = "xfusion-priv-ec2"
  }
}


outputs.tf

terraform
output "KKE_vpc_name" {
  value = aws_vpc.xfusion_priv_vpc.tags.Name
}

output "KKE_subnet_name" {
  value = aws_subnet.xfusion_priv_subnet.tags.Name
}

output "KKE_ec2_private" {
  value = aws_instance.xfusion_priv_ec2.tags.Name
}
```
Run the following commands to apply the configuration:


bash

terraform init

terraform plan

terraform apply


After applying the configuration, verify that the resources have been created successfully. Make sure to replace the AMI ID in the main.tf file with your desired AMI ID.

To ensure that terraform plan returns "No changes", run terraform apply again after the initial creation of resources. This will update the Terraform state file to match the current infrastructure configuration. Then, running terraform plan will show "No changes" if everything is up-to-date.
