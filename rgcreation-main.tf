provider "azurerm" {
  version = "2.9.0"
  features {}
}

resource "azurerm_resource_group" "myterraformgroup" {
    name = "Assignment1-2021"
    location = "West US"
}   
