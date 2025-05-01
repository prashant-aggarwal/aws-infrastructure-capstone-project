1. Create an EC2 instance and connect to it using EC2 Instance Connect option. I created deploy-pa(i-069d8300dfe40f2eb) in us-east-1 region.
2. Install Packer using the following commands:
	sudo yum update -y
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
	sudo yum install -y packer
3. Create ami-builder.pkr.hcl file to create an AMI which has pre-installed dependencies like Terraform, Git, Packer with updated OS packages.
4. Create an IAM role (created IAM role packer_ami_ec2_role) with the following permissions (created IAM policy packer_ami_policy) and attach it to the EC2 instance to run Packer with minimum permissions privileges which will eliminate the need to export AWS access credentials.
	{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole",
                "ec2:DescribeInstances",
                "ec2:TerminateInstances",
                "ec2:CreateTags",
                "ec2:RegisterImage",
                "ec2:CreateImage",
                "ec2:RunInstances",
                "ssm:GetParameters",
                "ec2:ModifyImageAttribute",
                "ec2:StopInstances",
                "ec2:DisableImageBlockPublicAccess",
                "ec2:EnableImageBlockPublicAccess",
                "ec2:ModifyImageAttribute"
            ],
            "Resource": "*"
        }
    ]
}
5. Execute the following commands for creation of public AMI in the region "us-east-2".
	packer fmt .
	packer init .
	packer validate .
	packer build .
	
	Sample output:
	amazon-ebs.linux (shell-local): Making AMI ami-0b466949293232d87 public in region us-east-2...
    amazon-ebs.linux (shell-local): Disabling block public access for AMIs (temporary)...
    amazon-ebs.linux (shell-local): {
    amazon-ebs.linux (shell-local):     "ImageBlockPublicAccessState": "unblocked"
    amazon-ebs.linux (shell-local): }
    amazon-ebs.linux (shell-local): AMI is now public: ami-0b466949293232d87
    amazon-ebs.linux (shell-local): Re-enabling block public access for AMIs...
    amazon-ebs.linux (shell-local): {
    amazon-ebs.linux (shell-local):     "ImageBlockPublicAccessState": "block-new-sharing"
    amazon-ebs.linux (shell-local): }
	
	AMI Details: AMI ID -> ami-0b466949293232d87, AMI Name -> capstone-infra-custom-ami-1746095102, Owner -> 021668988309
	
6. Launch an EC2 instance in region "us-east-2" with ami-0b466949293232d87. Connect to it using EC2 Instance Connect option and run the following commands for validation of dependencies. I launched pa-terraform-server (i-0eba1b5c5af2fd95d) in us-east-2 region:
	terraform -v
	git --version
	packer --version
8. If you are logged in as root user, then change it to ec2-user via command: sudo su - ec2-user.
9. Configure AWS secret credentials using aws configure.
10. The EC2 instance is ready for performing the step #3 Creating a simple virtual machine.
