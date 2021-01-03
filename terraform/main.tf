provider "azurerm" {
    version = "~>2.0"
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