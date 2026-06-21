# Usamos SOLO 1 NAT Gateway (para desarrollo/pruebas).
# Esto reduce significativamente el tiempo de creación (cada NAT tarda 5-10 min).
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "eks-nat-eip"
  }
}
