output "image_pipeline_arn" {
  value = aws_imagebuilder_image_pipeline.this.arn
}

output "image_recipe_arn" {
  value = aws_imagebuilder_image_recipe.this.arn
}

output "ami_ssm_parameter" {
  value = local.ami_parameter_name
}
