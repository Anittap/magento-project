resource "aws_vpc" "magento" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = cidrsubnet(var.cidr_block, var.bits, count.index)
  availability_zone       = data.aws_availability_zones.virginia.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public${count.index + 1}"
    Type = "public"
  }
}
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.magento.id
  cidr_block        = cidrsubnet(var.cidr_block, var.bits, count.index + 3)
  availability_zone = data.aws_availability_zones.virginia.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private${count.index + 1}"
    Type = "private"
  }
}
resource "aws_eip" "nat_gateway" {
  domain = "vpc"
}
resource "aws_internet_gateway" "magento" {
  vpc_id = aws_vpc.magento.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_nat_gateway" "magento" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public[2].id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
  depends_on = [aws_eip.nat_gateway, aws_internet_gateway.magento]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.magento.id
  tags = {
    Name = "${var.project_name}-${var.project_environment}-public-rt"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.magento.id
  tags = {
    Name = "${var.project_name}-${var.project_environment}-private-rt"
  }
}
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.magento.id
}
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.magento.id
}

