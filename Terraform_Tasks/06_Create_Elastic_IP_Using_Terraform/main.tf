terraform
provider "aws" {
  region = "your-region" # Replace with your AWS region
}

# Remove the provider block from the code if you have a separate provider block outside this code.

resource "aws_eip" "nautilus_eip" {
  domain = "vpc"
  tags = {
    Name = "nautilus-eip"
  }
}
