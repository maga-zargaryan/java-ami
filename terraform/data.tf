data "terraform_remote_state" "platform_shared" {
  backend = "s3"

  config = {
    bucket = var.terraform_state_bucket
    key    = "platform/shared/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}