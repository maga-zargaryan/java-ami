data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "build_instance" {
  name                 = "java-ami-build-instance"
  description          = "Image Builder build and test instances"
  assume_role_policy   = data.aws_iam_policy_document.ec2_assume.json
  permissions_boundary = local.boundary_arn
}

resource "aws_iam_role_policy_attachment" "build_instance" {
  for_each = toset([
    "AmazonSSMManagedInstanceCore",
    "EC2InstanceProfileForImageBuilder",
  ])

  role       = aws_iam_role.build_instance.name
  policy_arn = "arn:${local.partition}:iam::aws:policy/${each.value}"
}

resource "aws_iam_instance_profile" "build_instance" {
  name = "java-ami-build-instance"
  role = aws_iam_role.build_instance.name
}

data "aws_iam_policy_document" "imagebuilder_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["imagebuilder.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
  }
}

resource "aws_iam_role" "lifecycle" {
  name                 = "java-ami-lifecycle"
  description          = "Image Builder lifecycle policy execution (deletes old AMIs and snapshots)"
  assume_role_policy   = data.aws_iam_policy_document.imagebuilder_assume.json
  permissions_boundary = local.boundary_arn
}

resource "aws_iam_role_policy_attachment" "lifecycle" {
  role       = aws_iam_role.lifecycle.name
  policy_arn = "arn:${local.partition}:iam::aws:policy/service-role/EC2ImageBuilderLifecycleExecutionPolicy"
}
