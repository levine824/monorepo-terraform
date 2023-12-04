terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }

    argocd = {
      source = "oboukili/argocd"
      version = ">= 6.0.3"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.1.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state"
    key    = "monorepo/dev/terraform.state"
    region = "cn-north-1"
  }

  required_version = "~> 1.3"
}