resource "aws_imagebuilder_image_recipe" "java" {
  name         = "java-base"
  description  = "Amazon Linux 2023 with Java runtime"
  parent_image = "ami-0bf05131040dbf2fc"
  version      = "1.0.0"

  component {
    component_arn = aws_imagebuilder_component.java.arn
  }

  block_device_mapping {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type            = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  depends_on = [
    aws_iam_service_linked_role.image_builder
  ]
}