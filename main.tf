# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraformtest.com"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "ap-southeast-1"
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = "${var.ami}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  source_dest_check      = false
  instance_type          = "${var.instance_type}"
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/12"]
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

}
