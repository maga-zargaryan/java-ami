data "terraform_remote_state" "platform_shared" {
  backend = "s3"

  config = {
    bucket = var.terraform_state_bucket
    key    = "platform/shared/terraform.tfstate"
    region = var.aws_region
  }
}