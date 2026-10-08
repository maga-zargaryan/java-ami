aws_region = "eu-west-1"

image_name           = "java-app"
architecture         = "arm64"
build_instance_types = ["t4g.medium"]
java_version         = 21

# Application release baked into the image. Set by java-app's release pull request.
app_version = "0.1.0"
app_commit  = "manual-upload"

# Recipes and components are immutable: bump recipe_version on every release
# (a new app_version is a recipe change) and a component version when its YAML changes.
recipe_version        = "1.0.0"
component_version     = "1.0.0"
app_component_version = "1.0.0"

root_volume_size = 20

# Weekly, and only when the parent image or components have updates.
pipeline_schedule = "cron(0 3 ? * SUN *)"
images_to_keep    = 5
