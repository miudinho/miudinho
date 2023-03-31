#Temporarly used cloudguru playground connection data


provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAURYSZSBGKHUNMCXB"
  secret_key = "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"
}


#Create VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "VPC1"
  }

}

#Create subnet

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet1"
  }


}

#Create Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Gateway1"
  }
}

#Create Network interface

resource "aws_network_interface" "interfejs" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.101"]
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "Interface1"
  }

}

#Create Security Group

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

    ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_traffic"
  }
}

#Create an Elastic (Public) IP to the network interface

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.interfejs.id
  associate_with_private_ip = "172.16.10.101"
  depends_on                = [aws_internet_gateway.gw]
}

output "server_public_ip" {
  value = aws_eip.one.public_ip
}


#Create Routing Table

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Routing_Table"
  }
  
}

#Associate Subnet with routing table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.prod-route-table.id
}





#Create instance

resource "aws_instance" "instancja" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name      = "kluczyk"
  

  network_interface {
    network_interface_id = aws_network_interface.interfejs.id
    device_index         = 0
  }

  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install apache2 -y
                 sudo systemctl start apache2
                 sudo bash -c 'echo Hello There > /var/www/html/index.html'
                 EOF
 
  tags = {
    Name = "Instance2"
  }




}



