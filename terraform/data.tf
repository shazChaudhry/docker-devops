# When we need to create an EC2 resource on AWS using Terraform, we need to specify the AMI id to get the correct image. The id is not easy to memorise and it changes depending on the zone we are working one. On every new release the id changes again. So, how can we be sure to get the correct ID for our region, of the latest image available for a given Linux distribution?
# Find the most recent image by visiting "LaunchInstanceWizard --> Community AMIs page and selecting operating system, architecture and root device type"
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}
