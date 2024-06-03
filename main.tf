variable "access_key" {
  description = "my access token"
}
variable "secret_key" {
  description = "my secret token"
}


provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
}

# defined my Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id
}

# creating of my custom route table
resource "aws_route_table" "production-route-table" {
  vpc_id = aws_vpc.main-vpc.id

# Here all traffic is being sent to the Internet gateway - Default route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}


# Created my Subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a" 

  tags = {
    Name = "production-subnet"
  }
}

# Associated/ linked my subnet to the Route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.production-route-table.id
}

# created security groups
resource "aws_security_group" "allow_security-web" {
  name        = "allow_traffic"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web_traffic"
  }
}

# I created a Network Interface with an IP in the subnet created ealier.
resource "aws_network_interface" "web-host" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_security-web.id]

}

# I assigned an elastic IP (EIP) to the network interface I just created.
resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-host.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.gw]
}

# Created the Ubuntu server
resource "aws_instance" "web-service-instance" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "davidMain-key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web-host.id
  }

  tags = {
    Name = "website server"
  }

 

}



      