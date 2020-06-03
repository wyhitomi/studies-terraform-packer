###############################################################
# 
# Terraform
# metabase.tf
# version 0.0.1
# 
###############################################################

provider "azurerm" {
  version         = ">=2.5.0"
  features {}
}

resource "azurerm_resource_group" "vortx" {
  name     = "vortx-metabase"
  location = "Central US"
}

# resource "azurerm_container_group" "vortx-metabase" {
#   name                =  "vortx-metabase-continst"
#   location            =  azurerm_resource_group.vortx.location
#   resource_group_name =  azurerm_resource_group.vortx.name
#   ip_address_type     =  "public"
#   dns_name_label      =  "vortx-tech-challlenge"
#   os_type             =  "Linux"

#   container {
#     name   = "metabase"
#     image  = "metabase/metabase"
#     cpu    = "0.5"
#     memory = "1.0"

#     ports {
#       port     = 3000
#       protocol = "TCP"
#     }
#   }

#   tags = {
#     environment = "testing"
#     application = "metabase"
#   }
# }

# resource "azurerm_virtual_network" "vortx" {
#   name                = "vortx-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.vortx.location
#   resource_group_name = azurerm_resource_group.vortx.name
# }

# resource "azurerm_subnet" "vortx" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.vortx.name
#   virtual_network_name = azurerm_virtual_network.vortx.name
#   address_prefix       = "10.0.2.0/24"
# }

# resource "azurerm_network_interface" "vortx" {
#   name                = "vortx-nic"
#   location            = azurerm_resource_group.vortx.location
#   resource_group_name = azurerm_resource_group.vortx.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.vortx.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "vortx" {
#   name                = "vortx-machine"
#   resource_group_name = azurerm_resource_group.vortx.name
#   location            = azurerm_resource_group.vortx.location
#   size                = "Standard_F2"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     azurerm_network_interface.vortx.id,
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/adminuser.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
# }