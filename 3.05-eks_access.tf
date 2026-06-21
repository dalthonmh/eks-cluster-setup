resource "aws_eks_access_entry" "admin_access_entry" { # Crea una entrada de acceso a EKS usando el principal que ejecuta Terraform
  cluster_name  = var.eks.cluster_name
  principal_arn = data.aws_caller_identity.current.arn # Otorga acceso automáticamente al usuario/rol que ejecuta terraform apply (soluciona "invalid principal")
  type          = "STANDARD"

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_access_policy_association" "admin_access_policy_association" { # Asocia la política de admin
  cluster_name  = var.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = data.aws_caller_identity.current.arn

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.admin_access_entry]
}
