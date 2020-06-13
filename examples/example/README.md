[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

## Basic usage
The code in [main.tf] creates an IAM group called users.
```hcl
module "terraform-aws-iam-group" {
  source = "git@github.com:mineiros-io/terraform-aws-iam-group.git?ref=v0.0.1"

  name = "users"
  path = "/"

  policy_statements  = []
  policy_name        = null
  policy_name_prefix = null

  policy_arns = []

  module_enabled    = true
  module_depends_on = []
}
```

## Running the example

### Cloning the repository
```bash
git clone https://github.com/mineiros-io/terraform-aws-iam-group.git
cd terraform-aws-iam-group/examples/example
```

### Initializing Terraform
Run `terraform init` to initialize the example.

### Planning the example
Run `terraform plan` to see a plan of the changes.

### Applying the example
Run `terraform apply` to create the resources. You will see a plan of the changes and terraform will prompt you for approval to actually apply the changes.

### Destroying the example
Run `terraform destroy` to destroy all resources again.

<!-- References -->

<!-- markdown-link-check-disable -->
[main.tf]: https://github.com/mineiros-io/terraform-aws-iam-group/blob/master/examples/example/main.tf
<!-- markdown-link-check-enable -->

[homepage]: https://mineiros.io/?ref=terraform-aws-iam-group

[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-0.13%20and%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
