[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Build Status][badge-build]][build-status]
[![GitHub tag (latest SemVer)][badge-semver]][releases-github]
[![Terraform Version][badge-terraform]][releases-terraform]
[![AWS Provider Version][badge-tf-aws]][releases-aws-provider]
[![Join Slack][badge-slack]][slack]

# terraform-aws-iam-group

A [Terraform] base module for creating and managing [IAM Groups] on [Amazon Web Services (AWS)][aws].

**_This module supports Terraform v1.x, v0.15, v0.14, v0.13, as well as v0.12.20 and above
and is compatible with the terraform AWS provider v3 as well as v2.0 and above._**

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

- _Features not yet implemented_:
  [`iam_group_membership`](https://www.terraform.io/docs/providers/aws/r/iam_group_membership.html)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-aws-iam-group" {
  source  = "mineiros-io/iam-group/aws"
  version = "~> 0.4.0"

  name = "developers"
}
```

Advanced usage as found in [examples/example/main.tf] setting all required and optional arguments to their default values.

```hcl
module "terraform-aws-iam-group" {
  source  = "mineiros-io/iam-group/aws"
  version = "~> 0.4.0"

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

- **`module_enabled`**: _(Optional `bool`)_

  Specifies whether resources in the module will be created.
  Default is `true`.

- **`module_depends_on`**: _(Optional `list(any)`)_

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

#### Main Resource Configuration

- **`name`**: **(Required `string`)**

  The group's name. The name must consist of upper and lower case alphanumeric characters with no spaces. You can also include any of the following characters: `=,.@-_.`. Group names are unique irrespective of capitalization. For example, you cannot create two groups named "ADMINS" and "admins".

- **`path`**: _(Optional `string`)_

  Path in which to create the group.
  Default is `"/"`

#### Extended Resource Configuration

##### Custom & Managed Policies

- **`policy_arns`**: _(Optional `list(string)`)_

  List of IAM custom or managed policy ARNs to attach to the group.

##### Inline Policiy

- **`policy_name`**: _(Optional `string`)_

  The name of the group policy. If omitted, Terraform will assign a random, unique name.

- **`policy_name_prefix`**: _(Optional `string`)_

  Creates a unique name beginning with the specified prefix. Conflicts with name.

- **`policy_statements`**: _(Optional `list(statement)`)_

  List of IAM policy statements to attach to the role as an inline policy.

  ```hcl
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
  ```

## Module Attributes Reference

The following attributes are exported by the module:

- **`group`**: The `aws_iam_group` object.
- **`policy`**: The `aws_iam_group_policy` object.
- **`policy_attachments`**: A list of aws_iam_group_policy_attachment objects.

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

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-aws-iam-group
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-aws-iam-group/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-aws-iam-group.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|%200.15%20|%200.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-aws-iam-group/actions
[badge-tf-aws]: https://img.shields.io/badge/AWS-3%20and%202.0+-F8991D.svg?logo=terraform
[releases-aws-provider]: https://github.com/terraform-providers/terraform-provider-aws/releases
[releases-github]: https://github.com/mineiros-io/terraform-aws-iam-group/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
[iam groups]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[examples/example/main.tf]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples/example/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples
[issues]: https://github.com/mineiros-io/terraform-aws-iam-group/issues
[license]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-aws-iam-group/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/CONTRIBUTING.md
