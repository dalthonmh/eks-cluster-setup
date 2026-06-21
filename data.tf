data "aws_caller_identity" "current" {} # Obtiene la identidad del usuario actual de AWS

data "aws_eks_cluster" "this" { # Obtiene la información del clúster de EKS (endpoint, CA, etc.)
  name = aws_eks_cluster.eks_cluster.name
}

data "aws_eks_cluster_auth" "this" { # Obtiene el token de autenticación del clúster de EKS
  name = aws_eks_cluster.eks_cluster.name
}

data "tls_certificate" "this" { # Obtiene el certificado del OIDC provider del clúster de EKS
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}
