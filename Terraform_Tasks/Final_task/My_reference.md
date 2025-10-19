[19-Oct-25 9:35 AM] Deepak Ranjan Mishra: For this task, create a key pair using Terraform with the following requirements:

Name of the key pair should be nautilus-kp-t1q1.

Key pair type must be rsa.

The private key file should be saved under /home/bob.
The Terraform working directory is /home/bob/terraform/t1q1. Create the main.tf file (do not create a different .tf file) to accomplish this task.
[19-Oct-25 9:35 AM] Meta AI: Here's the main.tf file to create a key pair using Terraform:


terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "tls_private_key" "nautilus_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp-t1q1"
  public_key = tls_private_key.nautilus_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.nautilus_key.private_key_pem
  filename        = "/home/bob/nautilus-kp-t1q1.pem"
  file_permission = "0600"
}


Explanation:

- We use the tls_private_key resource to generate a private key with RSA algorithm.
- We then use the aws_key_pair resource to create a key pair in AWS with the generated public key.
- Finally, we use the local_file resource to save the private key to a file on the local system.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t1q1 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the key pair. Also, ensure you have the necessary AWS credentials configured on your system.

After running terraform apply, you should see a private key file named nautilus-kp-t1q1.pem in the /home/bob directory.
[19-Oct-25 9:44 AM] Deepak Ranjan Mishra: 2 / 10
Weight: 5
The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units.

For this task, create an EC2 instance using Terraform with the following requirements:

The name of the instance must be nautilus-ec2-t1q2.

Use the Amazon Linux ami-0c101f26f147fa7fd to launch this instance.

The Instance type must be t2.micro.

Create a new RSA key named nautilus-kp-t1q2.

Attach the default (available by default) security group.

The Terraform working directory is /home/bob/terraform/t1q2. Create the main.tf file (do not create a different .tf file) to provision the instance.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


'nautilus-ec2-t1q2' EC2 instance was created using 'terraform'?
[19-Oct-25 9:44 AM] Meta AI: Here's the main.tf file to create an EC2 instance using Terraform:


terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "tls_private_key" "nautilus_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp-t1q2"
  public_key = tls_private_key.nautilus_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.nautilus_key.private_key_pem
  filename        = "/home/bob/nautilus-kp-t1q2.pem"
  file_permission = "0600"
}

data "aws_security_group" "default_sg" {
  name = "default"
}

resource "aws_instance" "nautilus_ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.nautilus_kp.key_name
  vpc_security_group_ids = [data.aws_security_group.default_sg.id]

  tags = {
    Name = "nautilus-ec2-t1q2"
  }
}


Explanation:

- We use the tls_private_key resource to generate a private key with RSA algorithm.
- We then use the aws_key_pair resource to create a key pair in AWS with the generated public key.
- We use the local_file resource to save the private key to a file on the local system.
- We use the data block to fetch the default security group.
- Finally, we use the aws_instance resource to create an EC2 instance with the specified requirements.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t1q2 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the EC2 instance. Also, ensure you have the necessary AWS credentials configured on your system.

After running terraform apply, you should see a new EC2 instance named nautilus-ec2-t1q2 and a private key file named nautilus-kp-t1q2.pem in the /home/bob directory.
[19-Oct-25 9:51 AM] Deepak Ranjan Mishra: 3 / 10
Weight: 20
The kirsty DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

Create an IAM group named iamgroup_kirsty_t2q2 using terraform.

The Terraform working directory is /home/bob/terraform/t2q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.



IAM group 'iamgroup_kirsty_t2q2' has been created using 'terraform'?
[19-Oct-25 9:51 AM] Meta AI: Here's the main.tf file to create an IAM group using Terraform:


terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_iam_group" "kirsty_group" {
  name = "iamgroup_kirsty_t2q2"
}


Explanation:

- We specify the AWS provider and the region where we want to create the IAM group.
- We have a single resource aws_iam_group that creates an IAM group with the specified name.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t2q2 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the IAM group. Also, ensure you have the necessary AWS credentials configured on your system.

