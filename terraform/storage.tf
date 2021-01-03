# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.myterraformgroup.name
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = format("%s/%s",var.storageAccountName,"${random_id.randomId.hex}")
    resource_group_name         = azurerm_resource_group.myterraformgroup.name
    location                    = var.locationName
    account_tier                = var.storageAccountTier
    account_replication_type    = var.storageAccountType

    tags = {
        environment = var.environment
    }
}