resource "aws_imagebuilder_image_recipe" "this" {
  name         = var.image_name
  description  = "Java application ${var.app_version} on Amazon Linux 2023 (${var.architecture}), Java ${var.java_version}"
  parent_image = local.parent_image
  version      = var.recipe_version

  # Patch first, then install the runtime, then bake in the release, then prove the image survives a reboot.
  component {
    component_arn = local.aws_component.update_linux
  }

  component {
    component_arn = aws_imagebuilder_component.java_runtime.arn
  }

  component {
    component_arn = aws_imagebuilder_component.java_app.arn

    parameter {
      name  = "AppVersion"
      value = var.app_version
    }

    parameter {
      name  = "ArtifactsBucket"
      value = data.aws_ssm_parameter.artifacts_bucket.insecure_value
    }
  }

  component {
    component_arn = local.aws_component.reboot_test
  }

  block_device_mapping {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  # The SSM agent ships with Amazon Linux 2023 and is needed at runtime.
  systems_manager_agent {
    uninstall_after_build = false
  }

  lifecycle {
    create_before_destroy = true
  }
}
