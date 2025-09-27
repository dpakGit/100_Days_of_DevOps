### Task : OpenSearch Setup Using Terraform

The Nautilus DevOps team needs to set up an Amazon OpenSearch Service domain to store and search their application logs. The domain should have the following specification:

1) The domain name should be xfusion-es.

2) Use Terraform to create the OpenSearch domain. The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.


Notes:

The Terraform working directory is /home/bob/terraform.

Right-click under the EXPLORER section in VS Code and select Open in Integrated Terminal to launch the terminal.

Before submitting the task, ensure that terraform plan returns No changes. Your infrastructure matches the configuration.

The OpenSearch domain creation process may take several minutes. Please wait until the domain is fully created before submitting.

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

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_opensearch_domain.xfusion-es will be created
  + resource "aws_opensearch_domain" "xfusion-es" {
      + access_policies                   = (known after apply)
      + advanced_options                  = (known after apply)
      + arn                               = (known after apply)
      + dashboard_endpoint                = (known after apply)
      + dashboard_endpoint_v2             = (known after apply)
      + domain_endpoint_v2_hosted_zone_id = (known after apply)
      + domain_id                         = (known after apply)
      + domain_name                       = "xfusion-es"
      + endpoint                          = (known after apply)
      + endpoint_v2                       = (known after apply)
      + engine_version                    = "OpenSearch_2.5"
      + id                                = (known after apply)
      + ip_address_type                   = (known after apply)
      + kibana_endpoint                   = (known after apply)
      + tags_all                          = (known after apply)

      + advanced_security_options (known after apply)

      + auto_tune_options (known after apply)

      + cluster_config {
          + dedicated_master_enabled = false
          + instance_count           = 1
          + instance_type            = "t3.medium.search"

          + cold_storage_options (known after apply)

          + node_options (known after apply)
        }

      + domain_endpoint_options (known after apply)

      + ebs_options {
          + ebs_enabled = true
          + iops        = (known after apply)
          + throughput  = (known after apply)
          + volume_size = 10
          + volume_type = (known after apply)
        }

      + encrypt_at_rest (known after apply)

      + node_to_node_encryption (known after apply)

      + off_peak_window_options (known after apply)

      + software_update_options (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
aws_opensearch_domain.xfusion-es: Creating...
aws_opensearch_domain.xfusion-es: Still creating... [10s elapsed]
aws_opensearch_domain.xfusion-es: Still creating... [20s elapsed].
.
.
.
aws_opensearch_domain.xfusion-es: Still creating... [9m50s elapsed]
aws_opensearch_domain.xfusion-es: Still creating... [10m0s elapsed]
aws_opensearch_domain.xfusion-es: Creation complete after 10m0s [id=arn:aws:es:us-east-1:000000000000:domain/xfusion-es]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

bob@iac-server ~/terraform via 💠 default ➜  terraform state list
aws_opensearch_domain.xfusion-es
```

```
bob@iac-server ~/terraform via 💠 default ➜  history |cut -c 8-
ped
ls
pwd
ls
vi main.tf
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
history |cut -c 8-
```

### # 💠  main.tf
```
resource "aws_opensearch_domain" "xfusion-es" {
  domain_name    = "xfusion-es"
  engine_version = "OpenSearch_2.5"

  cluster_config {
    instance_type = "t3.medium.search"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}
```

