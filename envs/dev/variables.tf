################################################################################
# aws
################################################################################
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "vpcdemo"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eksdemo"
}

################################################################################
# argocd
################################################################################

variable "admin_password" {
  description = "Default Admin Password"
  type        = string
}

################################################################################
# app
################################################################################

variable "repo_url" {
  type        = string
  description = "Git repo url"
  default     = "https://github.com/levine824/monorepo-argocd.git"
}

variable "path" {
  type        = string
  description = "Git directory"
  default     = "dev/*"
}