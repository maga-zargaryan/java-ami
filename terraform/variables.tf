variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "terraform_state_bucket" {
  type = string
}

variable "java_version" {
  type    = string
  default = "21"
}