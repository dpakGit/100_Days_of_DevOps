### Task : Day 95: Create Security Group Using Terraform

Use Terraform to create a security group under the default VPC with the following requirements:

1) The name of the security group must be devops-sg.

2) The description must be Security group for Nautilus App Servers.

3) Add an inbound rule of type HTTP, with a port range of 80, and source CIDR range 0.0.0.0/0.

4) Add another inbound rule of type SSH, with a port range of 22, and source CIDR range 0.0.0.0/0.

Ensure that the security group is created in the us-east-1 region using Terraform. The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


### What I Did

Here is the Terraform configuration to create the security group:

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Security group for Nautilus App Servers"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  }

  tags = {
    Name = "devops-sg"
  }
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
```
Let me explain what this configuration does:

- We specify the AWS provider and the region where we want to create the security group.
- We define a security group resource named devops_sg with the specified name and description.
- We add two ingress rules to the security group: one for HTTP traffic on port 80 and another for SSH traffic on port 22. Both rules allow traffic from anywhere (0.0.0.0/0).
- We use the aws_default_vpc resource to get the ID of the default VPC in the specified region.

To create the security group, follow these steps:

1. Open the terminal in VS Code by right-clicking under the EXPLORER section and selecting Open in Integrated Terminal.
2. Navigate to the Terraform working directory: cd /home/bob/terraform
3. Create a new file named main.tf and paste the above configuration into it.
4. Initialize the Terraform working directory by running terraform init.
5. Apply the configuration by running terraform apply. Review the plan and type yes to create the security group.

The security group will be created in the us-east-1 region with the specified configuration.
