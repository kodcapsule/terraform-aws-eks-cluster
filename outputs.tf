
output "vpc_id" {
  description = "The ID of the VPC created."
  value       = module.vpc.vpc_id

}

output "cluster_id" {
  description = "The ID of the EKS cluster created."
  value       = module.eks.cluster_id
  
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster created."
  value       = module.eks.cluster_arn

}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = module.eks.cluster_endpoint
  
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster."
  value       = module.eks.cluster_security_group_id
  
}

output "kubectl_config" {
  description = "The kubeconfig for the EKS cluster."
  value       = module.eks.kubeconfig
  
}