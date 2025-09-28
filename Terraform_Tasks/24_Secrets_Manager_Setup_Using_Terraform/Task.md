### Task : Secrets Manager Setup Using Terraform

The Nautilus DevOps team needs to store sensitive data securely using AWS Secrets Manager. They need to create a secret with the following specifications:

1) The secret name should be datacenter-secret.

2) The secret value should contain a key-value pair with username: admin and password: Namin123.

3) Use Terraform to create the secret in AWS Secrets Manager.

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

  # aws_secretsmanager_secret.datacenter_secret will be created
  + resource "aws_secretsmanager_secret" "datacenter_secret" {
      + arn                            = (known after apply)
      + force_overwrite_replica_secret = false
      + id                             = (known after apply)
      + name                           = "datacenter-secret"
      + name_prefix                    = (known after apply)
      + policy                         = (known after apply)
      + recovery_window_in_days        = 30
      + tags_all                       = (known after apply)

      + replica (known after apply)
    }

  # aws_secretsmanager_secret_version.datacenter_secret_version will be created
  + resource "aws_secretsmanager_secret_version" "datacenter_secret_version" {
      + arn                  = (known after apply)
      + has_secret_string_wo = (known after apply)
      + id                   = (known after apply)
      + secret_id            = (known after apply)
      + secret_string        = (sensitive value)
      + secret_string_wo     = (write-only attribute)
      + version_id           = (known after apply)
      + version_stages       = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
aws_secretsmanager_secret.datacenter_secret: Creating...
aws_secretsmanager_secret.datacenter_secret: Creation complete after 1s [id=arn:aws:secretsmanager:us-east-1:000000000000:secret:datacenter-secret-HxRROE]
aws_secretsmanager_secret_version.datacenter_secret_version: Creating...
aws_secretsmanager_secret_version.datacenter_secret_version: Creation complete after 0s [id=arn:aws:secretsmanager:us-east-1:000000000000:secret:datacenter-secret-HxRROE|terraform-20250928050112589200000002]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_secretsmanager_secret.datacenter_secret
aws_secretsmanager_secret_version.datacenter_secret_version
```

💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠

### 💠 main.tf 
```
resource "aws_secretsmanager_secret" "datacenter_secret" {
  name = "datacenter-secret"
}

resource "aws_secretsmanager_secret_version" "datacenter_secret_version" {
  secret_id = aws_secretsmanager_secret.datacenter_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
  })
}
```
