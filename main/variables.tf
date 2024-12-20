variable "cidr_block" {
  type        = string
  description = "cidr block for vpc"
}
variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "region" {
  type        = string
  description = "project region"
}
variable "owner" {
  type        = string
  description = "project owner"
}
variable "bits" {
  type        = number
  description = "subnet bit to add"
}
variable "instance_type" {
  type        = map(any)
  description = "map of instance type"
}
variable "magento_ports" {
  type        = list(string)
  description = "frontend ports"
}
variable "docker_tcp_ports" {
  type        = list(string)
  description = "docker tcp ports"
}
variable "docker_udp_ports" {
  type        = list(string)
  description = "docker udp ports"
}
variable "alb_ports" {
  type        = list(string)
  description = "alb ports"
}
variable "elasticsearch_ports" {
  type        = list(string)
  description = "frontend ports"
}
variable "mysql_ports" {
  type        = list(string)
  description = "frontend ports"
}
variable "ssh_port" {
  type        = string
  description = "ssh ports"
}
variable "ami_id_map" {
  type        = map(any)
  description = "map of ami ids"
}
variable "troubleshooting" {
  type        = bool
  description = "enable troubleshooting"
}
variable "bastion_ports" {
  type        = list(string)
  description = "bastion ports"
}
variable "enable_elb_health_checks" {
  type        = map(any)
  description = "enable elb health checks"
}
variable "magento_min_size" {
  type        = number
  description = "min size"
}
variable "magento_max_size" {
  type        = number
  description = "max size"
}
variable "magento_desired_size" {
  type        = number
  description = "desired size"
}
variable "other_min_size" {
  type        = number
  description = "min size"
}
variable "other_max_size" {
  type        = number
  description = "max size"
}
variable "other_desired_size" {
  type        = number
  description = "desired size"
}
variable "domain_name" {
  type        = string
  description = "domain name"
}
