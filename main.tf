terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {}

resource "aws_instance" "Ansible" {

    ami = var.ubuntu-ami  
    instance_type = var.ec2_instance_type
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
    connection {
       type        = "ssh"
       host        = self.public_ip
       user        = "ubuntu"
       private_key = file("/home/zheka/Keys/aws_key")
       timeout     = "4m"
             }
    provisioner "file"{
      source = "/home/zheka/Keys/aws_key"
      destination = "/home/ubuntu/aws_key"
  }
  provisioner "remote-exec" {
    inline = [
      "echo '[webservers]'",
      "echo ubuntu ${aws_instance.Ubuntu.public_ip} >> inventory",
      "echo centos ${aws_instance.Centos.public_ip} >> inventory",
      "echo '[ubuntu]'",
      "echo ubuntu ${aws_instance.Ubuntu.public_ip} >> inventory",
      "echo '[centos]'",
      "echo centos ${aws_instance.Centos.public_ip} >> inventory",
      
      
      "sudo su",
      "apt update -y",
      "apt install ansible -y",
      "git clone https://github.com/pornocop72/888holdings_test",
      "touch test.txt"
      
    ]
  }


  
  
}
resource "aws_instance" "Centos" {

    ami = var.centos-ami
    instance_type = var.ec2_instance_type
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
}
resource "aws_instance" "Ubuntu" {

    ami = var.ubuntu-ami
    instance_type = var.ec2_instance_type
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 80
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 80
  },
  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 8080
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 8080
  }
  ]
}


resource "aws_key_pair" "main_key" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGrWNfqNj5YCeJzUeRTayoYA/GulEAnDPmyuUPqjpPcFv/eTGIivxv2yTmCJtkP3BqUeB2p77U75RFTLyF00Ka9HtDg/tdSZKQTGfN4Ja/Lt0puK4/loXoznQxORXrhatnICxRq64bDAaKduGlNTveJXhbDffbzdLK8MYiwJ/yWcoLCkARWTJzXK4pwcBUv74MWy3UVDyD02XcKhWh9A/diFVI1vfFe5hsvR4AX7hDQWorbnds5JK8bQavhDVrIKlZo3Ug+4UcM6YhkAm4JqtTWzDqh0M1GrVXLWvBnNliKfTzm4LSB2xA9NF0ZiqrPxf+IpDIeF9B7OuE65qBrNn8bfHKFsBXWwd/wNvtpIfTNE2K/TY37WI5zVjFBlGUmcuHtCnC5Uf3ttoi7BzT66U0r1QPG5wuO7hBPfVGBEpQTzbFDedMv4AZB3RK1RnIAclb/VJv+MIVWFyKzQwiV04Si3gJxmVo8rmtBYS/VYIuCM3mTCno39Cgt6W5pks1N2U="
}
