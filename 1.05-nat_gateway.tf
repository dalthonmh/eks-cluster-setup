# NAT Gateway único (colocado en la primera subnet pública)
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = "eks-nat-gateway"
  }

  depends_on = [
    aws_subnet.public_subnet_1,
    aws_eip.nat_eip
  ]
}
