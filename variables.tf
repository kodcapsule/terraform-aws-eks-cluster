variable "project_name" {
  description = "The name of the project for which the resources are being created."
  type        = string
  default     = "aws-eks-terraform-project"

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