data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_imagebuilder_image_recipe" "java" {
  name         = "java-base"
  description  = "Amazon Linux 2023 with Java runtime"
  parent_image = data.aws_ssm_parameter.al2023.value
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