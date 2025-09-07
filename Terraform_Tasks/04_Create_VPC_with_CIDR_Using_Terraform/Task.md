### Task


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
provider.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform validate
Success! The configuration is valid.

bob@iac-server ~/terraform via 💠 default ➜  terraform plan

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

# Once the VPC is created, you can verify its existence by using the following AWS CLI command

bob@iac-server ~/terraform via 💠 default ➜  aws ec2 describe-vpcs --filters "Name=tag:Name,Values=datacenter-vpc"

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_vpc.datacenter_vpc

bob@iac-server ~/terraform via 💠 default ➜  terraform state show aws_vpc.datacenter_vpc
```

```
 history | cut -c 8-
pwd
ls
vi main.tf
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply -auto-approve
# Once the VPC is created, you can verify its existence  by using the AWS CLI command
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=datacenter-vpc"
terraform state list
terraform state show aws_vpc.datacenter_vpc
history | cut -c 8-
```
