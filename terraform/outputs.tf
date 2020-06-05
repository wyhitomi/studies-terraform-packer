###############################################################
# 
# Terraform
# outputs.tf
# version 0.0.1
# 
###############################################################
output "instance_public_ips" {
  value = ["${azurerm_public_ip.vortx.ip_address}"]
}
