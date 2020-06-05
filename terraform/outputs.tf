data "azurerm_public_ip" "main" {
  name                = "${var.name}-pip"
  resource_group_name = "${var.name}-resources"
}

output "domain_name_label" {
  value = data.azurerm_public_ip.main.domain_name_label
}

output "public_ip_address" {
  value = data.azurerm_public_ip.main.ip_address
}