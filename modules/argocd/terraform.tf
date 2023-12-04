terraform {
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
    
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
  
  required_version = ">= 1.3"
}