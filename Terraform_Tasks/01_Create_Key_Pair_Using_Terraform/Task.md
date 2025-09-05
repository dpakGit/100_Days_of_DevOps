### Task






-----------------------------------

### What i Did

```
bob@iac-server ~/terraform via 💠 default ➜  cd /home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  pwd
/home/bob/terraform

bob@iac-server ~/terraform via 💠 default ➜  ls -alh
total 24K
drwxr-xr-x 1 bob bob 4.0K Jun 19 15:06 .
drwxr-x--- 1 bob bob 4.0K Aug 26 03:28 ..
-rw-rw-r-- 1 bob bob  435 Jun 19 15:04 README.MD
-rw-rw-r-- 1 bob bob 1.1K May 13 13:59 provider.tf


bob@iac-server ~/terraform via 💠 default ✖ vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt


bob@iac-server ~/terraform via 💠 default ✖ ls -alh
total 28K
drwxr-xr-x 1 bob bob 4.0K Aug 26 03:39 .
drwxr-x--- 1 bob bob 4.0K Aug 26 03:39 ..
-rw-rw-r-- 1 bob bob  435 Jun 19 15:04 README.MD
-rw-r--r-- 1 bob bob  490 Aug 26 03:39 main.tf
-rw-rw-r-- 1 bob bob 1.2K Aug 26 03:38 provider.tf

bob@iac-server ~/terraform via 💠 default ➜  vi provider.tf 

bob@iac-server ~/terraform via 💠 default ➜  vi main.tf 
 
bob@iac-server ~/terraform via 💠 default ➜  terraform fmt

bob@iac-server ~/terraform via 💠 default ➜  terraform init
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Finding hashicorp/aws versions matching "5.91.0"...
- Finding latest version of hashicorp/tls...
- Installing hashicorp/local v2.5.3...
- Installed hashicorp/local v2.5.3 (signed by HashiCorp)
- Installing hashicorp/aws v5.91.0...
- Installed hashicorp/aws v5.91.0 (signed by HashiCorp)
- Installing hashicorp/tls v4.1.0...
- Installed hashicorp/tls v4.1.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.


bob@iac-server ~/terraform via 💠 default ✖ vi main.tf 

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt
main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/local from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Using previously-installed hashicorp/local v2.5.3
- Using previously-installed hashicorp/aws v5.91.0
- Using previously-installed hashicorp/tls v4.1.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

bob@iac-server ~/terraform via 💠 default ➜  terraform apply

Terraform used the selected providers to generate the
following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_key_pair.devops_kp will be created
  + resource "aws_key_pair" "devops_kp" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "devops-kp"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # local_file.devops_kp_pem will be created
  + resource "local_file" "devops_kp_pem" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "/home/bob/devops-kp.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.devops_kp will be created
  + resource "tls_private_key" "devops_kp" {
      + algorithm                     = "RSA"
      + ecdsa_curve                   = "P224"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 4096
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.devops_kp: Creating...
tls_private_key.devops_kp: Creation complete after 1s [id=f11154c0a51486d3c5b7be96f1a1eff2a45b9575]
local_file.devops_kp_pem: Creating...
local_file.devops_kp_pem: Creation complete after 0s [id=b6452639fa5fa034be3e982c339a14cfc22e5643]
aws_key_pair.devops_kp: Creating...
aws_key_pair.devops_kp: Creation complete after 2s [id=devops-kp]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.



bob@iac-server ~/terraform via 💠 default ➜  cd /home/bob/

bob@iac-server ~ ➜  ls

devops-kp.pem  terraform

. # Note : the key devops-kp.pem is generated

bob@iac-server ~ ✖ cat devops-kp.pem 
-----BEGIN RSA PRIVATE KEY-----
MIIJKAIBAAKCAgEA52fu8ipNbxv .........

```

--------------------------------------
### Troubleshoot

- 1.
```
bob@iac-server ~/terraform via 💠 default ➜  vi main.tf

bob@iac-server ~/terraform via 💠 default ➜  terraform fmt 
provider.tf
╷
│ Error: Argument or block definition required
│ 
│   on main.tf line 1:
│    1: hcl
│ 
│ An argument or block definition is required here. To
│ set an argument, use the equals sign "=" to introduce
│ the argument value.
╵


Solution:
Removed hcl from main.tf
```


- 2.
```  
bob@iac-server ~/terraform via 💠 default ➜  terraform init

Initializing the backend...
╷
│ Error: Terraform encountered problems during initialisation, including problems
│ with the configuration, described below.
│ 
│ The Terraform configuration must be valid before initialization so that
│ Terraform can determine which modules and providers need to be installed.
│ 
│ 
╷
│ Error: Duplicate provider configuration
│ 
│   on provider.tf line 10:
│   10: provider "aws" {
│ 
│ A default (non-aliased) provider configuration for
│ "aws" was already given at main.tf:1,1-15. If
│ multiple configurations are required, set the "alias"
│ argument for alternative configurations.
╵
╷
│ Error: Duplicate provider configuration
│ 
│   on provider.tf line 10:
│   10: provider "aws" {
│ 
│ A default (non-aliased) provider configuration for
│ "aws" was already given at main.tf:1,1-15. If
│ multiple configurations are required, set the "alias"
│ argument for alternative configurations.
╵


Solution. 
A provider configuration already exits in provider.tf file , we have written it again in main.tf.

Removed the provider part from main.tf
```



- 3.
```
bob@iac-server ~/terraform via 💠 default ➜  terraform apply
╷
│ Error: Value for unconfigurable attribute
│ 
│   with aws_key_pair.devops_kp,
│   on main.tf line 3, in resource "aws_key_pair" "devops_kp":
│    3:   key_type   = "rsa"
│ 
│ Can't configure a value for "key_type": its value
│ will be decided automatically based on the result of
│ applying this configuration.
╵
Solution Removed the line "key_type   = "rsa""
```


### *Issue with terraform apply*
- The error indicates that the key_type attribute in the aws_key_pair resource is no longer configurable in the AWS provider as it is decided automatically.

Fix
- *Remove the key_type attribute* from the aws_key_pair resource in main.tf:

```
provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

resource "aws_key_pair" "devops_kp" {
  key_name   = "devops-kp"
  public_key = tls_private_key.devops_kp.public_key_openssh
}

resource "tls_private_key" "devops_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "devops_kp_pem" {
  content         = tls_private_key.devops_kp.private_key_pem
  filename        = "/home/bob/devops-kp.pem"
  file_permission = "0600"
}
```

- *Run terraform apply again*:
bash
terraform apply


Do you need help with:
- Troubleshooting other Terraform or AWS issues?
- Understanding Terraform resource configurations?
- Something else related to Terraform or AWS?
