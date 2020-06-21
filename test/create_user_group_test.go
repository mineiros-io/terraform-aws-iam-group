package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/stretchr/testify/assert"
)

// TestCreateUserGroup
// Tests the creation of a IAM Group with two attached default IAM Policies
func TestCreateIamGroup(t *testing.T) {
	t.Parallel()

	randomAwsRegion := aws.GetRandomRegion(t, nil, nil)

	expectedGroupName := strings.ToLower(
		fmt.Sprintf("test-group-%s", random.UniqueId()),
	)

	expectedGroupPath := strings.ToLower(
		fmt.Sprintf("/%s/", random.UniqueId()),
	)

	expectedIamPolicyARNs := []string{
		"arn:aws:iam::aws:policy/ReadOnlyAccess",
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "./create-basic-iam-group",
		Vars: map[string]interface{}{
			"aws_region":  randomAwsRegion,
			"name":        expectedGroupName,
			"path":        expectedGroupPath,
			"policy_arns": expectedIamPolicyARNs,
		},
		Upgrade: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// Will fail the tests if keys return empty outputs
	groupOutputs := terraform.OutputMap(t, terraformOptions, "group")
	groupPolicyAttachmentsOutputs := terraform.OutputMap(t, terraformOptions, "policy_attachment")

	// Validate if the name of the created group matches the name that we defined in name
	assert.Equal(t, expectedGroupName, groupOutputs["name"])

	// Locate two IAM Policy Attachments in the outputs
	assert.Equal(t, len(expectedIamPolicyARNs), len(groupPolicyAttachmentsOutputs), "Expected %d IAM Group Policy Attachments. Got %d instead.", len(expectedIamPolicyARNs), len(groupPolicyAttachmentsOutputs))
}
