#Build WebServer during Bootstrap with dinamic block ingress
#----------------------------------------------------------

provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "web" {
  ami                    = "ami-02d0b1ffa5f16402d" // Amazon Linux2
  instance_type          = "t3.micro"
  key_name = "test"
  vpc_security_group_ids = [aws_security_group.web.id]  // va riportata la resource aws security_group + name + id

  tags = {
    Name  = "WebServer Built by Terraform"
    Owner = "Michele"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG"
  description = "Security Group for my WebServer"

 dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description = "Allow port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

    dynamic "ingress" {
    for_each = ["8000", "9000", "7000", "1000"]
    content {
      description = "Allow port UDP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  ingress {
    description = "Allow port SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Michele"
  }
}