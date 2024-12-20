output "sg_alb_id" {
  value = aws_security_group.alb.id
}
output "sg_elasticsearch_id" {
  value = aws_security_group.elasticsearch.id
}
output "sg_mysql_id" {
  value = aws_security_group.mysql.id
}
output "sg_magento_id" {
  value = aws_security_group.magento.id
}
output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}
