resource "aws_vpc" "main_vpc" {
  
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "main-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    name = "my-subnet"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    name = "my-gw"
  }
}

resource "aws_route_table" "my_routing_table" {
  vpc_id = aws_vpc.main_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    name = "my_public_rt"
  }
}

# resource "aws_route" "default_route" {
#   route_table_id         = aws_route_table.my_routing_table.id
#   # all trafic will go this one 
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.my_internet_gateway.id
# }

resource "aws_route_table_association" "my_rt_asso" {
  subnet_id = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_routing_table.id
}

#Create Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_all_traffic"
  description = "Allow all inbound  traffic"
  vpc_id      = aws_vpc.main_vpc.id

  # ingress {
  #   description = "HTTPS"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "HTTP"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   description = "SSH"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_traffic"
  }
}



# Instances 
resource "aws_instance" "dev_node" {
  # instance_type = "t2.medium"
  instance_type = var.inst_type
  ami           = var.os_iso
  #ami = data.aws_ami.server_ami.id
  #vpc_id = aws_vpc.main_vpc.id  
  subnet_id = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  

  tags = {
    name = "dev-node"
  }

  root_block_device {
    # set in variables file 
    volume_size = var.instance_root_block_device_size
  }
}

# resource "aws_instance" "dev_node_x" {
#   instance_type = var.inst_type
#   ami           = var.os_iso
#   #ami = data.aws_ami.server_ami.id
#   vpc_security_group_ids = [aws_security_group.allow_traffic.id]
#   subnet_id = aws_subnet.my_subnet.id

#   tags = {
#     name = "dev-node-x"
#   }
#   root_block_device {
#     # set in variables file 
#     volume_size = var.instance_root_block_device_size
#   }
# }




#provisioner "local-exec" {
#command = "echo $(self.private_ip) >> private_ips"
#command = "echo test string $(dev_node_instance_public_ip) to file local_file  >> private_ips"
#command = "get-Content -Path"
#using git bash localy
# interpreter = ["bash", "-c"]
# }