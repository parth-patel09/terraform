terraform {
  backend "remote" {
    organization = "parth"

    workspaces {
      name = "demo1"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
      
    }
  }

  required_version = ">= 0.14.9"
}


resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  
  security_groups                      = [
        "launch-wizard-1",
    ]
    

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
resource "aws_eip" "lb" {
  instance = aws_instance.app_server.id
}