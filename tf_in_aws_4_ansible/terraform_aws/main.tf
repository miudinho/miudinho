terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  # shared_credentials_file = "C:\Users\pwa\.aws\credentials"
  profile = "aws_terra_acg"
}



#Temporarly used cloudguru playground connection data


provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAX2XSF6MRGCXIAMHK"
  secret_key = "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"
}


resource "aws_instance" "vm_1" {
  # red hat ami
  ami = "ami-026ebd4cfe2c043b2"
  # ubuntua ami = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name      = "kluczyk"
}

output "public_ip" {
 value       = aws_instance.vm_1.public_ip
 description = "Public IP Address of EC2 instance"
}

output "instance_id" {
 value       = aws_instance.vm_1.id
 description = "Instance id: "
}


#Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "vpc"
  }
}

#Create subnet
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1"
  }
}

#Create Gateway
resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_gateway1"
  }
}

#Create Network interface
resource "aws_network_interface" "interfejs" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["10.10.1.100"]
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "Interface1"
  }
}

#Create Security Group
resource "aws_security_group" "allow_web" {
  name        = "allow_443_80_22_traffic"
  description = "Allow inbound traffic"
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


