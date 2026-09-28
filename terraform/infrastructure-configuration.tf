resource "aws_imagebuilder_infrastructure_configuration" "java" {
  name = "java-base"

  instance_profile_name = aws_iam_instance_profile.image_builder.name

  subnet_id = data.terraform_remote_state.platform_shared.outputs.private_subnet_ids[0]

  security_group_ids = [
    data.terraform_remote_state.platform_shared.outputs.endpoint_security_group_id
  ]

  terminate_instance_on_failure = true

  instance_metadata_options {
    http_tokens = "required"
  }
}