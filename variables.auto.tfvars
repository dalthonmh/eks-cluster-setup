aws_user = "cloud_user"

eks = {
  addons = {
    # IMPORTANTE: Las versiones de addons deben ser compatibles con tu cluster_version.
    # Obtén las versiones correctas con estos comandos (cambia 1.36 si usas otra versión):
    # aws eks describe-addon-versions --kubernetes-version 1.36 --addon-name <nombre> \
    #   --query 'addons[0].addonVersions[?compatibilities[0].defaultVersion==`true`].addonVersion' --output text
    aws_ebs_csi_driver = {
      version = "v1.62.0-eksbuild.1"
    }
    coredns = {
      version = "v1.14.2-eksbuild.4"
    }
    eks_node_monitoring_agent = {
      version = "v1.6.6-eksbuild.1"
    }
    kube_proxy = {
      version = "v1.36.0-eksbuild.7"
    }
    vpc_cni = {
      version = "v1.21.2-eksbuild.2"
    }
  }
  cluster_name    = "eks-cluster"
  cluster_version = "1.36"  # Asegúrate de que las versiones de addons coincidan con esta
  ebs_storage_class = {
    allow_volume_expansion = true
    name                   = "ebs-sc"
    reclaim_policy         = "Delete"
    type                   = "gp3"
    volume_binding_mode    = "WaitForFirstConsumer"
  }
  service_ipv4_cidr = "172.20.0.0/16"
  worker_nodes = {
    capacity_type = "ON_DEMAND"
    ebs_volume = {
      size = 20
      type = "gp3"
    }
    instance_type              = "t3a.medium"
    max_pods_per_node          = 17
    max_size                   = 1 # Optimizado para levantado rápido: solo 1 nodo
    max_unavailable_percentage = 50
    min_size                   = 1
    node_group_name            = "eks-managed-node-group"
    node_repair_enabled        = false # Deshabilitado para velocidad en prácticas
  }
}

tags = {
  environment = "Prod"
  service     = "demo"
}

vpc = {
  cidr_block = "10.0.0.0/16"
  private_subnet_1 = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  private_subnet_2 = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
  private_subnet_3 = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1c"
  }
  public_subnet_1 = {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-east-1a"
  }
  public_subnet_2 = {
    cidr_block        = "10.0.5.0/24"
    availability_zone = "us-east-1b"
  }
  public_subnet_3 = {
    cidr_block        = "10.0.6.0/24"
    availability_zone = "us-east-1c"
  }
}
