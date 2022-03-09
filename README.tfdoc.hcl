header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-aws-iam-group"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-aws-iam-group/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-aws-iam-group/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-iam-group.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-aws-iam-group/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-aws-providern" {
    image = "https://img.shields.io/badge/AWS-3%20and%202.0+-F8991D.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-aws/releases"
    text  = "AWS Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-aws-iam-group"
  toc     = true
  content = <<-END
    A [Terraform] base module for creating and managing [IAM Groups] on [Amazon Web Services (AWS)][aws].

    **_This module supports Terraform v1.x, v0.15, v0.14, v0.13, as well as v0.12.20 and above
    and is compatible with the terraform AWS provider v3 as well as v2.0 and above._**
  END

  section {
    title   = "Module Features"
    content = <<-END
      This is a list of features implemented in this module:

      - **Standard Module Features**:
        Create an IAM group

      - **Extended Module Features**:
        Add an inline policy to the group,
        attach custom or managed policies,
        add a list of users to the group.
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most basic usage just setting required arguments:

      ```hcl
      module "terraform-aws-iam-group" {
        source  = "mineiros-io/iam-group/aws"
        version = "~> 0.5.1"

        name = "developers"
      }
      ```

      Advanced usage as found in [examples/example/main.tf] setting all required and optional arguments to their default values.

      ```hcl
      module "terraform-aws-iam-group" {
        source  = "mineiros-io/iam-group/aws"
        version = "~> 0.5.1"

        name = "team"

        path = "/"

        policy_statements  = []
        policy_name        = null
        policy_name_prefix = null

        policy_arns = []

        module_enabled    = true
        module_depends_on = []
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_depends_on" {
          type        = list(any)
          description = <<-END
            A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
          END
        }
      }

      section {
        title = "Main Resource Configuration"

        variable "name" {
          required    = true
          type        = string
          description = <<-END
            The group's name. The name must consist of upper and lower case alphanumeric characters with no spaces. You can also include any of the following characters: `=,.@-_.`. Group names are unique irrespective of capitalization. For example, you cannot create two groups named "ADMINS" and "admins".
          END
        }

        variable "path" {
          type        = string
          default     = "/"
          description = <<-END
            Path in which to create the group.
          END
        }
      }

      section {
        title = "Extended Resource Configuration"

        section {
          title = "Users of the group"

          variable "users" {
            type        = set(string)
            description = <<-END
              List of IAM users to bind to the group.
            END
          }
        }

        section {
          title = "Custom & Managed Policies"

          variable "policy_arns" {
            type        = list(string)
            default     = []
            description = <<-END
              List of IAM custom or managed policy ARNs to attach to the group.
            END
          }
        }

        section {
          title = "Inline Policiy"

          variable "policy_name" {
            type        = string
            description = <<-END
              The name of the group policy. If omitted, Terraform will assign a random, unique name.
            END
          }

          variable "policy_name_prefix" {
            type        = string
            description = <<-END
              Creates a unique name beginning with the specified prefix. Conflicts with name.
            END
          }

          variable "policy_statements" {
            type           = list(policy_statement)
            readme_example = <<-END
              policy_statements = [
                {
                  sid = "FullS3Access"

                  effect = "Allow"

                  actions     = ["s3:*"]
                  not_actions = []

                  resources     = ["*"]
                  not_resources = []

                  conditions = [
                    {
                      test     = "Bool"
                      variable = "aws:MultiFactorAuthPresent"
                      values   = ["true"]
                    }
                  ]
                }
              ]
            END
            description    = <<-END
              List of IAM policy statements to attach to the role as an inline policy.
            END

            attribute "sid" {
              type        = string
              description = <<-END
                An ID for the policy statement.
              END
            }

            attribute "effect" {
              type        = string
              default     = "Allow"
              description = <<-END
                Either "Allow" or "Deny", to specify whether this statement allows or denies the given actions.
              END
            }

            attribute "actions" {
              type        = list(string)
              description = <<-END
                A list of actions that this statement either allows or denies.
              END
            }

            attribute "not_actions" {
              type        = list(string)
              description = <<-END
                A list of actions that this statement does not apply to.
                Used to apply a policy statement to all actions except those listed.
              END
            }

            attribute "principals" {
              type        = list(principal)
              description = <<-END
                A nested configuration block (described below) specifying a resource (or resource pattern) to which this statement applies.
              END

              attribute "type" {
                type        = string
                default     = "AWS"
                description = <<-END
                  The type of principal. For AWS ARNs this is "AWS". For AWS services (e.g. Lambda), this is "Service".
                END
              }

              attribute "identifiers" {
                required    = true
                type        = list(string)
                description = <<-END
                  List of identifiers for principals.
                  When type is "AWS", these are IAM user or role ARNs.
                  When type is "Service", these are AWS Service roles e.g. `lambda.amazonaws.com`.
                END
              }
            }

            attribute "not_principals" {
              type        = list(principal)
              description = <<-END
                Like principals except gives resources that the statement does not apply to.
              END
            }
          }
        }
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported by the module:
    END

    output "group" {
      type        = object(group)
      description = <<-END
        The `aws_iam_group` object.
      END
    }

    output "policy" {
      type        = object(policy)
      description = <<-END
        The `aws_iam_group_policy` object.
      END
    }

    output "policy_attachments" {
      type        = list(policy_attachment)
      description = <<-END
        A list of `aws_iam_group_policy_attachment` objects.
      END
    }

    output "users" {
      type        = list(user)
      description = <<-END
        A list of `aws_iam_group_membership` objects.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "AWS Documentation IAM"
      content = <<-END
        - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html
        - https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html
      END
    }

    section {
      title   = "Terraform AWS Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
        - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
        - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      Mineiros is a [DevOps as a Service][homepage] company based in Berlin, Germany.
      We offer commercial support for all of our projects and encourage you to reach out
      if you have any questions or need help. Feel free to send us an email at [hello@mineiros.io] or join our [Community Slack channel][slack].

      We can also help you with:

      - Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
      - Consulting & training on AWS, Terraform and DevOps
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-aws-iam-group"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-iam-group.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/actions"
  }
  ref "badge-tf-aws" {
    value = "https://img.shields.io/badge/AWS-3%20and%202.0+-F8991D.svg?logo=terraform"
  }
  ref "releases-aws-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-aws/releases"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg"
  }
  ref "iam groups" {
    value = "https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "examples/example/main.tf" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples/example/main.tf"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/CONTRIBUTING.md"
  }
}
