resource "aws_vpc" "jse_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "prod_vpc"
  }
}

resource "aws_subnet" "jse_public_subnet" {
  vpc_id                  = var.public_sub_vpcid
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnet_aza

  tags = {
    Name = "jse-public"
  }
}

resource "aws_subnet" "jse_private_subnet" {
  vpc_id                  = var.psub_vpcid
  cidr_block              = var.psubnet_cidr_block  // Adjust the CIDR block as needed
  availability_zone       = var.psubnet_azb

  tags = {
    Name = "jse-private"
  }
}



resource "aws_s3_bucket" "mobara_buck" {
  bucket = "mobara-bucket"

  tags = {
    Name        = "mobara-buck"
    Environment = "Dev"
  }
}

resource "aws_cognito_user_pool" "pool" {
  name = "congnito-user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "cognito-sample-user-pool-app-client"
  user_pool_id = var.user_pool_id
}