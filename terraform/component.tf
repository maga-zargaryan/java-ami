resource "aws_imagebuilder_component" "java" {
  name        = "java-runtime"
  description = "Java runtime for Java application EC2 instances"
  platform    = "Linux"
  version     = "1.0.0"

  data = file("${path.module}/../components/install-java.yml")
}