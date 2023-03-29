resource "aws_vpc" "mtc_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "dev"
  }
}

resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    name = "dev-public"
  }
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    name = "dev-internet-GW"
  }
}

resource "aws_route_table" "mtc_public_routing_table" {
  vpc_id = aws_vpc.mtc_vpc.id

  tags = {
    name = "dev_public_routing_table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_routing_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_accosciation" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mtc_public_routing_table.id
}

resource "aws_security_group" "mtc_security_group" {
  name        = "dev_security_group"
  description = "dev security group"
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # cidr_blocks - plural - required list of attributes | my_ip_addres/32 - only this ip will be allowed 
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "mtc_auth" {
    key_name = "mtckey"
    public_key = file("~/.ssh/.ssh_bak/id_rsa.pub")
  
}


resource "aws_instance" "dev_node" {
    instance_type = "t2.micro"
    ami = data.aws_ami.server_ami.id

    tags = {
        name = "dev-node"
    }
  
  key_name = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_security_group.id]
  subnet_id = aws_subnet.mtc_public_subnet.id
  #bootstrap conten of the file below - installing etc. 
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10

  }
}