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

variable "prefix" {
  description 	= "sproutfy"
  default 		= "sproutfy"
}

variable "name" {
  default	= "metabase"
}

variable "location" { 
	default	= "Central US"
}

variable  "image_name" {
	default = "sproutfy-metabase-image"
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "~/.ssh/adminuser"
}

variable "DEFAULT_SSH_PUBLIC_KEY" {
	default= "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnxlC8LZCuqbZ9FGXjgRh8trYXZFtFoKk4Cha1vU0cH08+kGBuanHeqHyf09OAOW6/w+TeD4ypJakUgnHXyW1RyVek48U/hqgzGBXX8mo00liz0iIH+42+AszcGM88y/az0S0MFk5xeNFQhkR0btDOp/fvHq47/hYgMkqRFpPbgXoQmLWt0EBrc3+V37D2XcDbzoTRyCu3ZUvNRgnWWmUXpPFKtRPQZjgiEjtredNssHKLBOwCQInQVWfE5HCa0Nib9K++gRAmEPewfx+I0UPeHZPdqsI/oYmCt6i/sLuA73Bc2CDy9BWkdVsFMx4oQcPHXlnuDsUIW1bb0P797dLD8KEm0b8oIDoynR8TFIlK1sbN+x5gL5jVm0WmBBNE5yokGxpMjbQnHPbB7GTfUDC43JCd0Kmo/AVVgvFVtJ40WqYteDFOm2bB3i+LKDYXnzQ56yLdbli5frcyUtbQXimCJs58x/Y9M6AuvNfNVj61PuHdMNRIzTTQ6c25NAZsgFPSXdA3iwSChN2N36fEtKug3d8KW3EhUBlr2fOTCJ4ZDniW0/lhulMT0U9CW1tXJL3oJft6UBBDBBlAKhaZqqW50NcIklvm7xFj6cFwOHqGu1nht8jVzRxsPD5GeVYS7sGvTmJy/7670gkwIrnEb3i9LtaagNdYWn+wVluJfXc/hQ== adminuser"
}

variable "INSTANCE_USERNAME" {
	default = "sproutfy-metabase"
}