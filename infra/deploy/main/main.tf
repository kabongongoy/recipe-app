terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }

  backend "s3" {
    bucket               = "hoitcs-tf-state"
    key                  = "recipe-api/tf-deploy-setup"
    region               = "us-east-1"
    encrypt              = true
    workspace_key_prefix = "tf-state-deploy-env"
    dynamodb_table       = "recipe-app-lock"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManageBy    = "Terraform/deploy"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}

