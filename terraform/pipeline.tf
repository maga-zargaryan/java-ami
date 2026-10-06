resource "aws_imagebuilder_image_pipeline" "this" {
  name        = var.image_name
  description = "Builds, tests and distributes the ${var.image_name} AMI"

  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn
  enhanced_image_metadata_enabled  = true
  status                           = "ENABLED"

  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 60
  }

  # Rebuild on a schedule only when the parent image or a component has an update.
  schedule {
    schedule_expression                = var.pipeline_schedule
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }
}

resource "aws_imagebuilder_lifecycle_policy" "this" {
  name           = var.image_name
  description    = "Keep the ${var.images_to_keep} most recent ${var.image_name} images, plus any in use"
  execution_role = aws_iam_role.lifecycle.arn
  resource_type  = "AMI_IMAGE"

  policy_detail {
    action {
      type = "DELETE"

      include_resources {
        amis      = true
        snapshots = true
      }
    }

    filter {
      type  = "COUNT"
      value = var.images_to_keep
    }

    # Never delete an AMI an environment still runs: java-infra tags the AMI it
    # deploys with InUse-<environment>=true.
    exclusion_rules {
      amis {
        tag_map = {
          "InUse-dev"  = "true"
          "InUse-prod" = "true"
        }
      }
    }
  }

  resource_selection {
    recipe {
      name             = aws_imagebuilder_image_recipe.this.name
      semantic_version = "x.x.x"
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lifecycle]
}
