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
