# Create the Network
module "vpc" {
  source = "../modules/vpc"

  # Variables
  region        = var.region
  project       = var.project
  vpc_cidr      = var.vpc_cidr
}

module "subnets" {
  source = "../modules/subnets"

  # Variables
  region        = var.region
  project       = var.project
  subnet_a_cidr = var.subnet_a_cidr
  subnet_b_cidr = var.subnet_b_cidr
  add_public_ip = var.add_public_ip
  
  # Passed from VPC Module
  vpc_id        = module.vpc.vpc_id
}

# Create the Security Groups
module "security-groups" {
  source = "../modules/security-groups"

  # Variables
  project = var.project

  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create the Load Balancer
module "load-balancer" {
  source  = "../modules/load-balancer"
  
  # Variables
  project = var.project

  # Passed from VPC Module
  vpc_id      = module.vpc.vpc_id

  # Passed from Subnets Module
  subnet_a_id = module.subnets.subnet_a_id
  subnet_b_id = module.subnets.subnet_b_id

  # Passed from Security Groups Module
  allow_http_id = module.security-groups.allow_http_id
}

# Create the Autoscaling Group
module "autoscaling-group" {
  source = "../modules/autoscaling-group"

  # Variables
  region         = var.region
  project        = var.project
  startup_script = var.startup_script
  image_id       = var.image_id
  instance_type      = var.instance_type
  instance_count_min = var.instance_count_min
  instance_count_max = var.instance_count_max
  add_public_ip      = var.add_public_ip

  # Passed from Subnets Module
  subnet_a_id = module.subnets.subnet_a_id
  subnet_b_id = module.subnets.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.security-groups.allow_http_id
  allow_ssh_id  = module.security-groups.allow_ssh_id

  # Passed from Load Balancer Module
  target_group_arn = module.load-balancer.target_group_arn
}
