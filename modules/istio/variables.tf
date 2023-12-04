/* variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eksdemo"
} */

variable "base_enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether Istio base CRDs are enabled"
}

variable "istiod_enabled" {
  description = "Variable indicating whether istiod is enabled"
  type        = bool
  default     = true
}

variable "ingressgateway_enabled" {
  description = "Variable indicating whether Istio ingress gateway is enabled"

  type        = bool
  default     = true
}

variable "helm_chart_repo" {
  description = "Istio repository name"
  type        = string
  default     = "https://istio-release.storage.googleapis.com/charts"
}

variable "helm_chart_version" {
  description = "Istio helm chart version"
  type        = string
  default     = "1.13.3"
}

variable "create_namespace" {
  description = "Whether to create Kubernetes namespace with name defined by `namespace`"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Kubernetes namespace for Istio"
  type        = string
  default     = "istio"
}

variable "base_settings" {
  description = "Additional settings which will be passed to the Istio Base Helm chart values"
  default     = {}
}

variable "istiod_settings" {
  description = "Additional settings which will be passed to the Istio Discovery Helm chart values"
  default     = {}
}

variable "ingressgateway_settings" {
  description = "Additional settings which will be passed to the Istio Ingress Gateway Helm chart values"
  default     = []
}