data "aws_ami" "ami" {
  most_recent = true

  filter {
    # get ami name from aws ec2 describe-images --region eu-central-1  --owners amazon --filters "Name=name,Values=amzn2-ami-hvm*" "Name=root-device-type,Values=ebs" "Name=architecture,Values=x86_64"
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220121.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] 
}