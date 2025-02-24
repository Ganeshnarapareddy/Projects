provider "aws" {
  region = "us-west-1"
}
variable "env" {}
variable "vpc-cidr" {}
variable "subnet-cidr" {}
variable "subnet-AZ" {}
variable "allow_all_cidr" {}
variable "my_ip" {}
variable "instance_type" {}

resource "aws_vpc" "dev-vpc" {

    cidr_block = var.vpc-cidr
    tags = {
      Name = "${var.env}-vpc"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.subnet-cidr
    availability_zone = var.subnet-AZ
    
    tags = {
      Name = "${var.env}-subnet1"
    }
}

resource "aws_internet_gateway" "dev-IG" {
  vpc_id = aws_vpc.dev-vpc.id
      tags = {
      Name = "${var.env}-IG"
    }
}
resource "aws_route_table" "dev-RT" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-IG.id
  }
    tags = {
      Name = "${var.env}-Routetable"
    }   
}

resource "aws_route_table_association" "subnet_Association" {
  route_table_id = aws_route_table.dev-RT.id
  subnet_id = aws_subnet.name.id

}
resource "aws_security_group" "dev-SG" {
  vpc_id = aws_vpc.dev-vpc.id
  name = "dev-SG"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.my_ip
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = var.allow_all_cidr
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = var.allow_all_cidr
  }
      tags = {
      Name = "${var.env}-SG"
    }  

}
data "aws_ami" "AMI_ID" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}
resource "aws_instance" "Dev-dock-nginx-ec2" {
  ami = data.aws_ami.AMI_ID.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.name.id
  vpc_security_group_ids = [aws_security_group.dev-SG.id]
  availability_zone = var.subnet-AZ
  associate_public_ip_address = true
  key_name = "jumpserver"
  user_data = file("nginx.sh")
    tags = {
      Name = "${var.env}-NGINX-EC2"
    } 

}
output "ami_id" {
  value = data.aws_ami.AMI_ID.id
}