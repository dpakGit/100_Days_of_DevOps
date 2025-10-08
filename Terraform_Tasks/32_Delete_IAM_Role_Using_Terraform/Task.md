### Task : Delete IAM Role Using Terraform


### What I Did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  main.tf  provider.tf  terraform.tfstate

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_iam_role.role

bob@iac-server ~/terraform via 💠 default ➜  cat main.tf 
resource "aws_iam_role" "role" {
  name = "iamrole_ravi"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "iamrole_ravi"
  }
}
bob@iac-server ~/terraform via 💠 default ➜  terraform destroy -target=aws_iam_role.role -auto-approve
aws_iam_role.role: Refreshing state... [id=iamrole_ravi]

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_iam_role.role will be destroyed
  - resource "aws_iam_role" "role" {
      - arn                   = "arn:aws:iam::000000000000:role/iamrole_ravi" -> null
      - assume_role_policy    = jsonencode(
            {
              - Statement = [
                  - {
                      - Action    = "sts:AssumeRole"
                      - Effect    = "Allow"
                      - Principal = {
                          - Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - create_date           = "2025-10-08T06:19:13Z" -> null
      - force_detach_policies = false -> null
      - id                    = "iamrole_ravi" -> null
      - managed_policy_arns   = [] -> null
      - max_session_duration  = 3600 -> null
      - name                  = "iamrole_ravi" -> null
      - path                  = "/" -> null
      - tags                  = {
          - "Name" = "iamrole_ravi"
        } -> null
      - tags_all              = {
          - "Name" = "iamrole_ravi"
        } -> null
      - unique_id             = "AROAQAAAAAAAJATMVIEQM" -> null
        # (3 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 1 to destroy.
aws_iam_role.role: Destroying... [id=iamrole_ravi]
aws_iam_role.role: Destruction complete after 0s
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

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf        terraform.tfstate.backup
main.tf    terraform.tfstate

```