After running terraform apply, you should see a new IAM group named iamgroup_kirsty_t2q2 in your AWS account.
[19-Oct-25 9:56 AM] Deepak Ranjan Mishra: 4 / 10
Weight: 5
When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements:

For this task, create an IAM user named iamuser_kirsty_t2q1 using terraform. The Terraform working directory is /home/bob/terraform/t2q1. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


IAM user 'iamuser_kirsty_t2q1' has been created using 'terraform'?
[19-Oct-25 9:56 AM] Meta AI: Here's the main.tf file to create an IAM user using Terraform:


terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_iam_user" "kirsty_user" {
  name = "iamuser_kirsty_t2q1"
}


Explanation:

- We specify the AWS provider and the region where we want to create the IAM user.
- We have a single resource aws_iam_user that creates an IAM user with the specified name.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t2q1 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the IAM user. Also, ensure you have the necessary AWS Review the execution plan by running terraform plan.
4. Apply the configuration by running terraform apply.

After running terraform apply, you should see a new IAM user named iamuser_kirsty_t2q1 in your AWS account.
[19-Oct-25 10:00 AM] Deepak Ranjan Mishra: 5 / 10
Weight: 15
The Nautilus DevOps team needs to set up a DynamoDB table for storing user data. They need to create a DynamoDB table with the following specifications:

1) The table name should be nautilus-users-t3q1.

2) The primary key should be nautilus_id_t3q1 (String).

3) The table should use PAY_PER_REQUEST billing mode.

Use Terraform to create this DynamoDB table. The Terraform working directory is /home/bob/terraform/t3q1. Create the main.tf file (do not create a different .tf file) to create the DynamoDB table.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


DynamoDB table 'nautilus-users-t3q1' was created using 'Terraform' with 'PAY_PER_REQUEST' billing mode?
[19-Oct-25 10:00 AM] Meta AI: Here's the main.tf file to create a DynamoDB table using Terraform:


terraform
}

provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_dynamodb_table" "nautilus_users" {
  name           = "nautilus-users-t3q1"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "nautilus_id_t3q1"

  attribute {
    name = "nautilus_id_t3q1"
    type = "S"
  }
}


Explanation:

- We specify the AWS provider and the region where we want to create the DynamoDB table.
- We have a single resource aws_dynamodb_table that creates a DynamoDB table with the specified name, billing mode, and primary key.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t3q1 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the DynamoDB table. Also, ensure you have the necessary AWS credentials configured on your system.

After running terraform apply, you should see a new DynamoDB table named nautilus-users-t3q1 with the specified configuration.
[19-Oct-25 10:05 AM] Deepak Ranjan Mishra: 6 / 10
Weight: 10
The Nautilus DevOps team needs to create an AWS Kinesis data stream for real-time data processing. This stream will be used to ingest and process large volumes of streaming data, which will then be consumed by various applications for analytics and real-time decision-making.

The stream should be named nautilus-stream-t3q2.

Use Terraform to create this Kinesis stream.

The Terraform working directory is /home/bob/terraform/t3q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


AWS Kinesis stream 'nautilus-stream-t3q2' was created using 'Terraform'?
[19-Oct-25 10:05 AM] Meta AI: Here's the main.tf file to create a Kinesis stream using Terraform:


terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_kinesis_stream" "nautilus_stream" {
  name        = "nautilus-stream-t3q2"
  shard_count = 1
}


Explanation:

- We specify the AWS provider and the region where we want to create the Kinesis stream.
- We have a single resource aws_kinesis_stream that creates a Kinesis stream with the specified name and shard count.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t3q2 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

Make sure to replace your-region with the actual AWS region where you want to create the Kinesis stream. Also, ensure you have the necessary AWS credentials configured on your system.

After running terraform apply, you should see a new Kinesis stream named nautilus-stream-t3q2 in your AWS account.

Note that the shard count is set to 1 in this example. You can adjust the shard count based on your requirements. Each shard supports up to 1MB of data per second and 1,000 records per second for writes, and up to 2MB of data per second for reads. If you expect a higher data throughput, you may need to increase the shard count.
[19-Oct-25 10:08 AM] Deepak Ranjan Mishra: 7 / 10
Weight: 10
As part of the data migration process, the Nautilus DevOps team is actively creating several S3 buckets on AWS. They plan to utilize both private and public S3 buckets to store the relevant data. Given the ongoing migration of other infrastructure to AWS, it is logical to consolidate data storage within the AWS environment as well.

