# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    count                 = var.deviceCount
    name                  = "${var.VMName}${count.index}"
    location              = var.locationName
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [element(azurerm_network_interface.myterraformnic.*.id, count.index)]
    size                  = var.VMSize
    computer_name         = "${var.ComputerName}${count.index}"
    admin_username        = var.adminUsername
    disable_password_authentication = true

    os_disk {
        name              = format("%s/%s",var.osDiskName,"${count.index}")
        caching           = var.osDiskCaching
        storage_account_type = var.osDiskStorageAccountType
    }

    source_image_reference {
        publisher = var.sourceImageReferencePublisher
        offer     = var.sourceImageReferenceOffer
        sku       = var.sourceImageReferenceSku
        version   = var.sourceImageReferenceVersion
    }

    admin_ssh_key {
        username       = var.adminUsername
        public_key = file(var.sshFilePath)
    }
    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = var.environment
    }
        provisioner "local-exec" {
        command = "ansible-playbook --private-key id_rsa -u azureuser --list-hosts ${azurerm_linux_virtual_machine.myterraformvm.*.public_ip}  kafka-deploy.yml"
    }
}