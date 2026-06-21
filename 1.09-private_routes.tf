# Todas las subredes privadas usan el mismo NAT Gateway (single NAT)
resource "aws_route" "nat_route_1" {
  route_table_id         = aws_route_table.private_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

  depends_on = [
    aws_route_table.private_route_table_1,
    aws_nat_gateway.nat_gateway
  ]
}

resource "aws_route" "nat_route_2" {
  route_table_id         = aws_route_table.private_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

  depends_on = [
    aws_route_table.private_route_table_2,
    aws_nat_gateway.nat_gateway
  ]
}

resource "aws_route" "nat_route_3" {
  route_table_id         = aws_route_table.private_route_table_3.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

  depends_on = [
    aws_route_table.private_route_table_3,
    aws_nat_gateway.nat_gateway
  ]
}
