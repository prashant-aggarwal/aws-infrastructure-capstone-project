resource "aws_instance" "vm" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.project}-vm"
  }
}
[ec2-user@ip-172-31-7-16 2_verify_environment_terraform]$ ^C
[ec2-user@ip-172-31-7-16 2_verify_environment_terraform]$ cat variables.tf
variable "project" {
  description = "The AWS Capstone Project Name"
  type        = string
}

variable "region" {
  description = "The AWS region for resource deployment"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 Instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type of the EC2 instance"
  type        = string
}
[ec2-user@ip-172-31-7-16 2_verify_environment_terraform]$ vi output.tf
[ec2-user@ip-172-31-7-16 2_verify_environment_terraform]$ ^C
[ec2-user@ip-172-31-7-16 2_verify_environment_terraform]$ cat provider.tf 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.50.1"
    }
  }
}

provider "aws" {
  region = var.region
}
