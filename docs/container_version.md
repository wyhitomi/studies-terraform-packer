# Deploy Metabase Container version to Azure with Terraform

1. Create a metabase_docker.tf file

```shell
touch metabase_docker.tf
```

2. Edit metabase_docker.tf

```shell
nano metabase_docker.tf

provider "azurerm" {
  version         = ">=2.5.0"
  features {}
}

resource "azurerm_resource_group" "sproutfy" {
  name     = "sproutfy-metabase"
  location = "Central US"
}

resource "azurerm_container_group" "sproutfy-metabase" {
  name                =  "sproutfy-metabase-continst"
  location            =  azurerm_resource_group.sproutfy.location
  resource_group_name =  azurerm_resource_group.sproutfy.name
  ip_address_type     =  "public"
  dns_name_label      =  "sproutfy-tech-challlenge"
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
```

3. Initialize terraform

```shell
terraform init
```

4. Test configuration

```shell
terraform plan
```

4. Apply configuration

```shell
terraform apply
```