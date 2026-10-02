resource "aws_imagebuilder_distribution_configuration" "this" {
  name        = var.image_name
  description = "Distributes ${var.image_name} AMIs and publishes the latest AMI ID to SSM"

  distribution {
    region = var.aws_region

    ami_distribution_configuration {
      name        = "${var.image_name}-${var.architecture}-{{ imagebuilder:buildDate }}"
      description = "Amazon Linux 2023 (${var.architecture}) with Java ${var.java_version}"

      ami_tags = {
        Name         = var.image_name
        Project      = "java-platform"
        Image        = var.image_name
        Architecture = var.architecture
        Java         = tostring(var.java_version)
      }
    }

    # java-infra resolves the AMI from this parameter.
    ssm_parameter_configuration {
      parameter_name = "/java-platform/ami/${var.image_name}"
      data_type      = "aws:ec2:image"
    }
  }
}
