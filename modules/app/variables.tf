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

variable "namespace" {
  type        = string
  description = "Namespace"
  default     = ""
}

variable "argocd_namespace" {
  type        = string
  description = "Argocd namespace"
  default     = ""
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
