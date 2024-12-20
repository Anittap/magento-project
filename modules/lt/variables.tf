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
variable "instance_type" {
  type        = map(any)
  description = "map of instance type"
}
variable "ami_id_map" {
  type        = map(any)
  description = "map of ami ids"
}
variable "key_pair" {
  type        = string
  description = "key pair"
}
variable "sg_magento_id" {
  type        = string
  description = "sg backend id"
}
variable "user_data" {
  type        = string
  description = "user data for launch template"
}
variable "name" {
  type        = string
  description = "lt name"
}
variable "alias" {
  type        = string
  description = "lt alias"
}
