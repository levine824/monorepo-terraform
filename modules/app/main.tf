/* provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
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
} */

resource "kubernetes_namespace" "namespace" {
  metadata {
    name   = var.namespace
    labels = {
      "istio-injection" = "enabled"
    }
  }
}

resource "argocd_application_set" "git_directories" {
  metadata {
    name = "git-directories"
    namespace = var.argocd_namespace
  }

  spec {
    generator {
      git {
        repo_url = var.repo_url
        revision = var.revision

        directory {
          path = var.path
        }
      }
    }

    template { 
      metadata {
        name = "{{path.basename}}"
      }

      spec {
        source {
          repo_url        = var.repo_url
          target_revision = "HEAD"
          path            = "{{path}}"
        }

        destination {
          server    = "https://kubernetes.default.svc"
          namespace = var.namespace != "" ? var.namespace:"{{path.basename}}"
        }
      }
    }
  }
}