Task-1

1 / 10
Weight: 10
The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task, create a key pair using Terraform with the following requirements:

Name of the key pair should be nautilus-kp-t1q1.

Key pair type must be rsa.

The private key file should be saved under /home/bob.
The Terraform working directory is /home/bob/terraform/t1q1. Create the main.tf file (do not create a different .tf file) to accomplish this task.

### main.tf

```
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
```
```

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  pwd
/home/bob/terraform/t1q1

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  ls
provider.tf

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  teffarorm fmt
bash: teffarorm: command not found

bob@iac-server ~/terraform/t1q1 via 💠 default ✖ 

bob@iac-server ~/terraform/t1q1 via 💠 default ✖ terraform fmt
provider.tf

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  terraform init
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "5.91.0"...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Installing hashicorp/aws v5.91.0...
- Installed hashicorp/aws v5.91.0 (signed by HashiCorp)
- Installing hashicorp/tls v4.1.0...
- Installed hashicorp/tls v4.1.0 (signed by HashiCorp)
- Installing hashicorp/local v2.5.3...
- Installed hashicorp/local v2.5.3 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform/t1q1 via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_key_pair.nautilus_kp will be created
  + resource "aws_key_pair" "nautilus_kp" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "nautilus-kp-t1q1"
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
      + filename             = "/home/bob/nautilus-kp-t1q1.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.nautilus_key will be created
  + resource "tls_private_key" "nautilus_key" {
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

Plan: 3 to add, 0 to change, 0 to destroy.
tls_private_key.nautilus_key: Creating...
tls_private_key.nautilus_key: Creation complete after 0s [id=a771d9243b210f5dbc35e0da592d8fa24683ce78]
local_file.private_key: Creating...
local_file.private_key: Creation complete after 0s [id=ca66b824e7d5320042335688e59dc7d061b058b3]
aws_key_pair.nautilus_kp: Creating...
aws_key_pair.nautilus_kp: Creation complete after 0s [id=nautilus-kp-t1q1]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  terraform state list
aws_key_pair.nautilus_kp
local_file.private_key
tls_private_key.nautilus_key

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  pwd
/home/bob/terraform/t1q1

bob@iac-server ~/terraform/t1q1 via 💠 default ➜  cd ..

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD    t1q2  t2q1  t2q4  t3q3  t4q2  t5q1  t5q4
provider.tf  t1q3  t2q2  t3q1  t3q4  t4q3  t5q2
t1q1         t1q4  t2q3  t3q2  t4q1  t4q4  t5q3

bob@iac-server ~/terraform via 💠 default ➜  cd ..

bob@iac-server ~ ➜  pwd
/home/bob

bob@iac-server ~ ➜  ls
nautilus-kp-t1q1.pem  terraform

bob@iac-server ~ ➜  
```

### Task -2 

2 / 10
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

#### main.tf
```
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
```
### Task - 3

3 / 10
Weight: 20
The kirsty DevOps team has been creating a couple of services on AWS cloud. They have been breaking down the migration into smaller tasks, allowing for better control, risk mitigation, and optimization of resources throughout the migration process. Recently they came up with requirements mentioned below.

Create an IAM group named iamgroup_kirsty_t2q2 using terraform.

The Terraform working directory is /home/bob/terraform/t2q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.



IAM group 'iamgroup_kirsty_t2q2' has been created using 'terraform'?

#### main.tf
```
terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

resource "aws_iam_group" "kirsty_group" {
  name = "iamgroup_kirsty_t2q2"
}
```
### Task -4

4 / 10
Weight: 5
When establishing infrastructure on the AWS cloud, Identity and Access Management (IAM) is among the first and most critical services to configure. IAM facilitates the creation and management of user accounts, groups, roles, policies, and other access controls. The Nautilus DevOps team is currently in the process of configuring these resources and has outlined the following requirements:

For this task, create an IAM user named iamuser_kirsty_t2q1 using terraform. The Terraform working directory is /home/bob/terraform/t2q1. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


IAM user 'iamuser_kirsty_t2q1' has been created using 'terraform'?

#### main.tf
```
resource "aws_iam_user" "kirsty_user" {
  name = "iamuser_kirsty_t2q1"
}
```
### Task -5

5 / 10
Weight: 15
The Nautilus DevOps team needs to set up a DynamoDB table for storing user data. They need to create a DynamoDB table with the following specifications:

1) The table name should be nautilus-users-t3q1.

2) The primary key should be nautilus_id_t3q1 (String).

3) The table should use PAY_PER_REQUEST billing mode.

Use Terraform to create this DynamoDB table. The Terraform working directory is /home/bob/terraform/t3q1. Create the main.tf file (do not create a different .tf file) to create the DynamoDB table.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


DynamoDB table 'nautilus-users-t3q1' was created using 'Terraform' with 'PAY_PER_REQUEST' billing mode?

#### main.tf
```

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
```

### Task - 6
6 / 10
Weight: 10
The Nautilus DevOps team needs to create an AWS Kinesis data stream for real-time data processing. This stream will be used to ingest and process large volumes of streaming data, which will then be consumed by various applications for analytics and real-time decision-making.

The stream should be named nautilus-stream-t3q2.

Use Terraform to create this Kinesis stream.

The Terraform working directory is /home/bob/terraform/t3q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


AWS Kinesis stream 'nautilus-stream-t3q2' was created using 'Terraform'?

#### main.tf
```
resource "aws_kinesis_stream" "nautilus_stream" {
  name        = "nautilus-stream-t3q2"
  shard_count = 1
}
```

### Task - 7

7 / 10
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

#### main.tf

```
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
```

### Task - 8

8 / 10
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

### main.tf

```
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
```

### Task - 9

9 / 10
Weight: 10
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

Create a VPC named nautilus-vpc-t5q2 in us-east-1 region with 192.168.0.0/24 IPv4 CIDR using terraform.


The Terraform working directory is /home/bob/terraform/t5q2. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


'nautilus-vpc-t5q2' was created using 'terraform'?



#### main.tf
```
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
```

### Task - 10
10 / 10
Weight: 5
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

For this task, create a VPC named nautilus-vpc-t5q3 in the us-east-1 region with the Amazon-provided IPv6 CIDR block using terraform.

The Terraform working directory is /home/bob/terraform/t5q3. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


'nautilus-vpc-t5q3' was created using 'terraform'?

#### main.tf
```
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
```
