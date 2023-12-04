/* provider "aws" {
  region = var.region
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
} */

resource "helm_release" "istio_base" {
  count      = var.base_enabled ? 1 : 0
  name       = "istio-base"
  repository = var.helm_chart_repo
  chart      = "base"
  version    = var.helm_chart_version
  create_namespace = var.create_namespace
  namespace  = var.namespace

  values = [
    yamlencode(var.base_settings)
  ]

}

resource "helm_release" "istiod" {
  depends_on = [
    helm_release.istio_base
  ]
  count      = var.istiod_enabled ? 1 : 0
  name       = "istio-istiod"
  repository = var.helm_chart_repo
  chart      = "istiod"
  version    = var.helm_chart_version
  namespace  = var.namespace

  values = [
    yamlencode(var.istiod_settings)
  ]

}

resource "helm_release" "istio_ingressgateway" {
  depends_on = [
    helm_release.istiod
  ]
  count      = var.ingressgateway_enabled ? length(var.ingressgateway_settings) : 0
  name       = var.ingressgateway_settings[count.index].name
  repository = var.helm_chart_repo
  chart      = "gateway"
  version    = var.helm_chart_version
  namespace  = var.namespace

  set {
    name  = "securityContext.fsGroup"
    value = 1337
  }

  set {
    name  = "securityContext.runAsGroup"
    value = 1337
  }

  set {
    name  = "securityContext.runAsNonRoot"
    value = true
  }

  set {
    name  = "securityContext.runAsUser"
    value = 1337
  }

  values = [
    yamlencode(var.ingressgateway_settings[count.index].settings)
  ]

}