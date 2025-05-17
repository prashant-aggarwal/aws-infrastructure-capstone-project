project = "website-terraform"
region  = "us-east-1"
image_id = {
  us-east-1 = "ami-0be2609ba883822ec",
  us-east-2 = "ami-0a0ad6b70e61be944"
}
instance_type      = "t2.micro"
instance_count_min = 2
instance_count_max = 6
vpc_cidr           = "10.10.0.0/16"
subnet_a_cidr      = "10.10.1.0/24"
subnet_b_cidr      = "10.10.2.0/24"
add_public_ip      = false
startup_script     = "install_space_invaders.sh"
