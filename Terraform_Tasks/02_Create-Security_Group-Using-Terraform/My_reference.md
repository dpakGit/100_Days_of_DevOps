The security group Terraform code you provided is almost correct. However, there's a small mistake in the protocol field for the HTTP ingress rule. The protocol should be "tcp" instead of "HTTP". Similarly, for the SSH ingress rule, the protocol should be "tcp" instead of "SSH" (although "tcp" is implied when specifying the port, it's more explicit).

Here's the corrected code:
```
terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ec2_sg" {
  name        = "devops-sg"
  description = "Security group for Nautilus App Servers"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-sg"
  }
}
```
Note that I also corrected the Name tag to simply "devops-sg" to match the security group name. The original code had a trailing hyphen, which might not be intended.

This code should create a security group named "devops-sg" in the default VPC of the us-east-1 region, with the specified ingress and egress rules. Make sure to run terraform init and terraform apply in the /home/bob/terraform directory to create the security group.



After creating the main.tf file, you should:

1. Run terraform init in the terminal to initialize the Terraform working directory. This command will download the necessary provider plugins (in this case, the AWS provider).

2. Run terraform plan to review the execution plan. This command will show you what resources Terraform will create or modify.

3. Run terraform apply to apply the configuration and create the security group. You will be prompted to confirm the changes.

Make sure to run these commands in the /home/bob/terraform directory where your main.tf file is located.

Here's a summary of the commands:

bash
terraform init
terraform plan
terraform apply

After running terraform apply, Terraform will create the security group with the specified configuration.


### To see what resources are created after running terraform apply, you can use the following command:

bash
terraform state list

This command will list all the resources that have been created and are being managed by Terraform.

If you want to see the details of a specific resource, you can use the following command:

bash
terraform state show <resource_name>

Replace <resource_name> with the actual name of the resource you want to view, such as aws_security_group.nautilus_sg.

For example:

bash
terraform state show aws_security_group.nautilus_sg

This will display the detailed configuration and attributes of the nautilus_sg security group.


### Yes, that's correct. When defining ingress rules in Terraform for AWS security groups, specifying the from_port and to_port numbers along with the protocol ("tcp" in this case) is sufficient.

The protocol and port numbers are used to determine the type of traffic allowed, so:

- Port 80 with protocol "tcp" implies HTTP traffic.
- Port 22 with protocol "tcp" implies SSH traffic.

You don't need to explicitly specify "HTTP" or "SSH" in the Terraform configuration. The configuration you provided earlier:
```
terraform
ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```
is enough to allow HTTP and SSH traffic, respectively.


