variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default     = "/home/root/.ssh/id_rsa.pub"
}

variable "region" {
  description = "AWS London region to launch servers"
  default     = "eu-west-2"
}

variable "aws_credentials" {
  default = "/home/root/.aws/credentials"
}

variable "key_name" {
  default = "deployer-key" # This is the 'id_rsa.pub' registered with AWS above
  description = "the ssh key to use in the EC2 machines"
}

variable "AmiLinux" {
  type = "map"
  default = {
    # https://chankongching.wordpress.com/2017/02/14/aws-ec2-ami-id-listlatest-and-older-versions/
    eu-west-1     = "ami-70edb016"
    eu-west-2     = "ami-f1949e95"
    eu-central-1  = "ami-af0fc0c0"
  }
  description = "Only three regions (Ireland, London, Frankfurt) are added to show the map feature"
}

variable "DnsZoneName" {
  default     = "domain.internal"
  description = "the internal dns name"
}
