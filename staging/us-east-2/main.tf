
# Create a VPC
resource "aws_vpc" "staging" {
  cidr_block = var.staging_vpc_cidr
  tags = {
    Name        = "staging-vpc"
    Environment = "staging"
  }
}

################## internet gateway #######################
resource "aws_internet_gateway" "staging_igw" {
  vpc_id = aws_vpc.staging.id

  tags = {
    Name = "staging-igw"
  }
}

################## NAT gateway #######################
resource "aws_nat_gateway" "staging_natgw" {
  allocation_id = aws_eip.staging_natgw_eip.id
  subnet_id     = aws_subnet.staging_pub_1.id

  tags = {
    Name = "staging-natgw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.staging_igw]
}

################## elastic IP #######################
resource "aws_eip" "staging_natgw_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.staging_igw]
  tags = {
    Name = "staging NAT gateway elastic IP"
  }
}