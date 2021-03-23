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


https://teams.microsoft.com/dl/launcher/launcher.html?url=%2F_%23%2Fl%2Fmeetup-join%2F19%3Ameeting_MDBiMzk2MDItMDgwNS00NGVkLThmYTUtZDhjZjJlMWUwMzUx%40thread.v2%2F0%3Fcontext%3D%257b%2522Tid%2522%253a%2522eeb53a15-a2e4-46de-8608-22657ab58979%2522%252c%2522Oid%2522%253a%2522d88cdffd-fd3e-4c7c-bbd9-68a5b4c97f8c%2522%257d%26anon%3Dtrue&type=meetup-join&deeplinkId=986cf82d-aa81-457d-9918-80394b6192db&directDl=true&msLaunch=true&enableMobilePage=true&suppressPrompt=true
