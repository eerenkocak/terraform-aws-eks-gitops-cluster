variable "aws_region" {
  description = "Target AWS region for EKS deployment"
  type        = string
  default     = "eu-north-1"
}

variable "cluster_name" {
  description = "Name of the Kubernetes EKS cluster"
  type        = string
  default     = "prod-gitops-eks-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes control plane version"
  type        = string
  default     = "1.30"
}

variable "node_instance_type" {
  description = "Worker node EC2 instance type constrained by FinOps guardrails"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = contains(["t3.small", "t3.medium"], var.node_instance_type)
    error_message = "FinOps Guardrail: Worker nodes are restricted to t3.small or t3.medium to prevent runaway cloud costs."
  }
}
