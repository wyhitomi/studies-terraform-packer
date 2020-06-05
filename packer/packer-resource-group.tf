provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "vortx-metabase-images"
  location = "Central US"
}