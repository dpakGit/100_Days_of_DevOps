### Task
The Nautilus DevOps team is strategically planning the migration of a portion of their infrastructure to the AWS cloud. Acknowledging the magnitude of this endeavor, they have chosen to tackle the migration incrementally rather than as a single, massive transition. Their approach involves creating Virtual Private Clouds (VPCs) as the initial step, as they will be provisioning various services under different VPCs.

For this task, create a VPC named xfusion-vpc in the us-east-1 region with the Amazon-provided IPv6 CIDR block using terraform.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

---------------------------------------------------------

### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf


bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
main.tf
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.

bob@iac-server ~/terraform via 💠 default ➜  terraform plan

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_vpc.xfusion_vpc

bob@iac-server ~/terraform via 💠 default ➜  terraform state show aws_vpc.xfusion_vpc

# aws_vpc.xfusion_vpc:
resource "aws_vpc" "xfusion_vpc" {
    arn                                  = "arn:aws:ec2:us-east-1:000000000000:vpc/vpc-19027432b02b3668a"
    assign_generated_ipv6_cidr_block     = true
    cidr_block                           = "10.0.0.0/16"
    default_network_acl_id               = "acl-6265f9498ec64ca7f"
    default_route_table_id               = "rtb-a738fc3d65edf8534"
    default_security_group_id            = "sg-2e9bffd5dbd333859"
    dhcp_options_id                      = "default"
    enable_dns_hostnames                 = false
    enable_dns_support                   = true
    enable_network_address_usage_metrics = false
    id                                   = "vpc-19027432b02b3668a"
    instance_tenancy                     = "default"
    ipv6_association_id                  = "vpc-cidr-assoc-e00ac8b04f664ff83" # 💠 See this
    ipv6_cidr_block                      = "2400:6500:cdea:5500::/56"
    ipv6_cidr_block_network_border_group = null
    ipv6_ipam_pool_id                    = null
    ipv6_netmask_length                  = 0
    main_route_table_id                  = "rtb-a738fc3d65edf8534"
    owner_id                             = "000000000000"
    tags                                 = {
        "Name" = "xfusion-vpc"
    }
    tags_all                             = {
        "Name" = "xfusion-vpc"
    }
}

```

```
💠 history | cut -c 8-
pwd
ls
cat README.MD 
vi main.tf
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
terraform state show aws_vpc.xfusion_vpc
```

history | cut -c 8-

bob@iac-server ~/terraform via 💠 default ➜  
