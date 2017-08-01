# Azure variables

variable "az_subscription_id" {
  type        = "string"
  description = "Azure subscription id"
}

variable "az_client_id" {
  type        = "string"
  description = "Azure app Id"
}

variable "az_client_secret" {
  type        = "string"
  description = "Azure password"
}

variable "az_tenant_id" {
  type        = "string"
  description = "Azure tenant"
}
