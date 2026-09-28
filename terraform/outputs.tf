output "image_recipe_arn" {
  value = aws_imagebuilder_image_recipe.java.arn
}

output "image_pipeline_arn" {
  value = aws_imagebuilder_image_pipeline.java.arn
}