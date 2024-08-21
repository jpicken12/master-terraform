terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"  
      version = "3.114.0"
    }
    azuread = {
        source = "hashicorp/azuread"
    }
  }
}

provider "azurerm" {
  features {}
}

# call the configureDesktop module
# create an Azure Virtual Desktop workspace
# create an Azure Virtual Desktop host pool
# create an Azure Desktop Application Group
# associate a Workspace and a Desktop Application Group
module "avd-cd" {
  source = "../modules/azureRm/configureDesktop"
}

# call the createHost module
# create NIC for each session host
# create VM for session host
# join VM to domain
# Register VM with Azure Virtual Desktop
module "avd-ch" {
  source = "../modules/azureRm/createHost"
}

# call the configureRbacPersmissions module
# read Microsoft Entra existing users
# create Microsoft Entra group
module "configureRbacPersmissions" {
  source = "../modules/azureRm/configureRbacPermissions"
}

# call the configureNetworkSettings module
# create a virtual network
# create a subnet
# create an NSG
# Peering the Azure Virtual Desktop vnet with hub vnet
module "configureNetworkSettings" {
  source = "../modules/azureRm/configureNetworkSettings"
}

# call the createAzureFileStorgae module
# create Azure File Storage account
# configure File Share
# configure RBAC permission on Azure File Storage
module "createAzureFileStorgae" {
  source = "../modules/azureRm/createAzureFilesStorage"
}

# call the createAzureComputeGallery module
# configure Azure Compute Gallery (formerly Shared Image Gallery)
module "createAzureComputeGallery" {
  source = "../modules/azureRm/createAzureComputeGallery"
}

# call the createLogAnalyticsWorkspace module
# configure Azure Log Analytics Workspace
module "createLogAnalyticsWorkspace" {
  source = "../modules/azureRm/createLogAnalyticsWorkspace"
}