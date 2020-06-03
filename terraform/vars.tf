###############################################################
# 
# Terraform
# vars.tf
# version 0.0.1
# 
###############################################################

# variable "ARM_CLIENT_ID" {}
# variable "ARM_CLIENT_SECRET" {}
# variable "ARM_SUBSCRIPTION_ID" {}
# variable "ARM_TENANT_ID" {}

variable "name" {
  default="vortx-metabase"
}

variable "location" { 
	default="Central US"
}

variable  "image_name" {
	default = "vortx-metabase-image"
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "~/.ssh/adminuser"
}

variable "PATH_TO_PUBLIC_KEY" {
	default= "~/.ssh/adminuser.pub"
}

variable "INSTANCE_USERNAME" {
	default = "vortx-metabase"
}