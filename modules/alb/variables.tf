variable "sg_id" {
  type        = string
  description = "sg id"
}
variable "name" {
  type        = string
  description = "name"
}
variable "public_subnet_ids" {
  type        = list(string)
  description = "public subnet ids"
}
variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "certificate_arn" {
  type        = string
  description = "certificate arn"
}
variable "alb_arn" {
  type        = string
  description = "alb arn"
}
variable "tg_arn" {
  type        = string
  description = "tg arn"
}
variable "zone_id" {
  type        = string
  description = "zone id"
}
variable "domain_name" {
  type        = string
  description = "domain name"
}
