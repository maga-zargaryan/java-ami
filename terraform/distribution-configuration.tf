resource "aws_imagebuilder_distribution_configuration" "java" {
  name = "java-base"

  distribution {
    region = var.aws_region

    ami_distribution_configuration {
      name = "java-base-{{ imagebuilder:buildDate }}"

      description = "Java base AMI based on Amazon Linux 2023"
    }
  }
}