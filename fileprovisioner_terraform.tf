terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}



resource "aws_instance" "app_server" {
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"
  key_name      = "jarter"

  tags = {
    Name = "SF terraform"
  }

  provisioner "file" {
    source      = "D:/terraform/app.py" # Replace with the path to your local file
    destination = "/home/ubuntu/"       # Replace with the path on the remote instance

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.app_server.public_ip
      private_key = file("D:/terraform/jarter.pem") # Replace with the correct path to your private key
    }
  }
}
