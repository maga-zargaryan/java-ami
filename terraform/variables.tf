variable "aws_region" {
  description = "AWS region where images are built and distributed."
  type        = string
}

variable "image_name" {
  description = "Base name of the recipe, pipeline and AMIs."
  type        = string
}

variable "architecture" {
  description = "CPU architecture of the image."
  type        = string

  validation {
    condition     = contains(["arm64", "x86"], var.architecture)
    error_message = "architecture must be arm64 or x86."
  }
}

variable "build_instance_types" {
  description = "Instance types for build and test instances; must match the architecture."
  type        = list(string)
}

variable "java_version" {
  description = "Amazon Corretto major version."
  type        = number
}

variable "recipe_version" {
  description = "Semantic version of the image recipe. Recipes are immutable: bump it on every recipe or component change."
  type        = string

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.recipe_version))
    error_message = "recipe_version must be a semantic version (major.minor.patch)."
  }
}

variable "git_commit" {
  description = "java-ami commit the image definition was applied from; tagged on every AMI for traceability. Set by CI."
  type        = string
  default     = "local"
}

variable "app_commit" {
  description = "java-app commit the baked release was built from (set by the java-app release pull request)."
  type        = string
}

variable "app_version" {
  description = "Application release baked into the image (s3://<artifacts>/java-app/<app_version>/app.jar)."
  type        = string

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.app_version))
    error_message = "app_version must be a semantic version (major.minor.patch)."
  }
}

variable "app_component_version" {
  description = "Semantic version of the java-app component. Bump it on every change to components/java-app.yml."
  type        = string

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.app_component_version))
    error_message = "app_component_version must be a semantic version (major.minor.patch)."
  }
}

variable "component_version" {
  description = "Semantic version of the Java runtime component. Components are immutable: bump it on every change."
  type        = string

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.component_version))
    error_message = "component_version must be a semantic version (major.minor.patch)."
  }
}

variable "root_volume_size" {
  description = "Root volume size in GiB."
  type        = number
}

variable "pipeline_schedule" {
  description = "Cron expression for scheduled rebuilds (patching cadence)."
  type        = string
}

variable "images_to_keep" {
  description = "Number of most recent images (AMIs and snapshots) kept by the lifecycle policy."
  type        = number
}
