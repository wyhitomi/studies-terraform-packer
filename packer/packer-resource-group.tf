provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vortx-images" {
  name     = "vortx-metabase-images"
  location = "Central US"
}