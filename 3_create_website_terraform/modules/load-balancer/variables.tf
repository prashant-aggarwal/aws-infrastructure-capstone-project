variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "AWS Infrastructure Capstone Project"
}

variable "vpc_id" {
  type = string
}

variable "sg_allow_http_lb_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}
