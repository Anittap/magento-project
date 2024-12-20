output "vpc_id" {
  value = aws_vpc.magento.id
}
output "public1" {
  value = aws_subnet.public[0].id
}
output "public2" {
  value = aws_subnet.public[1].id
}
output "public3" {
  value = aws_subnet.public[2].id
}
output "private1" {
  value = aws_subnet.private[0].id
}
output "private2" {
  value = aws_subnet.private[1].id
}
output "private3" {
  value = aws_subnet.private[2].id
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
