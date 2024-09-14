############### Public Security group #################

resource "aws_security_group" "staging_pub_sg" {
  # ... other configuration ...
  name   = "staging_pub_sg"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "staging-pub-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

#################### bastion Security Group #################


resource "aws_security_group" "staging_bastion_sg" {
  # ... other configuration ...
  name   = "staging_bastion_sg"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "staging-bastion-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

#################### Private Security Group #################


resource "aws_security_group" "staging_pri_sg" {
  # ... other configuration ...
  name   = "staging_pri_sg"
  vpc_id = aws_vpc.staging.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_pub_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_pub_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.staging_bastion_sg.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "staging-pri-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

