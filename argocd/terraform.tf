terraform {
  
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
    argocd = {
      source = "oboukili/argocd"
      version = ">= 6.0.3"
    }
  }
  
  required_version = ">= 1.3"
}