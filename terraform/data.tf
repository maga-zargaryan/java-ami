data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

locals {
  account_id   = data.aws_caller_identity.current.account_id
  partition    = data.aws_partition.current.partition
  boundary_arn = "arn:${local.partition}:iam::${local.account_id}:policy/java-platform-permissions-boundary"

  parent_image = "arn:${local.partition}:imagebuilder:${var.aws_region}:aws:image/amazon-linux-2023-${var.architecture}/x.x.x"
  aws_component = {
    update_linux = "arn:${local.partition}:imagebuilder:${var.aws_region}:aws:component/update-linux/x.x.x"
    reboot_test  = "arn:${local.partition}:imagebuilder:${var.aws_region}:aws:component/reboot-test-linux/x.x.x"
  }
}

# Build network published by platform-infra (shared stack).
data "aws_ssm_parameter" "build_subnet_id" {
  name = "/java-platform/shared/build_subnet_id"
}

data "aws_ssm_parameter" "build_security_group_id" {
  name = "/java-platform/shared/build_security_group_id"
}
