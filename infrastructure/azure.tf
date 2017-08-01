# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.az_subscription_id}"
  client_id       = "${var.az_client_id}"
  client_secret   = "${var.az_client_secret}"
  tenant_id       = "${var.az_tenant_id}"
}

# create a resource group
resource "azurerm_resource_group" "web" {
    name = "web"
    location = "West Europe"
}
