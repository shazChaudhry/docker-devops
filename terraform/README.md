## Prerequisites
- Ensure that a .pem key is available under: "~/.ssh/" on the host dev machine. In my case it is called personal.pem
- Ensure that AWS credentials are available at: "~/.aws/credentials" on the host dev machine
```
      [default]
      aws_access_key_id = <KEY>
      aws_secret_access_key = <SECRET>
```
- Ensure that a S3 bucket as a backend type is created. See the docs [here](https://www.terraform.io/docs/backends/types/s3.html)
```
      terraform {
        # It is expected that the bucket, globally unique, already exists
        backend "s3" {
          bucket  = "ci.terraform"
          key     = "docker-devops/terraform.tfstate"
          region  = "eu-west-2"
          encrypt = true
        }
      }
```
- Ensure that you have an IAM role called "shaz" that have the permissions as follows. This role will be used to launch EC2 instance from where you can connect to S3 over VPC endpoint rather than the internet:
  - AmazonS3FullAccess
  - AdministratorAccess
