# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    count                 = var.deviceCount
    name                  = "kafka${count.index}"
    location              = var.locationName
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [element(azurerm_network_interface.myterraformnic.*.id, count.index)]
    size                  = "Standard_DS1_v2"
    computer_name         = "kafka${count.index}"
    admin_username        = "azureuser"
    disable_password_authentication = true

    os_disk {
        name              = "myOsDisk{count.index}"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_ssh_key {
        username       = "azureuser"
        public_key = file("D:\\/id_rsa.pub")
    }
    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = var.environment
    }
        provisioner "local-exec" {
        command = "ansible-playbook --private-key id_rsa -u azureuser --list-hosts ${azurerm_linux_virtual_machine.myterraformvm.public_ip}  kafka-deploy.yml"
    }
}