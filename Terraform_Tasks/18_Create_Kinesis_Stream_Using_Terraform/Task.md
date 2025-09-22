### Task : Create Kinesis Stream Using Terraform

The Nautilus DevOps team needs to create an AWS Kinesis data stream for real-time data processing. This stream will be used to ingest and process large volumes of streaming data, which will then be consumed by various applications for analytics and real-time decision-making.

The stream should be named nautilus-stream.

Use Terraform to create this Kinesis stream.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

Note:

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.
Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.


### What I Did

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


bob@iac-server ~/terraform via 💠 default ➜  terraform plan

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_kinesis_stream.nautilus_stream will be created
  + resource "aws_kinesis_stream" "nautilus_stream" {
      + arn                       = (known after apply)
      + encryption_type           = "NONE"
      + enforce_consumer_deletion = false
      + id                        = (known after apply)
      + name                      = "nautilus-stream"
      + retention_period          = 24
      + shard_count               = 1
      + tags_all                  = (known after apply)

      + stream_mode_details (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan,
so Terraform can't guarantee to take exactly these
actions if you run "terraform apply" now.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_kinesis_stream.nautilus_stream will be created
  + resource "aws_kinesis_stream" "nautilus_stream" {
      + arn                       = (known after apply)
      + encryption_type           = "NONE"
      + enforce_consumer_deletion = false
      + id                        = (known after apply)
      + name                      = "nautilus-stream"
      + retention_period          = 24
      + shard_count               = 1
      + tags_all                  = (known after apply)

      + stream_mode_details (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_kinesis_stream.nautilus_stream: Creating...
aws_kinesis_stream.nautilus_stream: Still creating... [10s elapsed]
aws_kinesis_stream.nautilus_stream: Still creating... [20s elapsed]
aws_kinesis_stream.nautilus_stream: Creation complete after 20s [id=arn:aws:kinesis:us-east-1:000000000000:stream/nautilus-stream]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_kinesis_stream.nautilus_stream
```

💠➜  history
```
    1  pwd
    2  ls
    3  vi main.tf
    4  terraform fmt
    5  terraform init
    6  terraform validate
    7  terraform plan
    8  terraform apply -auto-approve
    9  terraform state list
   10  history
```
### main.tf 💠  ➜ 
```
# Create a Kinesis data stream
resource "aws_kinesis_stream" "nautilus_stream" {
  name        = "nautilus-stream"
  shard_count = 1
}
```


bob@iac-server ~/terraform via 💠 default ➜ 
