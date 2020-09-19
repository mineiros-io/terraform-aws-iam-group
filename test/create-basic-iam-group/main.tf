# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TEST MODULE THAT IS USED BY THE UNIT TESTS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "The AWS region to deploy the example in."
  type        = string
}

module "test" {
  source = "../.."

  name = "test-group"
  path = "/test/"
  policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}

output "test" {
  description = "All outputs exposed by the module."
  value       = module.test
}