Create a public S3 bucket named nautilus-s3-12124-t4q2 using Terraform.

Ensure the bucket is accessible publicly once created by setting the proper ACL.

The Terraform working directory is /home/bob/terraform/t4q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Notes:

Create the resources only in the us-east-1 region.
Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.
The name of the S3 bucket should be based on nautilus-s3-12124-t4q2.
You can use the ACL settings to ensure the bucket is publicly accessible.

'nautilus-s3-12124-t4q2' Public S3 bucket was created using 'Terraform'?
[19-Oct-25 10:08 AM] Meta AI: Here's the main.tf file to create a public S3 bucket using Terraform:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "nautilus_bucket" {
  bucket = "nautilus-s3-12124-t4q2"
}

resource "aws_s3_bucket_acl" "nautilus_bucket_acl" {
  bucket = aws_s3_bucket.nautilus_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "nautilus_bucket_policy" {
  bucket = aws_s3_bucket.nautilus_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = "${aws_s3_bucket.nautilus_bucket.arn}/*"
      },
    ]
  })
}


Explanation:

- We specify the AWS provider and the region us-east-1 where we want to create the S3 bucket.
- We have three resources: aws_s3_bucket to create the S3 bucket, aws_s3_bucket_acl to set the ACL for public read access, and aws_s3_bucket_policy to define a bucket policy that allows public read access to objects in the bucket.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t4q2 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

After running terraform apply, you should see a new public S3 bucket named nautilus-s3-12124-t4q2 in your AWS account with public read access enabled.

Note that making an S3 bucket publicly accessible can pose security risks if not managed properly. Ensure that you only store publicly accessible data in this bucket and regularly review the bucket's configuration and contents.
[19-Oct-25 10:12 AM] Deepak Ranjan Mishra: 8 / 10
Weight: 10
As part of the data migration process, the Nautilus DevOps team is actively creating several S3 buckets on AWS using Terraform. They plan to utilize both private and public S3 buckets to store the relevant data. Given the ongoing migration of other infrastructure to AWS, it is logical to consolidate data storage within the AWS environment as well.

Create an S3 bucket using Terraform with the following details:

1) The name of the S3 bucket must be nautilus-s3-12124-t4q1.

2) The S3 bucket must block all public access, making it a private bucket.

The Terraform working directory is /home/bob/terraform/t4q1. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Notes:

Use Terraform to provision the S3 bucket.
Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.
Ensure the resources are created in the us-east-1 region.
The bucket must have block public access enabled to restrict any public access.

'nautilus-s3-12124-t4q1' private S3 bucket was created using 'terraform'?
[19-Oct-25 10:12 AM] Meta AI: Here's the main.tf file to create a private S3 bucket using Terraform:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "nautilus_bucket" {
  bucket = "nautilus-s3-12124-t4q1"
}

resource "aws_s3_bucket_public_access_block" "nautilus_bucket_block" {
  bucket = aws_s3_bucket.nautilus_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}


Explanation:

- We specify the AWS provider and the region us-east-1 where we want to create the S3 bucket.
- We have two resources: aws_s3_bucket to create the S3 bucket, and aws_s3_bucket_public_access_block to block all public access to the bucket.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t4q1 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

After running terraform apply, you should see a new private S3 bucket named nautilus-s3-12124-t4q1 in your AWS account with all public access blocked.

This configuration ensures that the bucket is not publicly accessible and can only be accessed through AWS credentials with the necessary permissions.
[19-Oct-25 10:16 AM] Deepak Ranjan Mishra: 9 / 10
Weight: 10
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

Create a VPC named nautilus-vpc-t5q2 in us-east-1 region with 192.168.0.0/24 IPv4 CIDR using terraform.


The Terraform working directory is /home/bob/terraform/t5q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


'nautilus-vpc-t5q2' was created using 'terraform'?
[19-Oct-25 10:16 AM] Meta AI: Here's the main.tf file to create a VPC using Terraform:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "nautilus_vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "nautilus-vpc-t5q2"
  }
}


