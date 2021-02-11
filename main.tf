provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  default_for_az    = true
  availability_zone = "${var.region}"
}

//  A keypair for SSH access to the instances.
resource "aws_key_pair" "keypair" {
  key_name   = "test-key"
  public_key = file(var.public_key)
}

resource "aws_s3_bucket" "bucket" {
  bucket = "nag-test"
  acl    = "private"
}

//Block all other access to this bucket other than the specified role.
resource "aws_s3_bucket_policy" "testrole" {
  bucket = aws_s3_bucket.bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
          "AWS" : "${aws_iam_role.role.arn}"
      },
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "access_bucket" {
  name = "test-instance-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "${aws_s3_bucket.bucket.id}_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "aws_iam_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "access_bucket" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from Current Public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }
}


resource "aws_instance" "test" {
  ami                         = var.ami_id
  iam_instance_profile        = aws_iam_instance_profile.access_bucket.name
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.keypair.key_name
  subnet_id                   = data.aws_subnet.default.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}

