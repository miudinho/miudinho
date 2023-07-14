variable "instance_root_block_device_size" {
  type      = string
  default   = "10"
  sensitive = false
  nullable  = false
}

variable "inst_type" {
  type    = string
  default = "t2.micro"
}

variable "os_iso" {
  type        = string
  description = "os iso ami"
  # red hat 9
  # default = "ami-026ebd4cfe2c043b2"
  # ubuntu 
  # default = "ami-085925f297f89fce1"
  # centos 9
  default = "ami-06053084ac8dcedf6"
}
