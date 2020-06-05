###############################################################
# 
# Terraform
# main.tf
# version 0.0.1
# 
###############################################################

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.name}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = "${var.name}-resources"
}

resource "azurerm_subnet" "main" {
  name                 = "${var.name}-internal"
  resource_group_name  = "${var.name}-resources"
  virtual_network_name = "${var.name}-network"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "main" {
  name                    = "${var.name}-pip"
  location                = var.location
  resource_group_name     = "${var.name}-resources"
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "testing"
    application = "metabase"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = "${var.name}-resources"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
  tags = {
    application = "metabase"
    environment = "testing"
  }
}

data "azurerm_image" "main" {
  name                  = "${var.image_name}"
  resource_group_name   = "${var.name}-images"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.name}-machine"
  resource_group_name = "${var.name}-resources"
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.DEFAULT_SSH_PUBLIC_KEY
  }
  
  os_disk {
    name                 = "${var.name}-os-disl"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.main.id

  tags = {
    application = "metabase"
    environment = "testing"
  }
}