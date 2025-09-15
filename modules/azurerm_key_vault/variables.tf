variable "kv_name" {}
variable "location" {}
variable "rg_name" {}
variable "tags" {}
variable "secrets" {
  type    = map(string)
  default = {}
}