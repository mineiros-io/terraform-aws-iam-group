# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TEST MODULE THAT IS USED BY THE UNIT TESTS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

module "iam-group" {
  source = "../.."

  name = "test-group"
  path = "/"
  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}
