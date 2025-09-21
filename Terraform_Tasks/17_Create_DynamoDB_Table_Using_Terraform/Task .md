### Task : Create DynamoDB Table Using Terraform
The Nautilus DevOps team needs to set up a DynamoDB table for storing user data. They need to create a DynamoDB table with the following specifications:

1) The table name should be datacenter-users.

2) The primary key should be datacenter_id (String).

3) The table should use PAY_PER_REQUEST billing mode.


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

bob@iac-server ~/terraform via 💠 default ➜  terraform apply -auto-approve

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_dynamodb_table.datacenter_users will be created
  + resource "aws_dynamodb_table" "datacenter_users" {
      + arn              = (known after apply)
      + billing_mode     = "PAY_PER_REQUEST"
      + hash_key         = "datacenter_id"
      + id               = (known after apply)
      + name             = "datacenter-users"
      + read_capacity    = (known after apply)
      + stream_arn       = (known after apply)
      + stream_label     = (known after apply)
      + stream_view_type = (known after apply)
      + tags_all         = (known after apply)
      + write_capacity   = (known after apply)

      + attribute {
          + name = "datacenter_id"
          + type = "S"
        }

      + point_in_time_recovery (known after apply)

      + server_side_encryption (known after apply)

      + ttl (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_dynamodb_table.datacenter_users: Creating...
aws_dynamodb_table.datacenter_users: Creation complete after 2s [id=datacenter-users]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_dynamodb_table.datacenter_users


# Verify the table's creation by using the describe-table command:

bob@iac-server ~/terraform via 💠 default ➜  aws dynamodb describe-table --table-name datacenter-users
{
    "Table": {
        "AttributeDefinitions": [
            {
                "AttributeName": "datacenter_id",
                "AttributeType": "S"
            }
        ],
        "TableName": "datacenter-users",
        "KeySchema": [
            {
                "AttributeName": "datacenter_id",
                "KeyType": "HASH"
            }
        ],
        "TableStatus": "ACTIVE",
        "CreationDateTime": 1758433149.164,
        "ProvisionedThroughput": {
            "LastIncreaseDateTime": 0.0,
            "LastDecreaseDateTime": 0.0,
            "NumberOfDecreasesToday": 0,
            "ReadCapacityUnits": 0,
            "WriteCapacityUnits": 0
        },
        "TableSizeBytes": 0,
        "ItemCount": 0,
        "TableArn": "arn:aws:dynamodb:us-east-1:000000000000:table/datacenter-users",
        "TableId": "45391348-c37e-49da-a25e-e4b2ba00b9a5",
        "BillingModeSummary": {
            "BillingMode": "PAY_PER_REQUEST",
            "LastUpdateToPayPerRequestDateTime": 1758433149.164
        },
        "DeletionProtectionEnabled": false
    }
}
```


```
💠 default ➜  history | cut -c 8-
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
terraform apply -auto-approve
terraform state list
aws dynamodb describe-table --table-name datacenter-users
```

###  💠  main.tf 

```
resource "aws_dynamodb_table" "datacenter_users" {
  name         = "datacenter-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "datacenter_id"

  attribute {
    name = "datacenter_id"
    type = "S"
  }
}
```
