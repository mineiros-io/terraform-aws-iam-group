# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TEST MODULE THAT IS USED BY THE UNIT TESTS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

variable "aws_region" {
  description = "The AWS region to deploy the example in."
  type        = string
}

variable "name" {
  description = "The name of the group."
  type        = string
}

variable "path" {
  type        = string
  description = "The path to the group. See IAM Identifiers for more information."
}

variable "policy_arns" {
  description = "A list of IAM Policy ARNs that will be attached to the created IAM group."
  type        = set(string)
}
