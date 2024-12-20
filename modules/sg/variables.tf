variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "alb_ports" {
  type        = list(string)
  description = "alb ports"
}
variable "magento_ports" {
  type        = list(string)
  description = "magento ports"
}
variable "ssh_port" {
  type        = string
  description = "ssh port"
}
variable "mysql_ports" {
  type        = list(string)
  description = "mysql ports"
}
variable "docker_tcp_ports" {
  type        = list(string)
  description = "docker tcp ports"
}
variable "docker_udp_ports" {
  type        = list(string)
  description = "docker udp ports"
}
variable "elasticsearch_ports" {
  type        = list(string)
  description = "elasticsearch ports"
}
variable "magento_vpc_id" {
  type        = string
  description = "magento_vpc_id"
}
variable "bastion_ports" {
  type        = list(string)
  description = "bastion ports"
}

