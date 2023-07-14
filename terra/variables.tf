variable "instance_root_block_device_size" {
<<<<<<< HEAD
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
=======
    type = string
    default = "8"
    sensitive = false
    nullable = false
}
>>>>>>> fe6204a4eafe8a0b2de6902e62eb82ba00d9d8d0
