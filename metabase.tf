provider "azurerm" {
    # e-mail: vortx-tech-challenge@outlook.com
    # 
    version = "=2.5.0"
    # subscription_id = "ddf58876-e497-4dd3-9f84-ea86f57a017a"
    # tenant_id = "4ab7a307-5400-48b1-a020-ff20a32d4e4c"
    features {}
}

resource "azurerm_resource_group" "vortx-metabase" {
  name     = "vortx-metabase"
  location = "Central US"
}

# resource "azurerm_virtual_network" "vortx-metabase" {
#   name                = "vortx-metabase-network"
#   resource_group_name = azurerm_resource_group.vortx-metabase.name
#   location            = azurerm_resource_group.vortx-metabase.location
#   address_space       = ["10.0.0.0/16"]
# }

resource "azurerm_container_group" "vortx-metabase" {
  name                = "vortx-metabase-continst"
  location            = azurerm_resource_group.vortx-metabase.location
  resource_group_name = azurerm_resource_group.vortx-metabase.name
  ip_address_type     = "public"
  dns_name_label      = "vortx-tech-challlenge"
  os_type             = "Linux"

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