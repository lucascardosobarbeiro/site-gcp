variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "bucket_name" {}
variable "site_domain" {
  description = "O domínio ou hostname do site monitorado"
  type        = string
}
