variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable Main_Routing_Table {}
variable "environment" { default = "dev" }

variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c","us-east-1d","us-east-1e"]
}

variable "vpc_cidrs" {
description = "CIdrs block for the subnets"
type = "list"
default = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
}
