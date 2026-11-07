terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.72.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }
  }
}

provider "github" {
  owner = "HalitCam"
  token = var.github_token
}

provider "aws" {
  region = "us-east-1"
}