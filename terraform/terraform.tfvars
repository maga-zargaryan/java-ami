aws_region = "eu-west-1"

image_name           = "java-base"
architecture         = "arm64"
build_instance_types = ["t4g.medium"]
java_version         = 21

# Bump on every change to the recipe or the component (they are immutable).
recipe_version    = "1.0.0"
component_version = "1.0.0"

root_volume_size = 20

# Weekly, and only when the parent image or components have updates.
pipeline_schedule = "cron(0 3 ? * SUN *)"
images_to_keep    = 5
