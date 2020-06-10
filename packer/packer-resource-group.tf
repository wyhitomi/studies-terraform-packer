provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "sproutfy-images" {
  name     = "sproutfy-metabase-images"
  location = "Central US"
}