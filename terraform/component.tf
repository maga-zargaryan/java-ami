resource "aws_imagebuilder_component" "java_runtime" {
  name        = "java-runtime"
  description = "Amazon Corretto ${var.java_version}, CloudWatch agent and EFS utilities"
  platform    = "Linux"
  version     = var.component_version

  data = templatefile("${path.module}/../components/java-runtime.yml", {
    java_version = var.java_version
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Bakes the release JAR, its systemd services and the boot-time configurator into the image.
resource "aws_imagebuilder_component" "java_app" {
  name        = "java-app"
  description = "Java application release, services and boot-time configuration"
  platform    = "Linux"
  version     = var.app_component_version

  data = file("${path.module}/../components/java-app.yml")

  lifecycle {
    create_before_destroy = true
  }
}
