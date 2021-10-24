package module_test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/stretchr/testify/assert"

	gcp "github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()

	exampleDir := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/basic")

	// Get the Project Id to use
	projectId := gcp.GetGoogleProjectIDFromEnvVar(t)

	// Give the example bucket a unique name so we can distinguish it from any other bucket in your GCP account
	bucket_name := fmt.Sprintf("basic-%s", strings.ToLower(random.UniqueId()))
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: exampleDir,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"project_id":  projectId,
			"bucket_name": bucket_name,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of some of the output variables
	bucket_name_output := terraform.Output(t, terraformOptions, "bucket_name")

	// Verify that the Storage Bucket exists
	assert.Equal(t, bucket_name, bucket_name_output)

	//gcp.AssertStorageBucketExists(t, bucket_name_output)
}
