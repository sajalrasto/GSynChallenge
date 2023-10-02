


resource "aws_vpc" "vpcnew" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "sajalvpc"
    Owner       = "Sajal"
  }
}


resource "aws_subnet" "privatesubnet" {

  vpc_id                  = aws_vpc.vpcnew.id
  cidr_block              = "10.0.1.0/28"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false
   tags = {
    Name = "private-subnet"
  }
}
