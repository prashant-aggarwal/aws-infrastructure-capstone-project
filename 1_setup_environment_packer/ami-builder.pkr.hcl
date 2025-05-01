packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

variable "region" {
  default = "us-east-2"
}

variable "ami_name" {
  default = "capstone-infra-custom-ami-{{timestamp}}"
}

source "amazon-ebs" "linux" {
  region = var.region
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.20240109.0-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["137112412989"] # Amazon
    most_recent = true
  }
  instance_type   = "t3.micro"
  ssh_username    = "ec2-user"
  ami_name        = var.ami_name
  ami_description = "Custom AMI with required dependencies"
  tags = {
    Name = var.ami_name
  }
}

build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "shell" {
    inline = [
      "echo 'Updating latest packages.....'",
      "sudo yum update -y",
      "echo 'Updated latest packages!!'",

      "echo 'Installing utilities.....'",
      "sudo yum install -y yum-utils",
      "echo 'Installed latest utilities!!'",

      "echo 'Installing Packer.....'",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum install -y packer",
      "echo 'Installed Packer version ->'",
      "packer --version",

      "echo 'Installing Terraform.....'",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install terraform",
      "echo 'Terraform version installed ->'",
      "terraform -v",

      "echo 'Installing GIT.....'",
      "sudo yum install -y git",
      "echo 'Installed GIT version ->'",
      "git --version"
    ]
  }

  post-processor "manifest" {
    output = "manifest.json"
  }

  post-processor "shell-local" {
    environment_vars = ["REGION=${var.region}"]
    inline = [
      # Extract AMI ID from manifest
      "AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d':' -f2)",
      "echo \"Making AMI $AMI_ID public in region $REGION...\"",

      # Step 1: Temporarily disable block public access
      "echo 'Disabling block public access for AMIs (temporary)...'",
      "aws ec2 disable-image-block-public-access --region $REGION --no-dry-run",

      # Step 2: Make the AMI public
      "aws ec2 modify-image-attribute --region $REGION --image-id $AMI_ID --launch-permission \"Add=[{Group=all}]\"",
      "echo \"AMI is now public: $AMI_ID\"",

      # Step 3: Re-enable block public access
      "echo 'Re-enabling block public access for AMIs...'",
      "aws ec2 enable-image-block-public-access --region $REGION --image-block-public-access-state block-new-sharing --no-dry-run"
    ]
  }
}
