<<<<<<< HEAD
resource "aws_vpc" "main_vpc" {
  
=======
resource "aws_vpc" "mtc_vpc" {
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
<<<<<<< HEAD
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

=======
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

>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

<<<<<<< HEAD
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
=======
}

resource "aws_key_pair" "mtc_auth" {
    key_name = "mtckey"
    public_key = file("~/.ssh/.ssh_bak/id_rsa.pub")
  
}


resource "aws_instance" "dev_node" {
    instance_type = "t2.medium"
    ami = data.aws_ami.server_ami.id

    tags = {
        name = "dev-node"
    }
  
  key_name = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_security_group.id]
  subnet_id = aws_subnet.mtc_public_subnet.id
  #bootstrap conten of the file below - installing etc. 
  user_data = file("input_file.tpl")

  #root_block_device {
  #  volume_size = 10
  #}
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0

  root_block_device {
    # set in variables file 
    volume_size = var.instance_root_block_device_size
  }
<<<<<<< HEAD
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
=======

 provisioner "local-exec" {
        #command = "echo $(self.private_ip) >> private_ips"
        command = "echo test string to file local_file  >> private_ips"
        #command = "get-Content -Path"
        #using git bash localy
        interpreter = ["bash", "-c"]
  }

}
#resource "aws_instance" "dev_node" {
#  provisioner "local-exec" {
#        command = "echo The servier's IP address is $(self.private_ip)"
    
#  }
#}

resource "aws_instance" "dev_node_x" {
    instance_type = "t2.medium"
    ami = data.aws_ami.server_ami.id

    tags = {
        name = "dev-node"
    }
  
  key_name = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_security_group.id]
  subnet_id = aws_subnet.mtc_public_subnet.id
    
  user_data = file("dev_node_x_input_file.tpl")
  
  root_block_device {
    # set in variables file 
    volume_size = var.instance_root_block_device_size
  }
} 
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
