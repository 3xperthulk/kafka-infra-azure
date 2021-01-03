# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.locationName
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    tags = {
        environment = var.environment
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "mySubnet"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    count                        = var.deviceCount
    name                         = "myPublicIP${count.index}"
    location                     = var.locationName
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = var.environment
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
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
    name                      = "myNIC${count.index}"
    location                  = var.locationName
    resource_group_name       = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.*.id[count.index]  #[element(azurerm_public_ip.myterraformsubnet.*.id, count.index)]
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
