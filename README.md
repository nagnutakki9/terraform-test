# Terraform-Test
Test repo for Fox interivew question

## Requirements

Create the following resources using Terraform:
* An S3 bucket
* An IAM role
* An IAM policy attached to the role that allows it to perform any S3 actions on that bucket and the objects in it
* An EC2 instance with the IAM role attached

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


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.21 |
| aws | >= 3.10 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.10 |

 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| public_key|The local public key path.|string |`true` | yes |
| instance_name|Value for the Name tag on the created EC2 instance|string |`true` | yes |


## Outputs

| Name | Description |
|------|-------------|
| public_ip | aws instance public ip |
| s3-role | IAM Role of s3 bucket|


