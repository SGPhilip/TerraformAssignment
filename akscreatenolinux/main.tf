
# test

terraform {
  backend "azurerm" {
    resource_group_name  = "randstad-tfstate-rg"
    storage_account_name = "randstadtf9iydj9nc"
    container_name       = "core-tfstate"
    key                  = "test.AKS.terraform.tfstate"
  }
}

provider "azurerm" {
  version = "2.9.0"
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "myAksTerraformResourcegroup2021"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "myAksTerraformCluster2021"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "aksterraformcluster"
  
  default_node_pool {
            
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = "true"
    min_count = 1
    max_count = 10 
  }

  
  role_based_access_control {
          enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
  }
