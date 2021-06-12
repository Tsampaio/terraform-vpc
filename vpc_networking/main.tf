provider "aws" {
  region = var.region
}

resource "aws_vpc" "module_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags {
    Name = "Production-VPC"
  }
}

resource "aws_subnet" "module_public_subnet_1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"

  tags {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "module_public_subnet_2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}b"

  tags {
    Name = "Public-Subnet-2"
  }
}

resource "aws_subnet" "module_private_subnet_1" {
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"

  tags {
    Name = "Private-Subnet-1"
  }
}

resource "aws_subnet" "module_private_subnet_2" {
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.module_vpc.id
  availability_zone = "${var.region}b"

  tags {
    Name = "Private-Subnet-2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags {
    Name = "Public-Route-Table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags {
    Name = "Private-Route-Table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_2.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_1.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.module_private_subnet_2.id
}