# ------------------------------------------------------------------------------
# Example Usage: Create an IAM group called users
# (set all optional variables to their explicit defaults)
# ------------------------------------------------------------------------------

module "terraform-aws-iam-group" {
  source = "git@github.com:mineiros-io/terraform-aws-iam-group.git?ref=v0.0.1"

  # All required module arguments

  name = "users"

  # All optional module arguments set to the default values

  path = "/"

  # create an inline policy
  policy_statements  = []
  policy_name        = null
  policy_name_prefix = null

  # add custom or managed polcies by ARN

  policy_arns = []

  # All optional module configuration arguments set to the default values.
  # Those are maintained for terraform 0.12 but can still be used in terraform 0.13
  # Starting with terraform 0.13 you can additionally make use of module level
  # count, for_each and depends_on features.
  module_enabled    = true
  module_depends_on = []
}

# ------------------------------------------------------------------------------
# Provider Setup
# ------------------------------------------------------------------------------
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

variable "region" {
  type        = string
  description = "The AWS region to run in. Default is 'eu-west-1'"
  default     = "eu-west-1"
}

# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES:
# ------------------------------------------------------------------------------
# You can provide your credentials via the
#   AWS_ACCESS_KEY_ID and
#   AWS_SECRET_ACCESS_KEY, environment variables,
# representing your AWS Access Key and AWS Secret Key, respectively.
# Note that setting your AWS credentials using either these (or legacy)
# environment variables will override the use of
#   AWS_SHARED_CREDENTIALS_FILE and
#   AWS_PROFILE.
# The
#   AWS_DEFAULT_REGION and
#   AWS_SESSION_TOKEN environment variables are also used, if applicable.
# ------------------------------------------------------------------------------
