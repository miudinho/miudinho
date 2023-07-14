<<<<<<< HEAD
data "aws_ami" "server_ami" {
  most_recent = true
  #plural - argument list 
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
=======
#resources 
data "aws_ami" "server_ami" {
    most_recent = true
    #plural - argument list 
    owners = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

#data "http" "www_ip" {
#    url = "http://target.me"
#    # data.http.www_ip.body
#}
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
