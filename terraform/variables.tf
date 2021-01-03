#Environment
variable "rgName" {
  type=string
  default="rg-name"
}

variable "locationName" {
  type=string
  default="eastus"
}

variable "environment" {
  type=string
  default="kafka"
}

#Credentials

variable "ARM_CLIENT_ID" {
  type=string
}

variable "ARM_CLIENT_SECRET" {
  type=string
}

variable "ARM_TENANT_ID" {
  type=string
}

variable "ARM_SUBSCRIPTION_ID" {
  type=string
}

#Network
variable "deviceCount" {
  type=number
  default=1
}

variable "vnetName" {
  type=string
  default="MyVnet"
}

variable "vnetAddressSpace" {
  type=string
  default="10.0.0.0/16"
}

variable "subnetName" {
  type=string
  default="mySubnet"
}

variable "subnetAddressSpace" {
  type=string
  default="10.0.1.0/24"
}

variable "publicIpName" {
  type=string
  default="myPublicIP"
}

variable "publicIpAllocationMethod" {
  type=string
  default="Dynamic"
}

variable "networkSecurityGroup" {
  type=string
  default="myNetworkSecurityGroup"
}

variable "NIC" {
  type=string
  default="myNIC"
}

variable "privateIpAllocationMethod" {
  type=string
  default="Dynamic"
}

variable "NicConfiguration" {
  type=string
  default="myNicConfiguration"
}

#Storage

variable "storageAccountName" {
  type=string
  default="kafka-storage"
}

variable "storageAccountTier" {
  type=string
  default="Standard"
}

variable "storageAccountType" {
  type=string
  default="LRS"
}

#Virtual Machines

variable "VMName" {
  type=string
  default="kafka"
}

variable "VMSize" {
  type=string
  default="Standard_DS1_v2"
}

variable "ComputerName" {
  type=string
  default="kafka"
}

variable "adminUsername" {
  type=string
  default="azureuser"
}
   
variable "osDiskName" {
  type=string
  default="myOsDisk"
}

variable "osDiskCaching" {
  type=string
  default="ReadWrite"
}

variable "osDiskStorageAccountType" {
  type=string
  default="Premium_LRS"
}

variable "sourceImageReferencePublisher" {
  type=string
  default="Canonical"
}

variable "sourceImageReferenceOffer" {
  type=string
  default="UbuntuServer"
}

variable "sourceImageReferenceSku" {
  type=string
  default="18.04-LTS"
}

variable "sourceImageReferenceVersion" {
  type=string
  default="latest"
}

variable "sshFilePath" {
  type=string
  default="./id_rsa.pub"
}