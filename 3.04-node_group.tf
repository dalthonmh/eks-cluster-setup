resource "aws_eks_node_group" "eks_node_group" { # Crea un grupo de nodos administrados para los worker nodes de EKS
  cluster_name    = var.eks.cluster_name
  node_group_name = var.eks.worker_nodes.node_group_name
  node_role_arn   = aws_iam_role.eks_worker_node_iam_role.arn # Asocia el rol IAM de los worker nodes de EKS
  capacity_type   = var.eks.worker_nodes.capacity_type        # ON_DEMAND o SPOT (mejor que solo etiqueta)
  subnet_ids = [                                              # Usamos 2 AZs (mínimo requerido indirectamente por EKS)
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]

  scaling_config {
    desired_size = var.eks.worker_nodes.min_size
    max_size     = var.eks.worker_nodes.max_size
    min_size     = var.eks.worker_nodes.min_size
  }

  launch_template {
    id      = aws_launch_template.eks_worker_node_template.id
    version = aws_launch_template.eks_worker_node_template.latest_version
  }

  node_repair_config { # Configura la reparación de los worker nodes (para reemplazar los worker nodes no saludables, si se combina con el eks-node-monitoring-agent se pueden responder a problemas adicionales)
    enabled = var.eks.worker_nodes.node_repair_enabled
  }

  update_config {                                                                # Configura la actualización de los worker nodes durante una actualización del grupo de nodos
    max_unavailable_percentage = var.eks.worker_nodes.max_unavailable_percentage # Porcentaje máximo de worker nodes que pueden estar no disponibles durante una actualización
  }

  labels = { # Asigna etiquetas a los worker nodes
    name = var.eks.worker_nodes.node_group_name
  }

  tags = {
    Name = "eks-node-group"
  }

  depends_on = [
    aws_iam_role.eks_worker_node_iam_role,
    aws_launch_template.eks_worker_node_template,
    aws_subnet.private_subnet_1,
    aws_subnet.private_subnet_2,
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size] # Permite cambios externos en el tamaño deseado del grupo de nodos (por ejemplo, Application Autoscaling)
  }
}
