variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "AWS Infrastructure Capstone Project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = map(string)
  default = {
    us-east-1 = "ami-0be2609ba883822ec",
    us-east-2 = "ami-0a0ad6b70e61be944"
  }
}

variable "instance_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "t2.micro"
}

variable "instance_count_min" {
  description = "Number of instances to provision."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count_min > 0 && var.instance_count_min <= 3
    error_message = "Instance count min must be between 1 and 3."
  }
}

variable "instance_count_max" {
  description = "Number of instances to provision."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count_max > 2 && var.instance_count_max <= 6
    error_message = "Instance count max must be between 3 and 6."
  }
}

variable "add_public_ip" {
  type    = bool
  default = true
}

variable "sg_allow_http_lb_id" {
  type = string
}

variable "startup_script" {
  type = string
}

variable "subnet_c_id" {
  type = string
}

variable "subnet_d_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}
