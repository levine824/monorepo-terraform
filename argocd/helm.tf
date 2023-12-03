provider "helm" {
  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_cluster_ca_cert)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "argocd" {
  namespace        = var.argocd_namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = var.admin_password == "" ? "" : bcrypt(var.admin_password)
  }

  set {
    name  = "configs.params.server.insecure"
    value = var.insecure == false ? false : true
  }

  set {
    name  = "dex.enabled"
    value = var.enable_dex == true ? true : false
  }
}