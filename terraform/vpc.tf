resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

# # Private Subnets
# resource "aws_subnet" "private" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.private_subnet
#   availability_zone = var.availability_zones

#   tags = {
#     Name                                   = "${var.environment}-private-subnet"
#   }
# }

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# # NAT Gateway Elastic IP
# resource "aws_eip" "nat" {
#     instance = aws_instance.bastion.id

#   tags = {
#     Name = "${var.environment}-nat-eip"
#   }
# }

# # NAT Gateway
# resource "aws_nat_gateway" "main" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public.id

#   tags = {
#     Name = "${var.environment}-nat-gateway"
#   }

#   depends_on = [aws_internet_gateway.main]
# }

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  count  = length(var.availability_zones)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.environment}-public-route-table-${count.index + 1}"
  }
}

# Private Route Tables
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.main.id
#   }

#   tags = {
#     Name = "${var.environment}-private-route-table"
#   }
# }

# Public Route Table Association
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Private Route Table Association
# resource "aws_route_table_association" "app_private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }