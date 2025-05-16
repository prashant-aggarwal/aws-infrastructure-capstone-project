variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "AWS Infrastructure Capstone Project"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

