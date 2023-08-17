###########################################################################
#create a VPC
###########################################################################

resource "aws_vpc" "shibnath_vpc" {
  cidr_block                       = var.cidr
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}
###############################################################################
# Internet Gateway
###############################################################################
resource "aws_internet_gateway" "shibnath_IGW" {

  vpc_id = aws_vpc.shibnath_vpc.id
  tags = {
    "Name" = var.igw_tag
  }
}
################################################################################
# Public subnet
################################################################################
resource "aws_subnet" "public_subnet" {
  vpc_id                          = aws_vpc.shibnath_vpc.id
  cidr_block                      = var.public_subnets_cidr
  availability_zone               = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch         = var.map_public_ip_on_launch

  tags = {
   Name = var.public_subnet_tag
  }
}
################################################################################
# database_subnet
################################################################################
resource "aws_subnet" "database_subnet" {
  vpc_id                          = aws_vpc.shibnath_vpc.id
  cidr_block                      = var.database_subnets_cidr
  availability_zone               = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch         = false

  tags = {
    Name = var.database_subnet_tag
  }
}
################################################################################
# Publiс routes
################################################################################
resource "aws_route_table" "shibnath_vpc_public_route_table" {
  vpc_id = aws_vpc.shibnath_vpc.id
  tags = {
    Name = var.public_route_table_tag
  }
}
resource "aws_route" "shibnath_vpc_public_internet_gateway" {
  route_table_id         = aws_route_table.shibnath_vpc_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.shibnath_IGW.id
}

################################################################################
# Database route table
################################################################################

resource "aws_route_table" "shibnath_vpc_database_route_table" {
  vpc_id = aws_vpc.shibnath_vpc.id
  tags = {
    Name = var.database_route_table_tag
  }
}
################################################################################
# Route table association with subnets
################################################################################
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.shibnath_vpc_public_route_table.id
}
resource "aws_route_table_association" "database_route_table_association" {
  subnet_id      = aws_subnet.database_subnet.id
  route_table_id = aws_route_table.shibnath_vpc_database_route_table.id
}
###############################################################################
# Security Group
###############################################################################
resource "aws_security_group" "sg" {
  name        = "shibnath_vpc_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.shibnath_vpc.id

  ingress = [
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "shibnath_vpc_security_group"
  }
}

  tags = {
    Name = "shibnath_vpc_security_group"
  }
}
