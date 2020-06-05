# Vortx - DevOps Tech Challenge
![Terraform](https://github.com/wyhitomi/vortx-tech-challenge/workflows/Terraform/badge.svg?branch=master)

## Dependencies

- [Terraform](https://terraform.io)
- [Packer](https://packer.io)
- [AzureCLI](https://docs.microsoft.com/pt-br/cli/azure/?view=azure-cli-latest)

## Install Dependencies for MacOS

Install Terraform

```shell
brew install terraform  
```

Install Packer

```shell
brew install packer
```

Install AzureCli

```shell
brew install azure-cli
```

## Deploy Metabase to Azure

[**Docker Version**](/docs/container_version.md)

1. Create your Azure Credentials

```shell
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>"
```

Export your Azure Keys

```shell
export ARM_CLIENT_ID=<your-client-id>
export ARM_CLIENT_SECRET=<your-client-secret>
export ARM_SUBSCRIPTION_ID=<your-subscription-id>
export ARM_TENANT_ID=<your-tenant-id>
```

*You can just login to your account using 'az login'*

2. Create the resource group.

```shell
cd terraform
terraform plan -target=azurerm_resource_group.main
terraform apply -target=azurerm_resource_group.main
```

3. Create your Packer image

```shell
packer build packer/packer.json
```

4. Deploy Metabase instance
```shell
cd terraform
terraform plan
terraform apply
```

5. Destroy infrastructure
```shell
cd terraform
terraform destroy
```

## Evaluation

- Automation
- Clean Code
- Organization

**Extras**

- Advanced Usage of choosen tool or framework
- Azure
- CI/CD

## Deliverables

Send a **zip file** to [showmethecode@vortx.com.br](mailto:showmethecode@vortx.com.br).

## Proposition: 100% automated deploy of Metabase software to an on-premises cloud infrastructure.

1. Create Instance
2. Install dependencies
3. Deploy application
4. Automate