Explanation:

- We specify the AWS provider and the region us-east-1 where we want to create the VPC.
- We have a single resource aws_vpc that creates a VPC with the specified IPv4 CIDR block and name.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t5q2 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

After running terraform apply, you should see a new VPC named nautilus-vpc-t5q2 in your AWS account with the specified IPv4 CIDR block.

Note that the IPv4 CIDR block 192.168.0.0/24 provides 256 IP addresses, which might be sufficient for small-scale deployments. However, for larger deployments or future growth, consider using a larger CIDR block.
[19-Oct-25 10:20 AM] Deepak Ranjan Mishra: 10 / 10
Weight: 5
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

For this task, create a VPC named nautilus-vpc-t5q3 in the us-east-1 region with the Amazon-provided IPv6 CIDR block using terraform.

The Terraform working directory is /home/bob/terraform/t5q3. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


'nautilus-vpc-t5q3' was created using 'terraform'?
[19-Oct-25 10:20 AM] Meta AI: Here's the main.tf file to create a VPC with an Amazon-provided IPv6 CIDR block using Terraform:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "nautilus_vpc" {
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "nautilus-vpc-t5q3"
  }
}


Explanation:

- We specify the AWS provider and the region us-east-1 where we want to create the VPC.
- We have a single resource aws_vpc that creates a VPC with an Amazon-provided IPv6 CIDR block.
- The assign_generated_ipv6_cidr_block attribute is set to true to automatically assign an IPv6 CIDR block from Amazon's pool.

Usage:

1. Initialize the Terraform working directory by running terraform init in the /home/bob/terraform/t5q3 directory.
2. Review the execution plan by running terraform plan.
3. Apply the configuration by running terraform apply.

After running terraform apply, you should see a new VPC named nautilus-vpc-t5q3 in your AWS account with an Amazon-provided IPv6 CIDR block.

Note that the IPv6 CIDR block is automatically assigned by AWS, and you can retrieve it using the aws_vpc resource's ipv6_cidr_block attribute if needed.
[19-Oct-25 10:23 AM] Deepak Ranjan Mishra: Plan: 1 to add, 0 to change, 0 to destroy.
aws_vpc.nautilus_vpc: Creating...
╷
│ Error: creating EC2 VPC: operation error EC2: CreateVpc, https response error StatusCode: 400, RequestID: 3cb9acca-b0eb-4454-b761-6d518f8b8c51, api error InvalidParameterValue: Value (None) for parameter cidrBlock is invalid. This is not a valid CIDR block.
│ 
│   with aws_vpc.nautilus_vpc,
│   on main.tf line 1, in resource "aws_vpc" "nautilus_vpc":
│    1: resource "aws_vpc" "nautilus_vpc" {
│ 
╵

bob@iac-server ~/terraform/t5q3 via 💠 default ✖
[19-Oct-25 10:23 AM] Meta AI: The error is due to the missing cidr_block attribute in the aws_vpc resource. When using assign_generated_ipv6_cidr_block, you still need to specify an IPv4 cidr_block.

Here's the corrected main.tf file:


terraform
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "nautilus_vpc" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "nautilus-vpc-t5q3"
  }
}


In this corrected version, I've added a cidr_block attribute with a valid IPv4 CIDR block (10.0.0.0/16). You can adjust this to any valid IPv4 CIDR block that suits your needs.

After making this change, run terraform apply again to create the VPC with both IPv4 and IPv6 CIDR blocks.


----------------------

### Result
<br><br>
<img width="1920" height="1080" alt="Screenshot (461)" src="https://github.com/user-attachments/assets/ca71498e-e9eb-4c54-9a7a-6eadf0aed797" />

<br><br>
<img width="1920" height="1080" alt="Screenshot (462)" src="https://github.com/user-attachments/assets/0b208954-08ca-4415-a775-5545a048b842" />

<br><br>
<img width="1920" height="1080" alt="Screenshot (465)" src="https://github.com/user-attachments/assets/7b2390a8-8481-4cd3-8117-ccc1d9981655" />

