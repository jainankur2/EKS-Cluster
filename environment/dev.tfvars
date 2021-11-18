#Environment information
region = "us-east-2"
dns_name = "IHS-Markit"
account_environment = "dev"
availability_zones = [
  "us-east-2a",
  "us-east-2b",
  "us-east-2c"
]

#node group details
ami_type = "AL2_x86_64"
disk_size = "20"
instance_types = ["t3.medium"]
desired_size = "1"
max_size = "1"
min_size = "1"
