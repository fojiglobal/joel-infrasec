resource "aws_route_table" "staging_pub_rtr" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging_igw.id
  }

  tags = {
    Name = "staging-pub-rtr"
  }
}

resource "aws_route_table_association" "staging_pub_sub_1" {
  subnet_id      = aws_subnet.staging_pub_1.id
  route_table_id = aws_route_table.staging_pub_rtr.id
}

resource "aws_route_table_association" "staging_pub_sub_2" {
  subnet_id      = aws_subnet.staging_pub_2.id
  route_table_id = aws_route_table.staging_pub_rtr.id
}

############# Private route table ################
resource "aws_route_table" "staging_pri_rtr" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.staging_natgw.id
  }

  tags = {
    Name = "staging-pri-rtr"
  }
}

resource "aws_route_table_association" "staging_pri_sub_1" {
  subnet_id      = aws_subnet.staging_pri_1.id
  route_table_id = aws_route_table.staging_pri_rtr.id
}

resource "aws_route_table_association" "staging_pri_sub_2" {
  subnet_id      = aws_subnet.staging_pri_2.id
  route_table_id = aws_route_table.staging_pri_rtr.id
}