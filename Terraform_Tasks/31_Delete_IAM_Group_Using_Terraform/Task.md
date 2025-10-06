### Task : Delete IAM Group Using Terraform

The Nautilus DevOps team is currently engaged in a cleanup process, focusing on removing unnecessary data and services from their AWS account. As part of the migration process, several resources were created for one-time use only, necessitating a cleanup effort to optimize their AWS environment.

Delete an IAM group named iamgroup_ravi using terraform. Make sure to keep the provisioning code, as we might need to provision this instance again later.

The Terraform working directory is /home/bob/terraform.

### What i did
```

bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate


bob@iac-server ~/terraform via 💠 default ✖ ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ✖ terraform state list
aws_iam_group.this

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_iam_group" "this" {
  name = "iamgroup_ravi"
}

bob@iac-server ~/terraform via 💠 default ➜  terraform destroy -target=aws_iam_group.this -auto-approve
aws_iam_group.this: Refreshing state... [id=iamgroup_ravi]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_iam_group.this will be destroyed
  - resource "aws_iam_group" "this" {
      - arn       = "arn:aws:iam::000000000000:group/iamgroup_ravi" -> null
      - id        = "iamgroup_ravi" -> null
      - name      = "iamgroup_ravi" -> null
      - path      = "/" -> null
      - unique_id = "sn3ix6ndqr6jy71c4e1e" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.
aws_iam_group.this: Destroying... [id=iamgroup_ravi]
aws_iam_group.this: Destruction complete after 0s
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

bob@iac-server ~/terraform via 💠 default ➜ 
```

