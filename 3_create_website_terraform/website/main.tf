# Create the Network
module "vpc" {
  source = "../modules/vpc"

  # Variables
  project  = var.project
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "../modules/subnets"

  # Variables
  region        = var.region
  project       = var.project
  subnet_a_cidr = var.subnet_a_cidr
  subnet_b_cidr = var.subnet_b_cidr
  subnet_c_cidr = var.subnet_c_cidr
  subnet_d_cidr = var.subnet_d_cidr
  add_public_ip = var.add_public_ip

  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create the Security Groups
module "security-groups" {
  source = "../modules/security-groups"

  # Variables
  project = var.project

  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create Elastic IPs for NAT Gateways
module "elastic-ips" {
  source = "../modules/elastic-ips"

  # Variables
  project = var.project
}

# Create NAT Gateways
module "nat-gateway" {
  source = "../modules/nat-gateway"

  # Variables
  project = var.project

  # Passed from Elastic IPs module
  nat_gateway_eip_1_id = module.elastic-ips.nat_gateway_eip_1_id
  nat_gateway_eip_2_id = module.elastic-ips.nat_gateway_eip_2_id

  # Passed from Subnets Module
  subnet_a_id = module.subnets.subnet_a_id
  subnet_b_id = module.subnets.subnet_b_id
}

# Create Private Route Table for NAT Gateways
module "nat-gateway-route-table" {
  source = "../modules/nat-gateway-route-table"

  # Variables
  project = var.project
  vpc_cidr = var.vpc_cidr

  # Passed from Subnets Module
  subnet_c_id = module.subnets.subnet_c_id
  subnet_d_id = module.subnets.subnet_d_id

  # Passed from NAT Gateway module
  nat_gateway_subnet_a_id = module.nat-gateway.nat_gateway_subnet_a_id
  nat_gateway_subnet_b_id = module.nat-gateway.nat_gateway_subnet_b_id
}

# Create the Load Balancer
module "load-balancer" {
  source = "../modules/load-balancer"

  # Variables
  project = var.project

  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id

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
  region             = var.region
  project            = var.project
  startup_script     = var.startup_script
  image_id           = var.image_id
  instance_type      = var.instance_type
  instance_count_min = var.instance_count_min
  instance_count_max = var.instance_count_max
  add_public_ip      = var.add_public_ip

  # Passed from Subnets Module
  subnet_c_id = module.subnets.subnet_c_id
  subnet_d_id = module.subnets.subnet_d_id

  # Passed from Sec Groups Module
  allow_http_id = module.security-groups.allow_http_id
  allow_ssh_id  = module.security-groups.allow_ssh_id

  # Passed from Load Balancer Module
  target_group_arn = module.load-balancer.target_group_arn
}
