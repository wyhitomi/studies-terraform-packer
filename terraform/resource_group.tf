###############################################################
# 
# Terraform
# resource_group.tf
# version 0.0.1
# 
###############################################################

resource "azurerm_resource_group" "vortx" {
  name     = "${var.name}"
  location = "${var.location}"
}