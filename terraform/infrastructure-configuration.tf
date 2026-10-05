resource "aws_imagebuilder_infrastructure_configuration" "this" {
  name        = var.image_name
  description = "Private build network without internet access"

  instance_profile_name         = aws_iam_instance_profile.build_instance.name
  instance_types                = var.build_instance_types
  subnet_id                     = data.aws_ssm_parameter.build_subnet_id.value
  security_group_ids            = [data.aws_ssm_parameter.build_security_group_id.value]
  terminate_instance_on_failure = true

  instance_metadata_options {
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  resource_tags = {
    Project = "java-platform"
    Image   = var.image_name
  }
}
