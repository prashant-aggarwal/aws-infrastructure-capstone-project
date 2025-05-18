1. Change the directory to /home/ec2-user/prashant/aws-infrastructure-capstone-project/3_create_website_terraform using command: cd /home/ec2-user/prashant/aws-infrastructure-capstone-project/3_create_website_terraform
2. Deploy the environment using terraform workflow using the following commands:
	terraform init
	terraform plan
	terraform apply -auto-approve
3. Copy the load balancer arn from the output as follows and hit it in a web browser using http protocol which will display the old school space invader game:
	load_balancer_address = "website-terraform-alb-1488934837.us-east-1.elb.amazonaws.com"
4. Verify the various resources like EC2 (website-terraform-webserver), Target Group (website-terraform-alb-tg), VPC (website-terraform-vpc), Subnets (website-terraform-vpc-subnet-a, website-terraform-vpc-subnet-b) etc. in AWS management console.
5. After successfuly verification, destroy the environment using the command:
	terraform destroy -auto-approve
6. Verify the Resources Group section or randomly check a few services to ensure that no residue is left behind. Sample output:
	module.vpc.aws_subnet.subnet-a: Destruction complete after 0s
	module.vpc.aws_subnet.subnet-b: Destruction complete after 1s
	module.security-groups.aws_security_group.allow-ssh: Destruction complete after 1s
	module.security-groups.aws_security_group.allow-http: Destruction complete after 1s
	module.vpc.aws_vpc.vpc: Destroying... [id=vpc-0498e2694d82da3e2]
	module.vpc.aws_vpc.vpc: Destruction complete after 0s
7. Stopped the following EC2 instances:
	deploy-pa (i-069d8300dfe40f2eb) in us-east-1 region - Used to create a public AMI from Packer in us-east-2 region.
	pa-terraform-server (i-0eba1b5c5af2fd95d) in us-east-2 region - Spun this up using Terraform with the AMI ID created above.

Challenges resolved:
1. Replaced Launch Configuration with Launch Template
2. Replaced Class Load Balancer with Application Load Balancer which requires Listener and Target Groups.
3. ALB was displaying "502 Bad Gateway" error because the "Enable auto-assign public IPv4 address" was set to false on the subnets due to missing "map_public_ip_on_launch = true" property on resource aws_subnet.
4. Rectified the misalignment of variables and outputs.
5. Moved hard coded values to variables as much as possible. 

Improvement required:
1. Currently, the EC2 instances are getting launched with public IPs because they are using the same subnets as those of ALB. This can be avoided by creating private subnets and attaching these to the Auto Scaling group instead - Completed by adding NAT Gateways in public subnets, creating private route tables and using private subnets for ASGs.
2. Replace the old school space invader with a modern looking website or animation - Completed by using another space invader game.
