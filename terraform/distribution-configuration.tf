resource "aws_imagebuilder_distribution_configuration" "this" {
  name        = var.image_name
  description = "Distributes tagged ${var.image_name} AMIs; consumers pin them by AMI ID"

  distribution {
    region = var.aws_region

    ami_distribution_configuration {
      name        = "${var.image_name}-${var.app_version}-${var.architecture}-{{ imagebuilder:buildDate }}"
      description = "Java application ${var.app_version} on Amazon Linux 2023 (${var.architecture}), Java ${var.java_version}"

      ami_tags = {
        Name         = var.image_name
        Project      = "java-platform"
        Image        = var.image_name
        Architecture = var.architecture
        Java         = tostring(var.java_version)
        AppVersion   = var.app_version
      }
    }
  }
}
