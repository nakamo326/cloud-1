resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "cloud-1-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "cloud-1-subnet"
  }
}

resource "aws_subnet" "dummy_subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "cloud-1-dummy-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.2.0/24"
}
