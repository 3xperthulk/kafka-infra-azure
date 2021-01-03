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

#Network
variable "deviceCount" {
  type=number
  default=1
}