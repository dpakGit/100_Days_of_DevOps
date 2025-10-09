### Task : Delete VPC Using Terraform
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. They created some services in different regions and later found that some of those can be deleted now.

Delete a VPC named datacenter-vpc present in us-east-1 region using Terraform. Make sure to keep the provisioning code, as we might need to provision this instance again later.

The Terraform working directory is /home/bob/terraform.

### What I Did
```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf ^C

bob@iac-server ~/terraform via 💠 default ✖ cat main.tf 
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "datacenter-vpc"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_vpc.this

bob@iac-server ~/terraform via 💠 default ➜  terraform destroy -target=aws_vpc.this -auto-approve
aws_vpc.this: Refreshing state... [id=vpc-917a69243200d9075]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.this will be destroyed
  - resource "aws_vpc" "this" {
      - arn                                  = "arn:aws:ec2:us-east-1:000000000000:vpc/vpc-917a69243200d9075" -> null
      - assign_generated_ipv6_cidr_block     = false -> null
      - cidr_block                           = "10.0.0.0/16" -> null
      - default_network_acl_id               = "acl-4b8792775e1349f7e" -> null
      - default_route_table_id               = "rtb-68cfe06c07e3301ed" -> null
      - default_security_group_id            = "sg-c3c8b1b87b262ea63" -> null
      - dhcp_options_id                      = "default" -> null
      - enable_dns_hostnames                 = false -> null
      - enable_dns_support                   = true -> null
      - enable_network_address_usage_metrics = false -> null
      - id                                   = "vpc-917a69243200d9075" -> null
      - instance_tenancy                     = "default" -> null
      - ipv6_netmask_length                  = 0 -> null
      - main_route_table_id                  = "rtb-68cfe06c07e3301ed" -> null
      - owner_id                             = "000000000000" -> null
      - tags                                 = {
          - "Name" = "datacenter-vpc"
        } -> null
      - tags_all                             = {
          - "Name" = "datacenter-vpc"
        } -> null
        # (4 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 1 to destroy.
aws_vpc.this: Destroying... [id=vpc-917a69243200d9075]
aws_vpc.this: Destruction complete after 0s
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

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
```

