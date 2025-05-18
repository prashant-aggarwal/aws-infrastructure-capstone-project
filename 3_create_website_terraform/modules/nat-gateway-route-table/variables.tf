variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "vpc_id" {
  type    = string
  default = "vpc-*****"
}

variable "nat_gateway_subnet_a_id" {
  type    = string
  default = "nat-08e92d22dbf20aba7"
}

variable "nat_gateway_subnet_b_id" {
  type    = string
  default = "nat-0d47f69ff37567ab6"
}

variable "subnet_c_id" {
  type    = string
  default = "subnet-08e92d22dbf20aba7"
}

variable "subnet_d_id" {
  type    = string
  default = "subnet-0d47f69ff37567ab6"
}
