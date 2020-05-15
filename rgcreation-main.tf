provider "azurerm" {
  version = "2.9.0"
  features {}
}

resource "azurerm_resource_group" "myterraformgroup" {
    name = "RandstadtestRGcreation2020"
    location = "West US"
}   
