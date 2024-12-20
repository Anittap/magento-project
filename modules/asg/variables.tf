variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "enable_elb_health_checks" {
  type        = map(any)
  description = "enable elb health checks"
}
variable "min_size" {
  type        = number
  description = "min size"
}
variable "max_size" {
  type        = number
  description = "max size"
}
variable "desired_size" {
  type        = number
  description = "desired size"
}
variable "private_subnets" {
  type        = list(any)
  description = "list of private subnet ids"
}
variable "lt_id" {
  type        = string
  description = "launch template id"
}
variable "lt_version" {
  type        = string
  description = "launch template version"
}
variable "name" {
  type        = string
  description = "lt name"
}
variable "alias" {
  type        = string
  description = "lt alias"
}
