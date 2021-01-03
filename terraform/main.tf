terraform {
  required_version = "~>0.12"
  backend "remote" {
    organization = "mehrajpatel"

    workspaces {
      name = "kafka-infra-azure"
    }
  }
}

provider "azurerm" {
    version = "~>2.0"
    # ARM_CLIENT_ID=var.ARM_CLIENT_ID
    # ARM_CLIENT_SECRET=var.ARM_CLIENT_SECRET
    # ARM_TENANT_ID=var.ARM_TENANT_ID
    # ARM_SUBSCRIPTION_ID=var.ARM_SUBSCRIPTION_ID
    features {}
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = var.rgName
    location = var.locationName

    tags = {
        environment = var.environment
    }
}