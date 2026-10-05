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
