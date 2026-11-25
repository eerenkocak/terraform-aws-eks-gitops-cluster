# --- 1. DEDICATED GITOPS NAMESPACE ---
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      managed-by = "terraform"
      tier       = "gitops-controller"
    }
  }

  depends_on = [aws_eks_node_group.private_nodes]
}

# --- 2. AUTOMATED ARGOCD INSTALLATION VIA HELM ---
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://github.io"
  chart      = "argo-cd"
  version    = "7.7.10"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  # FinOps & Lightweight Resource Tuning for Demo/Production Efficiency
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

  depends_on = [kubernetes_namespace.argocd]
}
