provider "aws" {
  region = var.region
}

module "cluster" {
  source = "../../modules/cluster"
  
  vpc_name = var.vpc_name
  
  eks_cluster_name = var.eks_cluster_name
}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.aws_eks_cluster.cluster.name
      ]
    }
  }
}

module "argocd" {
  source = "../../modules/argocd"

  admin_password = var.admin_password
}

module "istio" {
  source = "../../modules/istio"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

module "app" {
  source = "../../modules/app"

  repo_url = var.repo_url

  path = var.path
}