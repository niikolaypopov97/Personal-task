module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.vpc_name
  cidr = var.vpc_cidr
  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  map_public_ip_on_launch = true
  create_database_subnet_group = true

  enable_nat_gateway = false
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_vpn_gateway = true
}

#Creating DB subnet for RDS instance 
resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet"
  subnet_ids = module.vpc.private_subnets
}

# #Creating new VPC
# resource "aws_vpc" "my-vpc" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags = {
#     Name = "my-vpc"
#   }
# }

# #Creating public subnet - subnet 1
# resource "aws_subnet" "subnet1" {
#   vpc_id                  = aws_vpc.my-vpc.id
#   cidr_block              = "10.0.0.0/27"
#   map_public_ip_on_launch = true
#   availability_zone       = "eu-west-1a"
# }

# #Creating public subnet - subnet 2
# resource "aws_subnet" "subnet2" {
#   vpc_id                  = aws_vpc.my-vpc.id
#   cidr_block              = "10.0.0.32/27"
#   map_public_ip_on_launch = true
#   availability_zone       = "eu-west-1b"
# }

# #Creating private subnet - subnet 3
# resource "aws_subnet" "subnet3" {
#   vpc_id                  = aws_vpc.my-vpc.id
#   cidr_block              = "10.0.1.0/27"
#   map_public_ip_on_launch = false
#   availability_zone       = "eu-west-1c"
# }

