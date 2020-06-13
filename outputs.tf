# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "group" {
  description = "The aws_iam_group object."
  value       = try(aws_iam_group.group[0], null)
}

output "policy" {
  description = "The aws_iam_group_policy object."
  value       = try(aws_iam_group_policy.policy[0], null)
}

output "policy_attachment" {
  description = "The aws_iam_group_policy_attachment object."
  value       = try(aws_iam_group_policy_attachment.policy_attachment[0], null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
output "module_enabled" {
  description = "Whether the module is enabled"
  value       = var.module_enabled
}
