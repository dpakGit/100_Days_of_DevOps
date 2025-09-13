### Task :

The Nautilus DevOps team has some volumes in different regions in their AWS account. They are going to setup some automated backups so that all important data can be backed up on regular basis. For now they shared some requirements to take a snapshot of one of the volumes they have.

Create a snapshot of an existing volume named datacenter-vol in us-east-1 region using terraform.

1) The name of the snapshot must be datacenter-vol-ss.

2) The description must be Datacenter Snapshot.

3) Make sure the snapshot status is completed before submitting the task.

The Terraform working directory is /home/bob/terraform. Update the main.tf file (do not create a separate .tf file) to accomplish this task.


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  terraform state list # To verify existing resources
aws_ebs_volume.k8s_volume

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-volumes # Commnad to get the volume id
{
    "Volumes": [
        {
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "datacenter-vol"
                }
            ],
            "VolumeType": "gp2",
            "VolumeId": "vol-ca28195c4cf4df9dd",
            "Size": 5,
            "SnapshotId": "",
            "AvailabilityZone": "us-east-1a",
            "State": "available",
            "CreateTime": "2025-09-13T06:26:48Z",
            "Attachments": [],
            "Encrypted": false
        }
    ]
}

# Now add the snapshot code block to the main.tf file

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 
 
bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
main.tf
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve
aws_ebs_volume.k8s_volume: Refreshing state... [id=vol-ca28195c4cf4df9dd]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_ebs_snapshot.datacenter_snapshot will be created
  + resource "aws_ebs_snapshot" "datacenter_snapshot" {
      + arn                    = (known after apply)
      + data_encryption_key_id = (known after apply)
      + description            = "Datacenter Snapshot"
      + encrypted              = (known after apply)
      + id                     = (known after apply)
      + kms_key_id             = (known after apply)
      + owner_alias            = (known after apply)
      + owner_id               = (known after apply)
      + storage_tier           = (known after apply)
      + tags                   = {
          + "Name" = "datacenter-vol-ss"
        }
      + tags_all               = {
          + "Name" = "datacenter-vol-ss"
        }
      + volume_id              = "vol-ca28195c4cf4df9dd"
      + volume_size            = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_ebs_snapshot.datacenter_snapshot: Creating...
aws_ebs_snapshot.datacenter_snapshot: Creation complete after 0s [id=snap-26b2ff5a5a5deb4ab]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.


bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_ebs_snapshot.datacenter_snapshot
aws_ebs_volume.k8s_volume

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-snapshots --filters Name=tag:Name,Values=datacenter-vol-ss
{
    "Snapshots": [
        {
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "datacenter-vol-ss"
                }
            ],
            "SnapshotId": "snap-26b2ff5a5a5deb4ab",
            "VolumeId": "vol-ca28195c4cf4df9dd",
            "State": "completed",
            "StartTime": "2025-09-13T06:47:36Z",
            "Progress": "100%",
            "OwnerId": "000000000000",
            "Description": "Datacenter Snapshot",
            "VolumeSize": 5,
            "Encrypted": false
        }
    ]
}

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-snapshots --filters Name=tag:Name,Values=datacenter-vol-ss --query 'Snapshots[].State'
[
    "completed"
]

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_ebs_snapshot.datacenter_snapshot
aws_ebs_volume.k8s_volume

```
### # Existing ebs volume code
```
  availability_zone = "us-east-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name        = "datacenter-vol"
  }
}
```
### # Updated main.tf file after adding the Snapshot code
```
resource "aws_ebs_volume" "k8s_volume" {
  availability_zone = "us-east-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name = "datacenter-vol"
  }
}

#`````````````````````````````````````

# Snapshot code added later
resource "aws_ebs_snapshot" "datacenter_snapshot" {
  volume_id   = "vol-ca28195c4cf4df9dd"
  description = "Datacenter Snapshot"

  tags = {
    Name = "datacenter-vol-ss"
  }
}

```
