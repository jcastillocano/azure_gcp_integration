# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.az_subscription_id}"
  client_id       = "${var.az_client_id}"
  client_secret   = "${var.az_client_secret}"
  tenant_id       = "${var.az_tenant_id}"
}

# create a resource group
resource "azurerm_resource_group" "default" {
  name     = "default"
  location = "${var.az_location}"
}

# Network Security Group
resource "azurerm_network_security_group" "jenkins_remote_access" {
  name                = "jenkins_remote_access"
  location            = "${var.az_location}"
  resource_group_name = "${azurerm_resource_group.default.name}"

  tags {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.default.name}"
  network_security_group_name = "${azurerm_network_security_group.jenkins_remote_access.name}"
}

resource "azurerm_network_security_rule" "http8080" {
  name                        = "http8080"
  priority                    = 1010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.default.name}"
  network_security_group_name = "${azurerm_network_security_group.jenkins_remote_access.name}"
}

# create a virtual network
resource "azurerm_virtual_network" "default" {
  name                = "default"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.az_location}"
  resource_group_name = "${azurerm_resource_group.default.name}"
}

# create subnet
resource "azurerm_subnet" "ci" {
  name                 = "ci"
  resource_group_name  = "${azurerm_resource_group.default.name}"
  virtual_network_name = "${azurerm_virtual_network.default.name}"
  address_prefix       = "10.0.1.0/24"
}

# create public IP for jenkins
resource "azurerm_public_ip" "jenkins" {
  name                         = "jenkins"
  location                     = "${var.az_location}"
  resource_group_name          = "${azurerm_resource_group.default.name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "dev"
  }
}

# Network interface for jenkins
resource "azurerm_network_interface" "jenkins" {
  name                      = "acctni"
  location                  = "${var.az_location}"
  resource_group_name       = "${azurerm_resource_group.default.name}"
  network_security_group_id = "${azurerm_network_security_group.jenkins_remote_access.id}"

  ip_configuration {
    name                          = "jenkins"
    subnet_id                     = "${azurerm_subnet.ci.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.jenkins.id}"
  }
}

resource "azurerm_managed_disk" "jenkins" {
  name                 = "jenkins"
  location             = "${var.az_location}"
  resource_group_name  = "${azurerm_resource_group.default.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1023"
}

# Jenkins instance (ubuntu)
resource "azurerm_virtual_machine" "jenkins" {
  name                  = "jenkins"
  location              = "${var.az_location}"
  resource_group_name   = "${azurerm_resource_group.default.name}"
  network_interface_ids = ["${azurerm_network_interface.jenkins.id}"]
  vm_size               = "Standard_DS1_V2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "jenkinsosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name            = "${azurerm_managed_disk.jenkins.name}"
    managed_disk_id = "${azurerm_managed_disk.jenkins.id}"
    create_option   = "Attach"
    lun             = 1
    disk_size_gb    = "${azurerm_managed_disk.jenkins.disk_size_gb}"
  }

  os_profile {
    computer_name  = "jenkins"
    admin_username = "jenkins"
    admin_password = "${var.az_jenkins_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys = [{
      path     = "/home/jenkins/.ssh/authorized_keys"
      key_data = "${var.public_ssh}"
    }]
  }

  tags {
    environment = "dev"
  }

  depends_on = ["azurerm_public_ip.jenkins"]
}

output "jenkins_ip" {
  value = "${azurerm_public_ip.jenkins.ip_address}"
}
