variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-*****"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "nat_gateway_subnet_a_id" {
  type    = string
  default = "nat-08e92d22dbf20aba7"
}

variable "nat_gateway_subnet_b_id" {
  type    = string
  default = "nat-0d47f69ff37567ab6"
}

variable "subnet_a_id" {
  type    = string
  default = "subnet-08e92d22dbf20aba7"
}

variable "subnet_b_id" {
  type    = string
  default = "subnet-0d47f69ff37567ab6"
}
