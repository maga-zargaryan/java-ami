resource "aws_imagebuilder_image_pipeline" "java" {
  name = "java-base"

  image_recipe_arn                 = aws_imagebuilder_image_recipe.java.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.java.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.java.arn

  status = "DISABLED"

  schedule {
    schedule_expression                = "cron(0 0 ? * SUN *)"
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  depends_on = [
    aws_iam_service_linked_role.image_builder
  ]
}