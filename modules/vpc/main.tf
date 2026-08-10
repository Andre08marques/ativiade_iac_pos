resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr
  tags = {
    "environment" = "${var.environment}"
  }
}

resource "aws_subnet" "main" {
  count = length(var.vpc.public_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    "environment" = "${var.environment}"
    "Name"        = "${var.environment}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  tags = {
    "environment" = "${var.environment}"
    "Name"        = "${var.environment}-igw"
  }
}

resource "aws_internet_gateway_attachment" "main" {
  internet_gateway_id = aws_internet_gateway.main.id
  vpc_id              = aws_vpc.main.id
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    "environment" = var.environment
    "Name"        = "${var.environment}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.main)

  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.public_route.id
}