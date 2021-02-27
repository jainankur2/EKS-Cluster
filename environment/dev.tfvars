# Terraform state
bucket = "eks-dev-ankur"
key = "terraform_state/infrastructure/dev/terraform.tfstate"
region = "us-east-2"

#Environment information
dns_name = "fynd"
account_environment = "dev"
availability_zones = [
  "us-east-2a",
  "us-east-2b",
  "us-east-2c"
]

#node group details
ami_type = "AL2_x86_64"
disk_size = "5"
instance_types = ["t3.micro"]
desired_size = "1"
max_size = "1"
min_size = "1"
