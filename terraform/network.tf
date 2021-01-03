# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = var.vnetName
    address_space       = [var.vnetAddressSpace]
    location            = var.locationName
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    tags = {
        environment = var.environment
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = var.subnetName
    resource_group_name  = azurerm_resource_group.myterraformgroup.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = [var.subnetAddressSpace]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    count                        = var.deviceCount
    name                         = format("%s/%s",var.publicIpName,"${count.index}")
    location                     = var.locationName
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = var.publicIpAllocationMethod

    tags = {
        environment = var.environment
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = var.networkSecurityGroup
    location            = var.locationName
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.environment
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    count                     = var.deviceCount
    name                      = format("%s/%s",var.NIC,"${count.index}")
    location                  = var.locationName
    resource_group_name       = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = var.NicConfiguration
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = var.privateIpAllocationMethod
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.*.id[count.index]  
    }

    tags = {
        environment = var.environment
    }
}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "myterraformnic" {
    count = var.deviceCount
    network_interface_id      = azurerm_network_interface.myterraformnic.*.id["${count.index}"] 
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}
