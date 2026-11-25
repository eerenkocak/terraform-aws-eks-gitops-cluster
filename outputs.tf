output "cluster_name" {
  description = "Provisioned AWS EKS Cluster Name"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Kubernetes API Server Endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "oidc_provider_arn" {
  description = "ARN of the OIDC Provider for IRSA Pod Authentication"
  value       = aws_iam_openid_connect_provider.eks_oidc.arn
}

output "configure_kubectl" {
  description = "Command to configure local kubectl access to the EKS cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}
