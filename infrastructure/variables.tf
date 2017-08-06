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

variable "az_location" {
  type        = "string"
  description = "Azure location"
  default     = "ukwest"
}

variable "az_jenkins_password" {
  type        = "string"
  description = "Jenkins ssh password"
}

variable "public_ssh" {
  type        = "string"
  description = "SSH public key value"
}

variable "private_ssh" {
  type        = "string"
  description = "SSH private key path"
  default     = "~/.ssh/id_rsa"
}

# Google variables

variable "google_project" {
  type        = "string"
  description = "Google Cloud project name"
}

variable "google_region" {
  type        = "string"
  description = "Google Cloud region"
  default     = "europe-west1-d"
}

variable "google_sql_password" {
  type        = "string"
  description = "MySQL server password"
}
