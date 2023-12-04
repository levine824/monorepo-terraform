variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

################################################################################
# vpc
################################################################################

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "vpcdemo"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type = string 
  default = "10.0.0.0/16"
}

variable "vpc_azs_number" {
  description = "The number of VPC Availability Zones"
  type = number 
  default = "3"
}

variable "vpc_private_subnets" {
  description = "VPC private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  description = "VPC public subnets"
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable nat gateway"
  type = bool
  default = true  
}

variable "vpc_single_nat_gateway" {
  description = "Enable single NAT Gateway"
  type = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable dns hostnames"
  type = bool
  default = true
}

################################################################################
# eks
################################################################################

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eksdemo"
}

variable "eks_cluster_endpoint_public_access" {
  description = "Enable EKS public API server endpoint"
  type        = bool
  default     = true
}

variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
  default     = {
    ami_type = "AL2_x86_64"
  }
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}