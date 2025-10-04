### Task : Delete EC2 Instance Using Terraform


### What I did

bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-3f4bff5ad87b82fb6"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_instance.ec2

bob@iac-server ~/terraform via 💠 default ➜  terraform destroy -target aws_instance.ec2
aws_instance.ec2: Refreshing state... [id=i-8b64d2dd476186214]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.ec2 will be destroyed
  - resource "aws_instance" "ec2" {
      - ami                                  = "ami-0c101f26f147fa7fd" -> null
      - arn                                  = "arn:aws:ec2:us-east-1::instance/i-8b64d2dd476186214" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "us-east-1a" -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-8b64d2dd476186214" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t2.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-3001ac986d033f70d" -> null
      - private_dns                          = "ip-10-72-226-3.ec2.internal" -> null
      - private_ip                           = "10.72.226.3" -> null
      - public_dns                           = "ec2-54-214-152-35.compute-1.amazonaws.com" -> null
      - public_ip                            = "54.214.152.35" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [
          - "default",
        ] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-0c419b5f6a663e98b" -> null
      - tags                                 = {
          - "Name" = "datacenter-ec2"
        } -> null
      - tags_all                             = {
          - "Name" = "datacenter-ec2"
        } -> null
      - tenancy                              = "default" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-3f4bff5ad87b82fb6",
        ] -> null
        # (8 unchanged attributes hidden)

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 0 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-dc45c8b13d9b18824" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
            # (1 unchanged attribute hidden)
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.
╷
│ Warning: Resource targeting is in effect
│ 
│ You are creating a plan with the -target option,
│ which means that the result of this plan may not
│ represent all of the changes requested by the current
│ configuration.
│ 
│ The -target option is not for routine use, and is
│ provided only for exceptional situations such as
│ recovering from errors or mistakes, or when Terraform
│ specifically suggests to use it as part of an error
│ message.
╵

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.ec2: Destroying... [id=i-8b64d2dd476186214]
aws_instance.ec2: Still destroying... [id=i-8b64d2dd476186214, 10s elapsed]
aws_instance.ec2: Destruction complete after 10s
╷
│ Warning: Applied changes may be incomplete
│ 
│ The plan was created with the -target option in
│ effect, so some changes requested in the
│ configuration may have been ignored and the output
│ values may not be fully updated. Run the following
│ command to verify that no other changes are pending:
│     terraform plan
│ 
│ Note that the -target option is not suitable for
│ routine use, and is provided only for exceptional
│ situations such as recovering from errors or
│ mistakes, or when Terraform specifically suggests to
│ use it as part of an error message.
╵

Destroy complete! Resources: 1 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-instances --filters "Name=tag:Name,Values=datacenter-ec2" --query 'Reservations[0].Instances[0].State.Name'
"terminated"

bob@iac-server ~/terraform via 💠 default ➜  terraform state list

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-3f4bff5ad87b82fb6"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  
