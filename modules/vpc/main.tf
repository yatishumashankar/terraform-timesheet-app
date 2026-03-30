# -------------------------------
# VPC
# -------------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "timesheet-vpc"
  }
}

# -------------------------------
# INTERNET GATEWAY
# -------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "timesheet-igw"
  }
}

# -------------------------------
# PUBLIC SUBNET
# -------------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "timesheet-public-subnet"
  }
}

# -------------------------------
# PRIVATE SUBNET 1
# -------------------------------
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "timesheet-private-subnet-1"
  }
}

# -------------------------------
# PRIVATE SUBNET 2
# -------------------------------
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "timesheet-private-subnet-2"
  }
}

# -------------------------------
# PUBLIC ROUTE TABLE
# -------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "timesheet-public-rt"
  }
}

# -------------------------------
# ROUTE TO INTERNET
# -------------------------------
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# -------------------------------
# ASSOCIATE PUBLIC SUBNET
# -------------------------------
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
