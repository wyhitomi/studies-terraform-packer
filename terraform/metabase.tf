###############################################################
# 
# Terraform
# metabase.tf
# version 0.0.1
# 
###############################################################

resource "azurerm_virtual_network" "vortx" {
  name                = "vortx-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${var.name}"
}

resource "azurerm_subnet" "vortx" {
  name                 = "vortx-metabase-internal"
  resource_group_name  = "${var.name}"
  virtual_network_name = "vortx-metabase-internal"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "vortx" {
  name                    = "vortx-metabase-pip"
  location                = "${var.location}"
  resource_group_name     = "${var.name}"
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "testing"
    application = "metabase"
  }
}

resource "azurerm_network_interface" "vortx" {
  name                = "vortx-nic"
  location            = "${var.location}"
  resource_group_name = "${var.name}"

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

data "azurerm_image" "vortx" {
  name                = "${var.image_name}"
  resource_group_name = "vortx-metabase"
}

resource "azurerm_linux_virtual_machine" "vortx" {
  name                = "vortx-metabase-machine"
  resource_group_name = "${var.name}"
  location            = "${var.location}"
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vortx.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
  }
  
  os_disk {
    name                 = "vortx-metabase-os-disl"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.vortx.id

  tags = {
    application = "metabase"
    environment = "testing"
  }
}