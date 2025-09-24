### Task : Create SSM Parameter Using Terraform

The Nautilus DevOps team needs to create an SSM parameter in AWS with the following requirements:

1) The name of the parameter should be datacenter-ssm-parameter.

2) Set the parameter type to String.

3) Set the parameter value to datacenter-value.

4) The parameter should be created in the us-east-1 region.

5) Ensure the parameter is successfully created using terraform and can be retrieved when the task is completed.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

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


bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_ssm_parameter.datacenter_ssm_parameter will be created
  + resource "aws_ssm_parameter" "datacenter_ssm_parameter" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + has_value_wo   = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "datacenter-ssm-parameter"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + value_wo       = (write-only attribute)
      + version        = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_ssm_parameter.datacenter_ssm_parameter: Creating...
aws_ssm_parameter.datacenter_ssm_parameter: Creation complete after 2s [id=datacenter-ssm-parameter]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_ssm_parameter.datacenter_ssm_parameter
```

### # History 
```
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
terraform apply -auto-approve
terraform state list
history | cut -c 8-
```

### #💠 main.tf 
```
resource "aws_ssm_parameter" "datacenter_ssm_parameter" {
  name  = "datacenter-ssm-parameter"
  type  = "String"
  value = "datacenter-value"
}
```
Let me explain what this code does:

- provider "aws": Specifies the AWS provider and the region where the resources will be created.
- resource "aws_ssm_parameter": Creates an SSM parameter resource.
- name, type, and value: Set the name, type, and value of the SSM parameter according to the requirements.


