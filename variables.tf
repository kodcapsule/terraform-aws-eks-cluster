variable "project_name" {
  description = "The name of the project for which the resources are being created."
  type        = string
  default     = "aws-eks-terraform-project"

}

variable "profile_name" {
  description = "The AWS profile name to use for authentication."
  type        = string
  default     = "default"
  
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the EKS cluster."
  type        = string
  default     = "1.27"

}

variable "region" {
  description = "The AWS region where the resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "The profiles for AWS"
  type        = string
  default     = "my-profile"

}

variable "node_instance_types" {
  description = "The instance types for the EKS worker nodes."
  type        = list(string)
  default     = ["t3.medium", "t3.large"]
  
}

variable "node_desired_size" {
  description = "The desired number of worker nodes in the EKS cluster."
  type        = number
  default     = 2
  
}

variable "node_min_size" {
  description = "The minimum number of worker nodes in the EKS cluster."
  type        = number
  default     = 1
  
}

variable "node_max_size" {
  description = "The maximum number of worker nodes in the EKS cluster."
  type        = number
  default     = 6
  
}