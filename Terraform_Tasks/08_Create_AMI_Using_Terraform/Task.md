### Task

The Nautilus DevOps team is strategizing the migration of a portion of their infrastructure to the AWS cloud. Recognizing the scale of this undertaking, they have opted to approach the migration in incremental steps rather than as a single massive transition. To achieve this, they have segmented large tasks into smaller, more manageable units. This granular approach enables the team to execute the migration in gradual phases, ensuring smoother implementation and minimizing disruption to ongoing operations. By breaking down the migration into smaller tasks, the Nautilus DevOps team can systematically progress through each stage, allowing for better control, risk mitigation, and optimization of resources throughout the migration process.

For this task, create an AMI from an existing EC2 instance named devops-ec2 using Terraform.

Name of the AMI should be devops-ec2-ami, make sure AMI is in available state.

The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to create the AMI.

Note: Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf # this will disply the existing ec2 code
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-470bc7c774e465d2f"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 

# Add the following code to the main.tf . Scroll down to seee the updated main.tf file
---------------------
# Create AMI from existing EC2 instance
resource "aws_ami_from_instance" "devops_ec2_ami" {
  name               = "devops-ec2-ami"
  source_instance_id = aws_instance.ec2.id
}
----------------------------

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ✖ terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_ami_from_instance.devops_ec2_ami
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-images --filters "Name=name,Values=devops-ec2-ami"
{
    "Images": [
        {
            "BlockDeviceMappings": [
                {
                    "Ebs": {
                        "DeleteOnTermination": false,
                        "SnapshotId": "snap-cc42f7a7eb9a9ecf1",
                        "VolumeSize": 15,
                        "VolumeType": "standard"
                    },
                    "DeviceName": "/dev/sda1"
                }
            ],
            "Description": "",
            "Name": "devops-ec2-ami",
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "standard",
            "Tags": [],
            "VirtualizationType": "paravirtual",
            "BootMode": "uefi",
            "SourceInstanceId": "i-b6983e6adab81acc8",
            "ImageId": "ami-f7c875646685efa65",
            "State": "available",
            "OwnerId": "000000000000",
            "CreationDate": "2025-09-11T05:32:25.000Z",
            "Public": false,
            "ProductCodes": [],
            "Architecture": "x86_64",
            "ImageType": "machine"
        }
    ]
}


# The above output shows that the AMI devops-ec2-ami has been successfully created and is in the available state.

Here are some key details from the output:

- Image ID: ami-f7c875646685efa65
- State: available
- Name: devops-ec2-ami
- Source Instance ID: i-b6983e6adab81acc8 (matches the ID of your devops-ec2 instance)
- Creation Date: 2025-09-11T05:32:25.000Z
- Owner ID: 000000000000 (your AWS account ID)

The output confirms that the AMI is ready for use. You can now use this AMI to launch new EC2 instances or share it with other AWS accounts if needed.
```

### # New main.tf
```
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-470bc7c774e465d2f"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

# Create AMI from existing EC2 instance
resource "aws_ami_from_instance" "devops_ec2_ami" {
  name               = "devops-ec2-ami"
  source_instance_id = aws_instance.ec2.id
}
```

```
bob@iac-server ~/terraform via 💠 default ➜  history | cut -c 8-
pwd
ls
cat main.tf 
terraform state list
vi main.tf 
terraform fmt
terraform i nit
terraform init
terraform validate
terraform apply -auto-approve
terraform state list
aws ec2 describe-images --filters "Name=name,Values=devops-ec2-ami"
```
