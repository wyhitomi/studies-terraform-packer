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
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = "${var.prefix}-resources"
}

resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-metabase-internal"
  resource_group_name  = "${var.prefix}-resources"
  virtual_network_name = "${var.prefix}-metabase-internal"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "main" {
  name                    = "${var.prefix}-metabase-pip"
  location                = var.location
  resource_group_name     = "${var.prefix}-resources"
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "testing"
    application = "metabase"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = "${var.prefix}-resources"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vortx.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vortx.id
  }
  tags = {
    application = "metabase"
    environment = "testing"
  }
}

data "azurerm_image" "main" {
  name                = "${var.image_name}"
  resource_group_name = "${var.prefix}-metabase"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.prefix}-metabase-machine"
  resource_group_name = "${var.prefix}-resources"
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vortx.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${var.PATH_TO_PUBLIC_KEY}")
  }
  
  os_disk {
    name                 = "${var.prefix}-metabase-os-disl"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.vortx.id

  tags = {
    application = "metabase"
    environment = "testing"
  }
}