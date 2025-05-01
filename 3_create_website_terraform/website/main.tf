# Create the Network
module "vpc" {
  source = "../modules/vpc"

  region        = var.region
  project       = var.project
  vpc_cidr      = var.vpc_cidr
  subnet_a_cidr = var.subnet_a_cidr
  subnet_b_cidr = var.subnet_b_cidr
}

# Create the Security Groups
module "security-groups" {
  source = "../modules/security-groups"

  project = var.project
  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create the Load Balancer
module "load-balancer" {
  source  = "../modules/load-balancer"
  project = var.project

  # Passed from VPC Module
  vpc_id      = module.vpc.vpc_id
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.security-groups.allow_http_id
}

# Create the Autoscaling Group
module "autoscaling-group" {
  source = "../modules/autoscaling-group"

  region         = var.region
  project        = var.project
  startup_script = var.startup_script

  image_id = var.image_id

  instance_type      = var.instance_type
  instance_count_min = var.instance_count_min
  instance_count_max = var.instance_count_max
  add_public_ip      = var.add_public_ip

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.security-groups.allow_http_id
  allow_ssh_id  = module.security-groups.allow_ssh_id

  # Passed from Load Balancer Module
  load_balancer_id = module.load-balancer.load_balancer_id
}
