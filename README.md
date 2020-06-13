[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Build Status][badge-build]][build-status]
[![GitHub tag (latest SemVer)][badge-semver]][releases-github]
[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

# terraform-aws-iam-group

A [Terraform] 0.12 base module for creating and managing [IAM Groups] on [Amazon Web Services (AWS)][AWS].

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
      - [Custom & Managed Policies](#custom--managed-policies)
      - [Inline Policiy](#inline-policiy)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This is a list of features implemented in this module:

- **Standard Module Features**:
  Create an IAM group

- **Extended Module Features**:
  Add an inline policy to the group,
  attach custom or managed policies.

- *Features not yet implemented*:
  [`iam_group_membership`](https://www.terraform.io/docs/providers/aws/r/iam_group_membership.html)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-aws-iam-group" {
  source = "git@github.com:mineiros-io/terraform-aws-iam-group.git?ref=v0.0.1"

  name = "developers"
}
```

Advanced usage as found in [examples/example/main.tf] setting all required and optional arguments to their default values.

```hcl
module "terraform-aws-iam-group" {
  source = "git@github.com:mineiros-io/terraform-aws-iam-group.git?ref=v0.0.1"

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

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_enabled`**: *(Optional `bool`)*

     Specifies whether resources in the module will be created.
     Default is `true`.

- **`module_depends_on`**: *(Optional `list(any)`)*

     A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

#### Main Resource Configuration
- **`name`**: **(Required `string`)**

  The group's name. The name must consist of upper and lower case alphanumeric characters with no spaces. You can also include any of the following characters: `=,.@-_.`. Group names are unique irrespective of capitalization. For example, you cannot create two groups named "ADMINS" and "admins".
- **`path`**: *(Optional `string`)*

  Path in which to create the group.
  Default is `"/"`

#### Extended Resource Configuration

##### Custom & Managed Policies

- **`policy_arns`**: *(Optional `list(string)`)*

  List of IAM custom or managed policies ARNs to attach to the group.

##### Inline Policiy

- **`policy_name`**: *(Optional `string`)*

  The name of the group policy. If omitted, Terraform will assign a random, unique name.

- **`policy_name_prefix`**: *(Optional `string`)*

  Creates a unique name beginning with the specified prefix. Conflicts with name.

- **`policy_statements`**: *(Optional `list(statement)`)*

  List of IAM policy statements to attach to the role as an inline policy.

  ```hcl
  policy_statements = [
    {
      sid = "FullS3Access"

      effect = "Allow"

      actions     = [ "s3:*" ]
      not_actions = []

      resources     = [ "*" ]
      not_resources = []

      conditions = [
        {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = [ "true" ]
        }
      ]
    }
  ]
  ```

## Module Attributes Reference

The following attributes are exported by the module:

- **`group`**: The `aws_iam_group` object.
- **`policy`**: The `aws_iam_group_policy` object.
- **`policy_attachment`**: The `aws_iam_group_policy_attachment` object.

## External Documentation

- AWS Documentation IAM:
  - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html
  - https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html

- Terraform AWS Provider Documentation:
  - https://www.terraform.io/docs/providers/aws/r/iam_group.html
  - https://www.terraform.io/docs/providers/aws/r/iam_group_policy.html
  - https://www.terraform.io/docs/providers/aws/r/iam_group_policy_attachment.html

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service][homepage] company based in Berlin, Germany.
We offer commercial support for all of our projects and encourage you to reach out
if you have any questions or need help. Feel free to send us an email at [hello@mineiros.io] or join our [Community Slack channel][slack].

We can also help you with:

- Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
- Consulting & training on AWS, Terraform and DevOps

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-aws-iam-group
[hello@mineiros.io]: mailto:hello@mineiros.io

[badge-build]: https://mineiros.semaphoreci.com/badges/terraform-aws-iam-group/branches/master.svg?style=shields&key=547999de-c52c-4cde-846b-e74796818a6a
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-iam-group.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-0.13%20and%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

<!-- markdown-link-check-disable -->
[build-status]: https://mineiros.semaphoreci.com/projects/terraform-aws-iam-group
[releases-github]: https://github.com/mineiros-io/terraform-aws-iam-group/releases
<!-- markdown-link-check-enable -->
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg

[IAM Groups]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html

[Terraform]: https://www.terraform.io
[AWS]: https://aws.amazon.com/
[Semantic Versioning (SemVer)]: https://semver.org/

<!-- markdown-link-check-disable -->
[examples/example/main.tf]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples/example/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples
[Issues]: https://github.com/mineiros-io/terraform-aws-iam-group/issues
[LICENSE]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/LICENSE
[Makefile]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/Makefile
[Pull Requests]: https://github.com/mineiros-io/terraform-aws-iam-group/pulls
[Contribution Guidelines]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/CONTRIBUTING.md
<!-- markdown-link-check-enable -->
