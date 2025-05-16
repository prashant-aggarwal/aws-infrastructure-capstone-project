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
