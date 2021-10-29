variable "ec2_instance_type" {
  description = "Instance type"
  type        = string
  default = "t2.micro"
}

variable "ubuntu-ami" {
  description = "ami id"
  type = string
  default = "ami-03d5c68bab01f3496"
}

variable "centos-ami" {
  description = "centos(actually its amazon linux) ami id"
  type = string
  default = "ami-013a129d325529d4d"
}