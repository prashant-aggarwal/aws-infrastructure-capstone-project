variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "My Project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "subnet_a_id" {
  type    = string
  default = "subnet-08e92d22dbf20aba7"
}

variable "subnet_b_id" {
  type    = string
  default = "subnet-0d47f69ff37567ab6"
}

variable "nat_gateway_eip_1_id" {
  type    = string
  default = "eipalloc-0fecc554fdca4277c"
}

variable "nat_gateway_eip_2_id" {
  type    = string
  default = "eipalloc-0fb36d4b21191f097"
}
