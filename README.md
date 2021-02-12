# Terraform-Test
Test repo for Fox interivew question

## Requirements

Create the following resources using Terraform:
* An S3 bucket
* An IAM role
* An IAM policy attached to the role that allows it to perform any S3 actions on that bucket and the objects in it
* An EC2 instance with the IAM role attached
* Output the public IP of the EC2 instance and the S3 bucket name.
Create a README.md and document all assumptions you’ve made. Login to the EC2 instance and validate that you’re able to access the bucket using the role.

## Assumptions

* Default VPC exist
* S3 bucket policy and assumed role access should be explicit but not exclusive and otherwise private
* Construct as a module for use in other projects and provide implementation example
* Construct tests proving that EC2 instance is accessible and that it is able to create/list/delete objects under the specified bucket
* Provide input variables for flexible implementation with defaults that permit minimal configuration and allows for dependency inversion on key networking infrastructure such as preferred VPC.

## Usage
* Clone the repo
* cd into it
* run `terraform init`
* run `terraform apply`

|Name|Version|
|terraform	>= 0.12.21|
|aws	>= 3.10|
