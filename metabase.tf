provider "azurerm" {
  version         = ">=2.5.0"
  subscription_id = ${{ secrets.ARM_SUBSCRIPTION_ID }}
  client_id       = ${{ secrets.ARM_CLIENT_ID }}
  client_secret   = ${{ secrets.ARM_CLIENT_SECRET }}
  tenant_id       = ${{ secrets.ARM_TENANT_ID))
  features {}
}

resource "azurerm_resource_group" "vortx" {
  name     = "vortx-metabase"
  location = "Central US"
}

resource "azurerm_container_group" "vortx-metabase" {
  name                =  "vortx-metabase-continst"
  location            =  azurerm_resource_group.vortx.location
  resource_group_name =  azurerm_resource_group.vortx.name
  ip_address_type     =  "public"
  dns_name_label      =  "vortx-tech-challlenge"
  os_type             =  "Linux"

  container {
    name   = "metabase"
    image  = "metabase/metabase"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
    application = "metabase"
  }
}