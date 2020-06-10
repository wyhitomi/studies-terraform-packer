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

resource "azurerm_resource_group" "sproutfy" {
  name      = "${var.prefix}-resources"
  location  = var.location
  tags      = {
    application = "metabase"
  }
}

resource "azurerm_virtual_network" "sproutfy" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.sproutfy.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.sproutfy.location
}

resource "azurerm_subnet" "sproutfy" {
  name                 = "${var.prefix}-network-internal"
  resource_group_name  = azurerm_resource_group.sproutfy.name
  virtual_network_name = azurerm_virtual_network.sproutfy.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "sproutfy" {
  name                    = "${var.prefix}-${var.name}-machine-pip"
  resource_group_name     = azurerm_resource_group.sproutfy.name
  location                = azurerm_resource_group.sproutfy.location
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "testing"
    application = "metabase"
  }
}

resource "azurerm_network_interface" "sproutfy" {
  name                    = "${var.prefix}-${var.name}-machine-nic"
  resource_group_name     = azurerm_resource_group.sproutfy.name
  location                = azurerm_resource_group.sproutfy.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sproutfy.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sproutfy.id
  }
  tags = {
    application = "metabase"
    environment = "testing"
  }
}

data "azurerm_image" "sproutfy" {
  name                  = "${var.image_name}"
  resource_group_name   = "${var.prefix}-metabase-images"
}

resource "azurerm_linux_virtual_machine" "sproutfy" {
  name                = "${var.prefix}-${var.name}-machine"
  resource_group_name = azurerm_resource_group.sproutfy.name
  location            = azurerm_resource_group.sproutfy.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.sproutfy.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.DEFAULT_SSH_PUBLIC_KEY
  }
  
  os_disk {
    name                 = "${var.prefix}-${var.name}-machine-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.sproutfy.id

  tags = {
    application = "metabase"
    environment = "testing"
  }
}