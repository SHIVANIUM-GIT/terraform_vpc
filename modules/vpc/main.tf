#VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true


    tags = {
      Name = "${var.project_name}-vpc"
    }
}

#Internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.project_name}-igw"
    }
  
}

#Elastic IP
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }

}

# public subnet
resource "aws_subnet" "public" {
    count = length(var.pub_subnet)
    
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_subnet[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-public-subnet-${count.index + 1}-${ var.azs[count.index]}"
    }
  
}

# public route table 
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-rt-pub"
  }
}


resource "aws_route_table_association" "public" {
  count = length(var.pub_subnet)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.pub.id
}

# private subnet 
resource "aws_subnet" "private" {
    count = length(var.pri_subnet)

    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_subnet[count.index]
    availability_zone       = var.azs[count.index]
    
    tags = {
      Name = "${var.project_name}-private-subnet-${count.index + 1}-${ var.azs[count.index]}"
    }
  
}

# private route table 
resource "aws_route_table" "private_subnet" {
  count = length(var.azs)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
   route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-rt-private${count.index + 1}-${var.azs[count.index]}"
  }
}


resource "aws_route_table_association" "private" {

  count =  length(var.pri_subnet)

  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_subnet[count.index].id
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id =  aws_eip.eip.id
  subnet_id =  aws_subnet.public[0].id

  tags = {
    Name = "${var.project_name}-NAT-gw"
  }
  depends_on = [aws_internet_gateway.igw]
}

