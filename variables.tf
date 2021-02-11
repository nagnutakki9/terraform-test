variable "region" {
  default = "us-west-2"
}

variable "public_key" {
  description = "The local public key path. Default: ~/.ssh/id_rsa.pub"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_name" {
  description = "Value for the Name tag on the created EC2 instance. If none provided, will default to random pet name"
  type        = string
  default     = "Test-Instance"
}
//
variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  default = "ami-0a36eb8fadc976275"
}

variable "environment" {
  type        = string
  default     = "Dev"
}


variable "ssh_permit" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "ubuntu_account_number" {
  default = "099720109477"
}