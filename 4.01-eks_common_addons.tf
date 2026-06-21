resource "aws_eks_addon" "coredns" { # Instala el add-on CoreDNS en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "coredns"
  addon_version               = var.eks.addons.coredns.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_addon.vpc_cni # CoreDNS necesita red funcional (VPC CNI primero)
  ]

  timeouts {
    create = local.eks_addons_create_timeout
  }
}

resource "aws_eks_addon" "kube_proxy" { # Instala el add-on kube-proxy en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = var.eks.addons.kube_proxy.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_addon.vpc_cni
  ]

  timeouts {
    create = local.eks_addons_create_timeout
  }
}

# Deshabilitado para levantar el cluster más rápido en prácticas.
# resource "aws_eks_addon" "eks_node_monitoring_agent" { ... }
