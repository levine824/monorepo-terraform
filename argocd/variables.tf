variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = ""
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
  default     = ""
}

variable "eks_cluster_ca_cert" {
  description = "Base64 encoded certificate required to communicate with the cluster"
  type        = string
  default     = ""
}

################################################################################
# argocd
################################################################################

variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "argocd"
}

variable "argocd_namespace" {
  description = "Namespace to install ArgoCD chart into"
  type        = string
  default     = "argocd"
}

variable "argocd_chart_version" {
  description = "Version of ArgoCD chart to install"
  type        = string
  default     = "5.27.1" # See https://artifacthub.io/packages/helm/argo/argo-cd for latest version(s)
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes"
  default     = 800 # 10 minutes
}

variable "admin_password" {
  description = "Default Admin Password"
  type        = string
  default     = ""
}

variable "values_file" {
  description = "The name of the ArgoCD helm chart values file to use"
  type        = string
  default     = "values.yaml"
}

variable "enable_dex" {
  type        = bool
  description = "Enabled the dex server?"
  default     = true
}

variable "insecure" {
  type        = bool
  description = "Disable TLS on the ArogCD API Server?"
  default     = false
}

################################################################################
# application_set
################################################################################

variable "application_set_enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether application set are enabled"
}

variable "repo_url" {
  type        = string
  description = "Git repo url"
  default     = "https://github.com/argoproj/argo-cd.git"
}

variable "revision" {
  type        = string
  description = "Git revision"
  default     = "HEAD"
}

variable "path" {
  type        = string
  description = "Git directory"
  default     = "dev/*"
}

variable "target_revision" {
  type        = string
  description = "Target revision"
  default     = "HEAD"
}

variable "application_namespace" {
  type        = string
  description = "Namespace"
  default     = ""
}