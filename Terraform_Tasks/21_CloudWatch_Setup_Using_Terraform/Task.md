### Task : CloudWatch Setup Using Terraform


### What I did

```
bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls
README.MD  provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
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

  # aws_cloudwatch_log_group.xfusion_log_group will be created
  + resource "aws_cloudwatch_log_group" "xfusion_log_group" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + log_group_class   = (known after apply)
      + name              = "xfusion-log-group"
      + name_prefix       = (known after apply)
      + retention_in_days = 0
      + skip_destroy      = false
      + tags_all          = (known after apply)
    }

  # aws_cloudwatch_log_stream.xfusion_log_stream will be created
  + resource "aws_cloudwatch_log_stream" "xfusion_log_stream" {
      + arn            = (known after apply)
      + id             = (known after apply)
      + log_group_name = "xfusion-log-group"
      + name           = "xfusion-log-stream"
    }

Plan: 2 to add, 0 to change, 0 to destroy.
aws_cloudwatch_log_group.xfusion_log_group: Creating...
aws_cloudwatch_log_group.xfusion_log_group: Creation complete after 0s [id=xfusion-log-group]
aws_cloudwatch_log_stream.xfusion_log_stream: Creating...
aws_cloudwatch_log_stream.xfusion_log_stream: Creation complete after 0s [id=xfusion-log-stream]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

 ➜ 💠 history
```
    1  pwd
    2  ls
    3  vi main.tf
    4  terraform fmt
    5  terraform init
    6  terraform validate
    7  terraform applu -auto-approve
    8  ls
    9  terraform apply -auto-approve
   10  history
```

### # main.tf 
```
resource "aws_cloudwatch_log_group" "xfusion_log_group" {
  name = "xfusion-log-group"
}

resource "aws_cloudwatch_log_stream" "xfusion_log_stream" {
  name           = "xfusion-log-stream"
  log_group_name = aws_cloudwatch_log_group.xfusion_log_group.name
}
```

