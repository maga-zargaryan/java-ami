resource "aws_iam_role" "image_builder_instance" {
  name = "java-ami-image-builder-instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.image_builder_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "image_builder" {
  name = "java-ami-image-builder"
  role = aws_iam_role.image_builder_instance.name
}

resource "aws_iam_service_linked_role" "image_builder" {
  aws_service_name = "imagebuilder.amazonaws.com"
}