output "eks_cluster_name" {
  description = "EKS cluster name"
  value = var.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"  
  value = module.eks.cluster_certificate_authority_data
}