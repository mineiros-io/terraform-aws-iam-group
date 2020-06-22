package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/gruntwork-io/terratest/modules/aws"
)

func TestCreateIamGroup(t *testing.T) {
	t.Parallel()

	randomAwsRegion := aws.GetRandomRegion(t, nil, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "./create-basic-iam-group",
		Vars: map[string]interface{}{
			"aws_region": randomAwsRegion,
		},
		Upgrade: true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
